import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:gap/gap.dart';
import 'package:highlight/languages/javascript.dart';

import '../../../../../../core/database/app_database.dart';
import '../../../../../../core/database/items/items_table.dart';
import '../../../../../../core/network/generated/openHAB.swagger.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../util/icons/LineIconsV5_icons.dart';
import '../../../../../util/constants.dart';
import 'automation_edit_form_element_action_item.dart';
import 'automation_edit_form_element_action_script.dart';

typedef RuleActionCallback = Function(RuleAction newValue);

typedef RuleActionDeleteCallback = Function();

class AutomationEditFormElementActionGeneral extends StatelessWidget {
  final RuleAction action;
  final RuleActionCallback onChanged;
  final RuleActionDeleteCallback onDelete;

  const AutomationEditFormElementActionGeneral(
      {super.key,
      required this.action,
      required this.onChanged,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
              child: Text(action.label,
                  style: Theme.of(context).textTheme.bodyLarge)),
          IconButton(onPressed: onDelete, icon: const Icon(LineIconsV5.trash_1))
        ]),
        const Gap(mediumPadding),
        Builder(builder: (context) {
          switch (action) {
            case RuleActionItem e:
              return AutomationEditFormElementActionItem(
                  action: e, onChanged: onChanged);
            case RuleActionScript e:
              return AutomationEditFormElementActionScript(
                  action: e, onChanged: onChanged);
            default:
              return Text("Not implemented yet: ${action.runtimeType}");
          }
        })
      ],
    );
  }
}

abstract class RuleAction {
  String get label;

  ActionDTO toActionDto(int index);

  bool validate();
}

class RuleActionItem extends RuleAction {
  final ItemWithState? item;
  final RuleActionItemCommand? commandType;
  final dynamic value;

  @override
  String get label => item?.item.label ?? S.current.itemAction;

  RuleActionItem(this.item, this.commandType, this.value);

  @override
  ActionDTO toActionDto(int index) {
    return ActionDTO(
        id: "updateItemAction-$index",
        type: commandType!.openhabType,
        configuration: {"itemName": item!.item.ohName, "command": value});
  }

  @override
  bool validate() => item != null && commandType != null && value != null;

  RuleActionItem copyWith({ItemWithState? item, RuleActionItemCommand? commandType, dynamic value}) {
    return RuleActionItem(item ?? this.item, commandType ?? this.commandType,
        value ?? this.value);
  }
}

enum RuleActionItemCommand {
  postUpdate,
  sendCommand;

  String get openhabType {
    switch (this) {
      case RuleActionItemCommand.postUpdate:
        return "core.ItemStateUpdateAction";
      case RuleActionItemCommand.sendCommand:
        return "core.ItemCommandAction";
    }
  }
  
  String get label {
    switch (this) {
      case RuleActionItemCommand.postUpdate:
        return S.current.postUpdateCommandLabel;
      case RuleActionItemCommand.sendCommand:
        return S.current.sendCommandCommandLabel;
    }
  }

  static RuleActionItemCommand fromOpenHabType(String type) {
    switch (type) {
      case "core.ItemStateUpdateAction":
        return RuleActionItemCommand.postUpdate;
      case "core.ItemCommandAction":
        return RuleActionItemCommand.sendCommand;
      default:
        return RuleActionItemCommand.postUpdate;
    }
  }
}

class RuleActionScript extends RuleAction {
  final String script;
  final CodeController controller;

  @override
  String get label => S.current.script;

  RuleActionScript(this.script)
      : controller = CodeController(
          text: script,
          language: javascript,
        );

  @override
  ActionDTO toActionDto(int index) {
    return ActionDTO(
        type: "script.ScriptAction",
        id: "scriptAction-$index",
        configuration: {
          "type": "application/vnd.openhab.dsl.rule",
          "script": controller.text
        });
  }

  @override
  bool validate() {
    return controller.text.isNotEmpty;
  }
}
