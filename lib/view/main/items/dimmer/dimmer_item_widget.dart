import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/items/items_table.dart';
import '../../../../core/database/state/item_states_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/dimmable_widget_container.dart';
import '../general/item_state_injector.dart';
import '../general/item_widget.dart';
import '../general/item_widget_factory.dart';
import 'dimmer_item_dialog.dart';

class DimmerItemWidget extends SmallItemWidget {
  DimmerItemWidget({super.key, required super.item, required super.colorScheme})
      : assert(item != null);

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: item!.ohName,
        builder: (state) {
          final dimmerState = double.parse(state.state);
          final isOn = dimmerState > 0;
          return DimmableWidgetContainer(
              key: ValueKey(dimmerState.toString()),
              onTap: !state.isReadOnly ? () => onAction(isOn) : null,
              onLongTap: () => onLongTap(context, dimmerState),
              value: dimmerState,
              maxValue: state.stateDescription?.maximum,
              minValue: state.stateDescription?.minimum,
              onDragDone: !state.isReadOnly ? onDragDone : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoHyphenatingText(item!.label,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.titleMedium),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        item!.icon ?? item!.type.icon,
                        size: iconSize,
                        color: isOn
                            ? Theme.of(context).colorScheme.onBackground
                            : Colors.grey,
                      )),
                ],
              ));
        });
  }

  Future<void> onAction(bool isOn) async {
    await _itemRepository.switchAction(item!.ohName, !isOn);
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(item!.ohName, value);
  }

  void onLongTap(BuildContext context, double value) =>
      ItemWidgetFactory.openDialog(
          context,
          DimmerItemDialog(
              itemName: item!.ohName,
              initialValue: value,
              colorScheme: colorScheme),
          item!,
          colorScheme);
}
