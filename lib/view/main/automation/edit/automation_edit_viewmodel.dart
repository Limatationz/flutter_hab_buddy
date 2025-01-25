import 'package:collection/collection.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../../../core/database/items/items_table.dart';
import '../../../../core/database/rules/rule_trigger.dart';
import '../../../../core/database/rules/rules_table.dart';
import '../../../../core/network/generated/openHAB.swagger.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../repository/automation_repository.dart';
import 'automation_edit_view.dart';
import 'automation_edit_view_arguments.dart';
import 'form_elements/action/automation_edit_form_element_action_general.dart';

class AutomationEditViewModel extends BaseViewModel {
  final _log = Logger();
  final _rulesStore = locator<db.AppDatabase>().rulesStore;
  final _itemsStore = locator<db.AppDatabase>().itemsStore;
  final _automationRepository = locator<AutomationRepository>();

  // arguments
  final AutomationEditViewArguments? args;
  db.Rule? initialRule;
  db.Item? itemOpenedBy;
  final AutomationEditViewExtraArguments? extra;

  // triggers
  List<RuleTriggerEntry>? triggers;

  // actions
  List<RuleAction>? actions;

  // options
  RuleOptions options = RuleOptions();

  bool get isLoading => actions == null;

  bool get isNew => args?.initialRuleUid?.isEmpty ?? true;

  bool get canEdit => isNew || (initialRule?.editable ?? false);

  AutomationEditViewModel(
    this.args,
    this.extra,
  ) {
    if (!isNew) {
      // rule is not new
      _rulesStore
          .byUid(args!.initialRuleUid!)
          .getSingleOrNull()
          .then((rule) async {
        if (rule != null) {
          initialRule = rule;

          // get triggers
          triggers = rule.triggers
                  ?.map((e) => RuleTriggerEntry(e.type, e.configuration))
                  .toList() ??
              [];

          // get actions
          actions = await _getActions(rule);

          // get options
          options = rule.options;

          notifyListeners();
        } else {
          _log.e("Rule ${args!.initialRuleUid} not found");
        }
      });

      // get item
      if (args?.itemNameOpenedBy?.isNotEmpty ?? false) {
        _itemsStore
            .byName(args!.itemNameOpenedBy!)
            .getSingleOrNull()
            .then((item) {
          itemOpenedBy = item;
        });
      }
    } else {
      // add triggers from args
      triggers = extra?.initialTriggers
              ?.map((e) => RuleTriggerEntry.fromRuleTrigger(e))
              .toList() ??
          [];

      if (args?.itemNameOpenedBy?.isNotEmpty ?? false) {
        _itemsStore
            .getByNameWithState(args!.itemNameOpenedBy!)
            .then((itemWithState) {
          itemOpenedBy = itemWithState?.item;
          if (itemWithState != null) {
            actions = [
              RuleActionItem(itemWithState, RuleActionItemCommand.sendCommand,
                  itemWithState.item.defaultValue),
            ];

            notifyListeners();
          } else {
            _log.e("Item ${args!.itemNameOpenedBy!} not found");
          }
        });
      } else {
        // rule was opened without item
        actions = [];
        notifyListeners();
      }
    }
  }

  Future<List<RuleAction>> _getActions(db.Rule rule) async {
    final actions = rule.actions;
    if (actions?.isEmpty ?? true) {
      return [];
    } else {
      List<RuleAction> result = [];

      final listOfItemActions = actions!
          .where((action) =>
              (action.type == "core.ItemCommandAction" ||
                  action.type == "core.ItemStateUpdateAction") &&
              action.configuration != null &&
              action.configuration!.containsKey("itemName") &&
              action.configuration!.containsKey("command"))
          .map((action) => (
                action.configuration!["itemName"] as String,
                RuleActionItemCommand.fromOpenHabType(action.type!),
                action.configuration!["command"]
              ))
          .toList();

      // fetch items from database
      final listWithItemsFutures = listOfItemActions.map((e) async {
        final item = await _itemsStore.getByNameWithState(e.$1);
        return (item, e);
      }).toList();

      final listWithItems = await Future.wait(listWithItemsFutures);

      // filter out not found items
      final noteFoundItems =
          listWithItems.where((element) => element.$1 == null);

      if (noteFoundItems.isNotEmpty) {
        for (final item in noteFoundItems) {
          _log.e("Item ${item.$2.$1} not found");
        }
      }

      listWithItems.removeWhere((element) => element.$1 == null);

      // create map
      final itemActions = listWithItems
          .map((e) => RuleActionItem(e.$1!, e.$2.$2, e.$2.$3))
          .toList();

      result.addAll(itemActions);

      // get action scripts
      final scriptActions = actions
          .where((action) =>
              action.type == "script.ScriptAction" &&
              (action.configuration?.containsKey("script") ?? false))
          .map((action) =>
              RuleActionScript(action.configuration!["script"] as String))
          .toList();

      result.addAll(scriptActions);

      return result;
    }
  }

  Future<List<RuleAction>> _getActionScripts(db.Rule rule) async {
    final actions = rule.actions;
    if (actions?.isEmpty ?? true) {
      return [];
    } else {
      final list = actions!
          .where((action) =>
              action.type == "core.ScriptAction" &&
              action.configuration != null)
          .map((action) =>
              RuleActionScript(action.configuration!["script"] as String))
          .toList();
      return list;
    }
  }

  void updateAction(int index, RuleAction action) {
    actions![index] = action;
    notifyListeners();
  }

  void updateTriggerConfigurationAtIndex(
      int index, RuleTriggerConfiguration configuration) {
    final oldValue = triggers?[index];

    if (oldValue == null) {
      _log.e("Configuration for index $index is null");
    } else {
      triggers![index] = RuleTriggerEntry(oldValue.type, configuration);
      notifyListeners();
    }
  }

  void deleteTriggerConfigurationAtIndex(int index) {
    final removedEntry = triggers?.removeAt(index);

    if (removedEntry == null) {
      _log.e("No configuration for index $index");
    } else {
      notifyListeners();
    }
  }

  void reorderTriggers(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final entry = triggers?.removeAt(oldIndex);
    if (entry != null) {
      triggers?.insert(newIndex, entry);
      notifyListeners();
    }
  }

  Future<bool> createRule() async {
    // check if scheduled time is set and action items are set
    if ((triggers?.isEmpty ?? true) ||
        (actions?.isEmpty ?? true)) {
      _log.e("triggers or action items not set");
      return false;
    }

    // check if all triggers are valid
    for (final trigger in triggers!) {
      if (!trigger.validate()) {
        _log.e("triggers are not valid: ${trigger}");
        return false;
      }
    }

    // check if all actions are valid
    for (final actionItem in actions!) {
      if (!actionItem.validate()) {
        _log.e("actions are not valid: ${actionItem}");
        return false;
      }
    }

    // create RuleDto
    final ruleDto = RuleDTO(
        name: options.name ?? _generateRuleName(),
        tags: [
          if (options.autoDelete) autoDeleteTag,
        ],
        triggers: triggers!
            .mapIndexed(
                (index, entry) => RuleTrigger.toTriggerDto(index, entry))
            .toList(),
        actions: actions!
            .mapIndexed((index, e) => e.toActionDto(index))
            .toList());

    // post Rule
    return await _automationRepository.postRule(ruleDto);
  }

  Future<bool> updateRule() {
    // TODO
    return Future.value(false);
  }

  // TODO
  String _generateRuleName() => const Uuid().v4().toString();

  void addTrigger(RuleTrigger trigger) {
    triggers ??= [];
    triggers?.add(RuleTriggerEntry(trigger.type, trigger.configuration));
    notifyListeners();
  }

  void changeAutoDeleteOption(bool autoDelete) {
    options = options.copyWith(autoDelete: autoDelete);
    notifyListeners();
  }

  bool get autoDeleteOptionEnabled =>
      (triggers?.isNotEmpty ?? false) &&
      (triggers?.every((e) =>
              e.configuration is RuleTriggerCronConfiguration &&
              (e.configuration as RuleTriggerCronConfiguration)
                  .cronExpression
                  .isSingleSpecificDate) ??
          false);

  void changeRuleName(String name) {
    options = options.copyWith(name: name);
    notifyListeners();
  }

  void addEmptyItemAction() {
    actions ??= [];
    actions?.add(RuleActionItem(null, null, null));
    notifyListeners();
  }

  deleteAction(int index) {
    actions?.removeAt(index);
    notifyListeners();
  }

  void addEmptyScriptAction() {
    actions ??= [];
    actions?.add(RuleActionScript(""));
    notifyListeners();
  }
}

class RuleTriggerEntry {
  final String type;
  final RuleTriggerConfiguration configuration;

  bool validate() => configuration.validate();

  RuleTriggerEntry(this.type, this.configuration);

  factory RuleTriggerEntry.fromRuleTrigger(RuleTrigger trigger) =>
      RuleTriggerEntry(trigger.type, trigger.configuration);
}

class RuleOptions {
  final bool autoDelete;
  final String? name;

  RuleOptions({this.autoDelete = false, this.name});

  // copyWith
  RuleOptions copyWith({bool? autoDelete, String? name}) => RuleOptions(
      autoDelete: autoDelete ?? this.autoDelete, name: name ?? this.name);
}
