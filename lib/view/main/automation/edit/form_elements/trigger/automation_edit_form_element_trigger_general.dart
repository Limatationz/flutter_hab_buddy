import 'package:flutter/material.dart';

import '../../../../../../core/database/rules/rule_trigger.dart';
import 'automation_edit_form_element_trigger_cron.dart';
import 'automation_edit_form_element_trigger_item.dart';
import 'automation_edit_form_element_trigger_system_start.dart';

typedef RuleTriggerConfigurationCallback = Function(
    RuleTriggerConfiguration newValue);

typedef RuleTriggerConfigurationDeleteCallback = Function();

class AutomationEditFormElementTriggerGeneral extends StatelessWidget {
  final RuleTriggerConfiguration configuration;
  final RuleTriggerConfigurationCallback onChanged;
  final RuleTriggerConfigurationDeleteCallback onDelete;
  final int? listIndex;
  final bool enabled;

  const AutomationEditFormElementTriggerGeneral({
    super.key,
    required this.configuration,
    required this.onChanged,
    required this.onDelete,
    required this.enabled,
    this.listIndex,
  });

  @override
  Widget build(BuildContext context) {
    switch (configuration) {
      case RuleTriggerCronConfiguration e:
        return AutomationEditFormElementTriggerCron(
          configuration: e,
          onChanged: onChanged,
          onDelete: onDelete,
          listIndex: listIndex,
          enabled: enabled,
        );
      case RuleTriggerSystemStartConfiguration e:
        return AutomationEditFormElementTriggerSystemStart(
          configuration: e,
          onChanged: onChanged,
          onDelete: onDelete,
          listIndex: listIndex,
          enabled: enabled,
        );
      case RuleTriggerItemConfiguration e:
        return AutomationEditFormElementTriggerItem(
          configuration: e,
          onChanged: onChanged,
          onDelete: onDelete,
          listIndex: listIndex,
          enabled: enabled,
        );
      default:
        return Text("Not implemented yet: ${configuration.runtimeType}");
    }
  }
}
