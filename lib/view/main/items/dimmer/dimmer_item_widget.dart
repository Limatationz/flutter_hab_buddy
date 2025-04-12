import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/items/items_table.dart';
import '../../../../core/hive/state/item_state.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/dimmable_widget_container.dart';
import '../general/item_state_injector.dart';
import '../general/item_widget.dart';
import '../general/item_widget_factory.dart';
import 'dimmer_item_dialog.dart';

class DimmerItemWidget extends SmallItemWidget {
  final bool disableTap;
  DimmerItemWidget({super.key, required super.item, required super.colorScheme, this.disableTap = false})
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
              onLongTap: () => onLongTap(context),
              value: dimmerState,
              maxValue: state.stateDescription?.maximum,
              minValue: state.stateDescription?.minimum,
              onDragDone: !state.isReadOnly ? onDragDone : null,
              colorScheme: colorScheme,
              disableTap: disableTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: AutoHyphenatingText(item!.label,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.titleMedium)),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        item!.icon ?? item!.type!.icon,
                        size: iconSize,
                        color: isOn
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.grey,
                      )),
                ],
              ));
        });
  }

  Future<void> onAction(bool isOn) async {
    await _itemRepository.stringAction(item!.ohName, isOn ? "OFF" : "ON");
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(item!.ohName, value);
  }

  void onLongTap(BuildContext context) =>
      ItemWidgetFactory.openDialog(
          context,
          DimmerItemDialog(
              itemName: item!.ohName,
              colorScheme: colorScheme),
          item!,
          colorScheme);
}
