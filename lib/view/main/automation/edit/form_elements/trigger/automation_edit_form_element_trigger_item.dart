import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/database/app_database.dart';
import '../../../../../../core/database/items/items_table.dart';
import '../../../../../../core/database/rules/rule_trigger.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../locator.dart';
import '../../../../../../util/icons/LineIconsV5_icons.dart';
import '../../../../../util/constants.dart';
import '../../../../../util/general/bar_bottom_sheet.dart';
import '../../../../../util/general/list_picker_sheet_view.dart';
import '../../../../../util/general/widget_container.dart';
import '../../../../items/general/item_select_view.dart';
import '../../../../items/general/item_widget_factory.dart';
import 'automation_edit_form_element_trigger_general.dart';

// TODO: state and previous state
// TODO: just when item changed

class AutomationEditFormElementTriggerItem extends StatelessWidget {
  final RuleTriggerItemConfiguration configuration;
  final RuleTriggerConfigurationCallback onChanged;
  final RuleTriggerConfigurationDeleteCallback onDelete;
  final int? listIndex;
  final bool enabled;

  final _itemsStore = locator.get<AppDatabase>().itemsStore;

  AutomationEditFormElementTriggerItem(
      {super.key,
      required this.configuration,
      required this.onChanged,
      required this.onDelete,
      required this.enabled,
      this.listIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
              child: Text("Item Trigger",
                  style: Theme.of(context).textTheme.bodyLarge)),
          if (listIndex != null && enabled)
            ReorderableDragStartListener(
              index: listIndex!,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(LineIconsV5.menu_veggieburger)),
            ),
          IconButton(
              onPressed: enabled ? onDelete : null,
              icon: const Icon(LineIconsV5.trash_1))
        ]),
        const Gap(smallPadding),
        Wrap(spacing: mediumPadding, runSpacing: mediumPadding, children: [
          WidgetContainer(
              backgroundColor: configuration.itemName == null
                  ? ColorScheme.of(context).secondary
                  : ColorScheme.of(context).secondaryContainer,
              padding: const EdgeInsets.symmetric(
                  vertical: smallPadding, horizontal: mediumPadding),
              onTap: enabled
                  ? () {
                      ItemSelectView.showSheet(context,
                          onItemWithStateSelect: (item) {
                        final newConfig = configuration.copyWith(
                            itemName: item?.item.ohName,
                            state: item?.state.state);

                        onChanged(newConfig);
                      });
                    }
                  : null,
              child: Text(
                  configuration.itemName == null
                      ? S.of(context).selectItem
                      : configuration.itemName!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: configuration.itemName == null
                          ? ColorScheme.of(context).onSecondary
                          : ColorScheme.of(context).onSecondaryContainer))),
          WidgetContainer(
              backgroundColor: ColorScheme.of(context).secondaryContainer,
              padding: const EdgeInsets.symmetric(
                  vertical: smallPadding, horizontal: mediumPadding),
              onTap: enabled
                  ? () {
                      showBarModalBottomSheet<int?>(
                        context: context,
                        builder: (_) =>
                            ListPickerSheetView<RuleTriggerItemType>(
                          options: RuleTriggerItemType.values,
                          option: configuration.type,
                          optionToString: (triggerType) =>
                              triggerType.openHabValue,
                          onOptionChange: (triggerType) {
                            final newConfig =
                                configuration.copyWith(type: triggerType);
                            onChanged(newConfig);
                          },
                        ),
                      );
                    }
                  : null,
              child: Text(configuration.type.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorScheme.of(context).onSecondaryContainer))),
          WidgetContainer(
              backgroundColor: ColorScheme.of(context).secondaryContainer,
              padding: const EdgeInsets.symmetric(
                  vertical: smallPadding, horizontal: mediumPadding),
              onTap: enabled
                  ? () {
                      showBarModalBottomSheet<int?>(
                        context: context,
                        builder: (_) =>
                            ListPickerSheetView<RuleTriggerItemChangedType>(
                          options: RuleTriggerItemChangedType.getTypesForConfig(
                              configuration.type),
                          option: configuration.changedType,
                          optionToString: (changedType) => changedType.label,
                          onOptionChange: (changedType) async {
                            final itemWithState = await _itemsStore
                                .getByNameWithState(configuration.itemName!);
                            final defaultValue = itemWithState?.state.state ??
                                itemWithState?.item.defaultValue;
                            if (changedType != null) {
                              if (changedType.isAny) {
                                final newConfig = configuration.copyWithStates(
                                    state: null, previousState: null);
                                onChanged(newConfig);
                              } else if (changedType.isTo) {
                                final newConfig = configuration.copyWithStates(
                                    state: defaultValue, previousState: null);
                                onChanged(newConfig);
                              } else if (changedType.isFromTo) {
                                final newConfig = configuration.copyWithStates(
                                    state: defaultValue,
                                    previousState: defaultValue);
                                onChanged(newConfig);
                              }
                            }
                          },
                        ),
                      );
                    }
                  : null,
              child: Text(configuration.changedType.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorScheme.of(context).onSecondaryContainer))),
        ]),
        if (configuration.itemName != null && !configuration.changedType.isAny)
          const Gap(largePadding),
        if (configuration.itemName != null && !configuration.changedType.isAny)
          Center(
              child: FutureBuilder<ItemWithState?>(
                  future:
                      _itemsStore.getByNameWithState(configuration.itemName!),
                  builder: (context, future) {
                    if (!future.hasData) {
                      return const CircularProgressIndicator();
                    } else if (future.data == null) {
                      return const Text("Item not found");
                    } else {
                      final itemWithState = future.data!;
                      return AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Wrap(
                              spacing: 60,
                              runSpacing: mediumPadding,
                              children: [
                                if (configuration.changedType.showFrom)
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (configuration.changedType ==
                                            RuleTriggerItemChangedType
                                                .changeFromTo)
                                          const Icon(LineIconsV5.exit, size: 36),
                                        if (configuration.changedType ==
                                            RuleTriggerItemChangedType
                                                .changeFromTo)
                                          mediumGap,
                                        ItemWidgetFactory.buildControl(
                                          itemWithState: itemWithState,
                                          colorScheme: ColorScheme.of(context),
                                          value: configuration.previousState,
                                          onItemStateChanged: enabled
                                              ? (value) {
                                                  final newAction =
                                                      configuration.copyWith(
                                                          previousState: value);
                                                  onChanged(newAction);
                                                }
                                              : null,
                                        )
                                      ]),
                                if (configuration.changedType.showTo)
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (configuration.changedType ==
                                            RuleTriggerItemChangedType
                                                .changeFromTo)
                                          const Icon(LineIconsV5.enter, size: 36),
                                        if (configuration.changedType ==
                                            RuleTriggerItemChangedType
                                                .changeFromTo)
                                          mediumGap,
                                        ItemWidgetFactory.buildControl(
                                          itemWithState: itemWithState,
                                          colorScheme: ColorScheme.of(context),
                                          value: configuration.state,
                                          onItemStateChanged: enabled
                                              ? (value) {
                                                  final newAction =
                                                      configuration.copyWith(
                                                          state: value);
                                                  onChanged(newAction);
                                                }
                                              : null,
                                        )
                                      ]),
                              ]));
                    }
                  }))
      ],
    );
  }
}
