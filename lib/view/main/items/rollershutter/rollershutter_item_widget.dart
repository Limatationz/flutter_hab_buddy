import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/dimmable_widget_container.dart';
import '../general/item_widget.dart';
import '../item_widget_factory.dart';
import 'rollershutter_item_dialog.dart';

class RollershutterItemWidget extends SmallItemWidget {
  RollershutterItemWidget(
      {super.key, required super.item, required super.colorScheme});

  final _itemRepository = locator<ItemRepository>();

  double get numberState => double.parse(item.state);

  bool get isDown => numberState == 0;

  @override
  Widget build(BuildContext context) {
    return DimmableWidgetContainer(
        key: ValueKey(numberState.toString()),
        onTap: !item.isReadOnly ? onAction : null,
        onLongTap: () => onLongTap(context),
        value: numberState,
        maxValue: item.stateDescription?.maximum ?? 100,
        minValue: item.stateDescription?.minimum ?? 0,
        onDragDone: !item.isReadOnly ? onDragDone : null,
        colorScheme: colorScheme,
        reversed: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoHyphenatingText(item.label,
                maxLines: 3,
                style: DynamicTheme.of(context)!.theme.textTheme.titleMedium),
            Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  item.icon ?? item.type.icon,
                  size: iconSize,
                  color:
                      DynamicTheme.of(context)!.theme.colorScheme.onBackground,
                )),
          ],
        ));
  }

  Future<void> onAction() async {
    await _itemRepository.rollershutterAction(item.ohName, !isDown);
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(item.ohName, value);
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context,
      RollershutterItemDialog(
        itemName: item.ohName,
        initialValue: numberState,
      ),
      item);
}

enum RollershutterState { up, down, half }
