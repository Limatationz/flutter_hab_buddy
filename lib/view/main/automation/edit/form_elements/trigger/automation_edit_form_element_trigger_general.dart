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

  const AutomationEditFormElementTriggerGeneral({
    super.key,
    required this.configuration,
    required this.onChanged, required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    switch (configuration) {
      case RuleTriggerCronConfiguration e:
        return AutomationEditFormElementTriggerCron(
          configuration: e,
          onChanged: onChanged,
          onDelete: onDelete,
        );
      case RuleTriggerSystemStartConfiguration e:
        return AutomationEditFormElementTriggerSystemStart(
          configuration: e,
          onChanged: onChanged,
          onDelete: onDelete,
        );
      case RuleTriggerItemConfiguration e:
        return AutomationEditFormElementTriggerItem(
          configuration: e,
          onChanged: onChanged,
          onDelete: onDelete,
        );
      default:
        return Text("Not implemented yet: ${configuration.runtimeType}");
    }
  }
}
