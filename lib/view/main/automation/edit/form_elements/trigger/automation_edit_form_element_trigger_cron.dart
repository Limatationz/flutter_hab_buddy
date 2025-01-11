import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/database/rules/rule_trigger.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../util/icons/LineIconsV5_icons.dart';
import '../../../../../util/constants.dart';
import '../../../../../util/cron/cron_expression.dart';
import '../../../../../util/cron/cron_form_field.dart';
import '../../../../../util/cron/enums/cron_expression_output_format.dart';
import 'automation_edit_form_element_trigger_general.dart';

class AutomationEditFormElementTriggerCron extends StatelessWidget {
  final RuleTriggerCronConfiguration configuration;
  final RuleTriggerConfigurationCallback onChanged;
  final RuleTriggerConfigurationDeleteCallback onDelete;

  const AutomationEditFormElementTriggerCron(
      {super.key,
      required this.configuration,
      required this.onChanged,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final singleDateSelect = configuration.cronExpression.isSingleSpecificDate;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(
            child: Text("Time Trigger",
                style: Theme.of(context).textTheme.bodyLarge)),
        IconButton(onPressed: onDelete, icon: const Icon(LineIconsV5.trash_1))
      ]),
      const Gap(smallPadding),
      SegmentedButton(
          segments: const [
            ButtonSegment(value: 0, label: Text("Repeating")),
            ButtonSegment(value: 1, label: Text("Once")),
          ],
          selectedIcon: const Icon(LineIconsV5.check),
          selected: <int>{singleDateSelect ? 1 : 0},
          onSelectionChanged: (Set<int> newSelection) {
            if (newSelection.first == 1) {
              // single date select
              // check if current cron expression is already specific
              if (!configuration.cronExpression.isSingleSpecificDate) {
                onChanged.call(RuleTriggerCronConfiguration(
                    cronExpression: CronExpression.now()));
              }
            } else {
              // repeating
              if (configuration.cronExpression.isSingleSpecificDate) {
                onChanged.call(RuleTriggerCronConfiguration(
                    cronExpression: CronExpression.everyHour()));
              }
            }
          }),
      const Gap(mediumPadding),
      AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: singleDateSelect
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  FormBuilderDateTimePicker(
                    name: "date",
                    firstDate: DateTime.now(),
                    initialValue: configuration.cronExpression.toDateTime(),
                    key: ValueKey(configuration.cronExpression
                        .toDateTime()
                        ?.microsecondsSinceEpoch),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression:
                                CronExpression.fromDateTime(newValue)));
                      }
                    },
                  ),
                  const Gap(mediumPadding),
                  Wrap(
                      spacing: smallPadding,
                      runSpacing: smallPadding,
                      children: [
                        ActionChip(
                          label: Text(
                            S.of(context).timeTriggerIn1Min,
                          ),
                          onPressed: () {
                            onChanged.call(RuleTriggerCronConfiguration(
                                cronExpression: CronExpression.fromDateTime(
                                    DateTime.now().add(Duration(minutes: 1)))));
                          },
                        ),
                    ActionChip(
                      label: Text(
                        S.of(context).timeTriggerIn5Min,
                      ),
                      onPressed: () {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression: CronExpression.fromDateTime(
                                DateTime.now().add(Duration(minutes: 5)))));
                      },
                    ),
                    ActionChip(
                      label: Text(
                        S.of(context).timeTriggerIn10Min,
                      ),
                      onPressed: () {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression: CronExpression.fromDateTime(
                                DateTime.now().add(Duration(minutes: 10)))));
                      },
                    ),
                    ActionChip(
                      label: Text(
                        S.of(context).timeTriggerIn30Min,
                      ),
                      onPressed: () {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression: CronExpression.fromDateTime(
                                DateTime.now().add(Duration(minutes: 30)))));
                      },
                    ),
                    ActionChip(
                      label: Text(
                        S.of(context).timeTriggerIn1H,
                      ),
                      onPressed: () {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression: CronExpression.fromDateTime(
                                DateTime.now().add(Duration(minutes: 60)))));
                      },
                    ),
                    ActionChip(
                      label: Text(
                        S.of(context).timeTriggerIn2H,
                      ),
                      onPressed: () {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression: CronExpression.fromDateTime(
                                DateTime.now().add(Duration(minutes: 120)))));
                      },
                    ),
                    ActionChip(
                      label: Text(
                        S.of(context).timeTriggerIn12H,
                      ),
                      onPressed: () {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression: CronExpression.fromDateTime(
                                DateTime.now()
                                    .add(Duration(minutes: 12 * 60)))));
                      },
                    ),
                    ActionChip(
                      label: Text(
                        S.of(context).timeTriggerIn1Day,
                      ),
                      onPressed: () {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression: CronExpression.fromDateTime(
                                DateTime.now()
                                    .add(Duration(minutes: 24 * 60)))));
                      },
                    ),
                    ActionChip(
                      label: Text(
                        S.of(context).timeTriggerIn2Days,
                      ),
                      onPressed: () {
                        onChanged.call(RuleTriggerCronConfiguration(
                            cronExpression: CronExpression.fromDateTime(
                                DateTime.now()
                                    .add(Duration(minutes: 24 * 60 * 2)))));
                      },
                    ),
                  ])
                ])
              : CronFormField(
                  key: Key(configuration.cronExpression
                      .toFormatString(CronExpressionOutputFormat.AUTO)),
                  initialValue: configuration.cronExpression
                      .toFormatString(CronExpressionOutputFormat.AUTO),
                  onChanged: (newCronExpression) {
                    onChanged.call(RuleTriggerCronConfiguration(
                        cronExpression:
                            CronExpression.fromString(newCronExpression)));
                  },
                )),
      const Gap(mediumPadding),
      Text(configuration.cronExpression.toReadableString(context))
    ]);
  }
}
