import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/database/items/items_table.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../util/icons/LineIconsV5_icons.dart';
import '../../../../../util/constants.dart';
import '../../../../../util/general/bar_bottom_sheet.dart';
import '../../../../../util/general/list_picker_sheet_view.dart';
import '../../../../../util/general/widget_container.dart';
import '../../../../items/dimmer/dimmer_item_control.dart';
import '../../../../items/general/item_select_view.dart';
import '../../../../items/general/item_widget_factory.dart';
import 'automation_edit_form_element_action_general.dart';

class AutomationEditFormElementActionItem extends StatelessWidget {
  final RuleActionItem action;
  final RuleActionCallback onChanged;

  const AutomationEditFormElementActionItem(
      {super.key, required this.action, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: mediumPadding, runSpacing: mediumPadding, children: [
          WidgetContainer(
              backgroundColor: action.item == null
                  ? ColorScheme.of(context).secondary
                  : ColorScheme.of(context).secondaryContainer,
              padding: const EdgeInsets.symmetric(
                  vertical: smallPadding, horizontal: mediumPadding),
              onTap: () {
                ItemSelectView.showSheet(context,
                    onItemWithStateSelect: (item) {
                  final newAction = action.copyWith(item: item);

                  onChanged(newAction);
                });
              },
              child: Text(
                  action.item == null
                      ? S.of(context).selectItem
                      : action.item!.item.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: action.item == null
                          ? ColorScheme.of(context).onSecondary
                          : ColorScheme.of(context).onSecondaryContainer))),
          WidgetContainer(
              backgroundColor: action.commandType == null
                  ? ColorScheme.of(context).secondary
                  : ColorScheme.of(context).secondaryContainer,
              padding: const EdgeInsets.symmetric(
                  vertical: smallPadding, horizontal: mediumPadding),
              onTap: () {
                showBarModalBottomSheet<int?>(
                  context: context,
                  builder: (_) => ListPickerSheetView<RuleActionItemCommand>(
                    options: RuleActionItemCommand.values,
                    option: action.commandType,
                    optionToString: (commandType) => commandType.label,
                    onOptionChange: (commandType) {
                      final newAction =
                          action.copyWith(commandType: commandType);
                      onChanged(newAction);
                    },
                  ),
                );
              },
              child: Text(
                  action.commandType == null
                      ? S.of(context).selectActionType
                      : action.commandType!.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: action.commandType == null
                          ? ColorScheme.of(context).onSecondary
                          : ColorScheme.of(context).onSecondaryContainer))),
        ]),
        if (action.item != null) const Gap(largePadding),
        if (action.item != null)
          Center(
              child: ItemWidgetFactory.buildControl(
            itemWithState: action.item!,
            colorScheme: ColorScheme.of(context),
            value: action.value,
            onItemStateChanged: (value) {
              final newAction = action.copyWith(value: value);
              onChanged(newAction);
            },
          ))
      ],
    );
  }
}
