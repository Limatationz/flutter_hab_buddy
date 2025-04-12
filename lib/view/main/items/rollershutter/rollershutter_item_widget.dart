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
import 'rollershutter_item_dialog.dart';

class RollershutterItemWidget extends SmallItemWidget {
  final bool disableTap;
  RollershutterItemWidget(
      {super.key, required super.item, required super.colorScheme, this.disableTap = false}) : assert(item != null);

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: item!.ohName,
        builder: (itemState) {
          final numberState = double.parse(itemState.state);

          final isDown = numberState == 0;
          return DimmableWidgetContainer(
              key: ValueKey(numberState.toString()),
              onTap: () => !itemState.isReadOnly ? onAction(isDown) : null,
              onLongTap: () => onLongTap(context),
              value: numberState,
              maxValue: itemState.stateDescription?.maximum ?? 100,
              minValue: itemState.stateDescription?.minimum ?? 0,
              onDragDone: !itemState.isReadOnly ? onDragDone : null,
              colorScheme: colorScheme,
              reversed: true,
              disableTap: disableTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Expanded(child: AutoHyphenatingText(item!.label,
                      maxLines: 3,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium)),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        item!.icon ?? item!.type!.icon,
                        size: iconSize,
                        color: !isDown
                            ? Theme.of(context)
                                .colorScheme
                                .onSurface
                            : Colors.grey,
                      )),
                ],
              ));
        });
  }

  Future<void> onAction(bool isDown) async {
    await _itemRepository.rollershutterAction(item!.ohName, !isDown);
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(item!.ohName, value);
  }

  void onLongTap(BuildContext context) =>
      ItemWidgetFactory.openDialog(
          context,
          RollerShutterItemDialog(
            itemName: item!.ohName,
            colorScheme: colorScheme,
          ),
          item!,
          colorScheme);
}

enum RollershutterState { up, down, half }
