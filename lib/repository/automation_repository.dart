import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../core/database/app_database.dart';
import '../core/database/rules/rule_trigger.dart';
import '../core/database/rules/rules_table.dart';
import '../core/network/converters/rule.dart';
import '../core/network/generated/openHAB.swagger.dart' hide Rule;
import '../generated/l10n.dart';
import '../locator.dart';
import '../view/util/general/alert_dialog_action.dart';
import 'login_repository.dart';

class AutomationRepository {
  final _log = Logger();
  final _loginRepository = locator<LoginRepository>();
  final _store = locator<AppDatabase>().rulesStore;

  Stream<List<Rule>> get rules => _store.all().watch();

  Stream<bool> get automationEnabled => _loginRepository.hasApiAccessStream;

  AutomationRepository() {
    _store.all().watch().listen((event) {
      print('Rules updated');
    });
  }

  Future<void> fetchData() async {
    await _loginRepository.firstConnectionComplete.future;
    final result = await locator<OpenHAB>().rulesGet();
    if (result.isSuccessful) {
      final storedRules = await _store.all().get();

      for (final rule in result.body!) {
        final storedRule =
            storedRules.firstWhereOrNull((element) => element.uid == rule.uid);
        final dbRule = rule.asDatabaseModel();
        if (dbRule == null) {
          print('Rule is not valid. Uid: ${rule.uid}');
          continue;
        } else {
          // check for auto deletion
          final isAutoDeleted = _checkIfRuleCanBeAutoDeleted(dbRule);
          if (isAutoDeleted) {
            continue;
          }

          if (storedRule == null) {
            // Item is not stored yet
            _store.insertOrUpdateSingle(dbRule.toCompanion(true));
          } else {
            // Item is already stored -> update
            _store.insertOrUpdateSingle(dbRule.toCompanion(true));
          }

          // remove from storedRules
          storedRules.removeWhere((element) => element.uid == rule.uid);
        }
      }

      // Delete all rules that are not available anymore
      for (final rule in storedRules) {
        await _store.deleteDataByUid(rule.uid);
      }
    } else {
      print(result.error);
    }
  }

  bool _checkIfRuleCanBeAutoDeleted(Rule rule) {
    if (rule.autoDelete) {
      bool hasOnlyDateTriggers = rule.triggers?.every((e) =>
              e.type == RuleTriggerType.cron &&
              (e.configuration as RuleTriggerCronConfiguration)
                  .cronExpression
                  .isSingleSpecificDate) ??
          false;
      if (hasOnlyDateTriggers) {
        // check if all triggers are in the past
        final now = DateTime.now();
        bool isAllDateTriggersBeforeNow = true;
        for (final trigger in rule.triggers!) {
          final cronDate =
              (trigger.configuration as RuleTriggerCronConfiguration)
                  .cronExpression
                  .toDateTime();
          if (cronDate?.isAfter(now) ?? false) {
            isAllDateTriggersBeforeNow = false;
          }
        }

        if (isAllDateTriggersBeforeNow) {
          _log.i("Rule ${rule.uid} can be auto deleted");
          deleteRule(rule.uid);
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> onRuleTriggered(
      BuildContext context, Rule rule, bool needsConfirm) async {
    final confirmed = !needsConfirm
        ? false
        : await showAdaptiveDialog<bool?>(
            context: context,
            builder: (context) => AlertDialog.adaptive(
                  content: Text.rich(TextSpan(children: [
                    TextSpan(text: S.of(context).confirmTriggerRuleAlertText1),
                    TextSpan(
                        text: " ${rule.name ?? rule.uid} ",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: S.of(context).confirmTriggerRuleAlertText2,
                    ),
                  ])),
                  actions: [
                    AlertDialogAction(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(S.of(context).cancel)),
                    AlertDialogAction(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(S.of(context).confirm))
                  ],
                ));
    if (confirmed == true) {
      return triggerRule(rule.uid);
    } else {
      return false;
    }
  }

  Future<bool> triggerRule(String ruleUid) async {
    final result = await locator<OpenHAB>()
        .rulesRuleUIDRunnowPost(ruleUID: ruleUid, body: null);
    return result.isSuccessful;
  }

  Future<bool> onRuleDelete(
      BuildContext context, Rule rule, bool needsConfirm) async {
    if (!rule.editable) {
      // User is not allowed to delete this rule
      return false;
    }

    final confirmed = !needsConfirm
        ? false
        : await showAdaptiveDialog<bool?>(
            context: context,
            builder: (context) => AlertDialog.adaptive(
                  content: Text.rich(TextSpan(children: [
                    TextSpan(text: S.of(context).confirmDeleteRuleAlertText),
                    TextSpan(
                        text: " ${rule.name ?? rule.uid}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ])),
                  actions: [
                    AlertDialogAction(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(S.of(context).cancel)),
                    AlertDialogAction(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(S.of(context).confirm))
                  ],
                ));
    if (confirmed == true) {
      return deleteRule(rule.uid);
    } else {
      return false;
    }
  }

  Future<bool> deleteRule(String ruleUid) async {
    final result =
        await locator<OpenHAB>().rulesRuleUIDDelete(ruleUID: ruleUid);
    if (result.isSuccessful) {
      await _store.deleteDataByUid(ruleUid);
      return true;
    } else {
      return false;
    }
  }

  Stream<int> countRulesForItemNameStream(String itemName) {
    return _store
        .editableByItemName(itemName)
        .watch()
        .map((event) => event.length);
  }

  Stream<List<Rule>> rulesForItemNameStream(String itemName) {
    return _store.editableByItemName(itemName).watch();
  }

  Future<bool> postRule(RuleDTO newRule) async {
    // add details
    final newUid = const Uuid().v1();
    final enrichedRule = newRule.copyWith(
        tags: [ruleAppTag, ...newRule.tags ?? []],
        uid: newRule.uid ?? newUid,
        name: newRule.name);

    final result = await locator<OpenHAB>().rulesPost(body: enrichedRule);
    if (result.statusCode == 201) {
      // get rule from server
      final result =
          await locator<OpenHAB>().rulesRuleUIDGet(ruleUID: enrichedRule.uid);

      if (result.isSuccessful) {
        final dbRule = result.body!.asDatabaseModel();
        if (dbRule != null) {
          await _store.insertOrUpdateSingle(dbRule.toCompanion(true));
        }
      }

      return true;
    } else if (result.statusCode == 400) {
      _log.e("Creation of the rule is refused. Missing required parameter.");
      return false;
    } else if (result.statusCode == 409) {
      _log.e(
          "Creation of the rule is refused. Rule with the same UID already exists..");
      return false;
    } else {
      _log.e(("Unknown status: ${result.statusCode}"));
      return false;
    }
  }
}
