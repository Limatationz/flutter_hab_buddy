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
import 'dimmer_item_dialog.dart';

class DimmerItemWidget extends SmallItemWidget {
  DimmerItemWidget(
      {super.key, required super.item, required super.colorScheme});

  final _itemRepository = locator<ItemRepository>();

  double get dimmerState => double.parse(item.state);

  bool get isOn => dimmerState > 0;

  @override
  Widget build(BuildContext context) {
    return DimmableWidgetContainer(
        key: ValueKey(dimmerState.toString()),
        onTap: !item.isReadOnly ? onAction : null,
        onLongTap: () => onLongTap(context),
        value: dimmerState,
        maxValue: item.stateDescription?.maximum,
        minValue: item.stateDescription?.minimum,
        onDragDone: !item.isReadOnly ? onDragDone : null,
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
                  color: isOn
                      ? DynamicTheme.of(context)!.theme.colorScheme.onBackground
                      : Colors.grey,
                )),
          ],
        ));
  }

  Future<void> onAction() async {
    await _itemRepository.switchAction(item.ohName, !isOn);
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(item.ohName, value);
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context, DimmerItemDialog(itemName: item.ohName), item, colorScheme);
}
