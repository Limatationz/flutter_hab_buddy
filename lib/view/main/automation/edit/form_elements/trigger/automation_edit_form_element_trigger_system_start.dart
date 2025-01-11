import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/database/rules/rule_trigger.dart';
import '../../../../../../util/icons/LineIconsV5_icons.dart';
import '../../../../../util/constants.dart';
import 'automation_edit_form_element_trigger_general.dart';

class AutomationEditFormElementTriggerSystemStart extends StatelessWidget {
  final RuleTriggerSystemStartConfiguration configuration;
  final RuleTriggerConfigurationCallback onChanged;
  final RuleTriggerConfigurationDeleteCallback onDelete;

  const AutomationEditFormElementTriggerSystemStart(
      {super.key,
      required this.configuration,
      required this.onChanged,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final level = configuration.startLevel;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(
            child: Text("System Start",
                style: Theme.of(context).textTheme.bodyLarge)),
        IconButton(onPressed: onDelete, icon: const Icon(LineIconsV5.trash_1))
      ]),
      const Gap(smallPadding),
      FormBuilderDropdown<RuleTriggerSystemStartConfigurationLevel>(
        name: "level",
        initialValue: configuration.startLevel,
        items: RuleTriggerSystemStartConfigurationLevel.values.map((level) {
          return DropdownMenuItem(
            value: level,
            child: Text(level.localizedValue),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            onChanged.call(
                RuleTriggerSystemStartConfiguration(startLevel: newValue));
          }
        },
      ),
    ]);
  }
}
