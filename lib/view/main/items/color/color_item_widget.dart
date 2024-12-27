import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:color_models/color_models.dart';
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
import 'color_item_dialog.dart';
import 'color_util.dart';

class ColorItemWidget extends SmallItemWidget {
  ColorItemWidget({super.key, required super.item, required super.colorScheme})
      : assert(item != null);

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: item!.ohName,
        builder: (state) {
          final colorValue = OpenhabColorUtil.parseColorState(state.state);
          final dimmerState = colorValue.brightness.toDouble();
          final isOn = dimmerState > 0;
          return DimmableWidgetContainer(
              key: ValueKey(colorValue.hex),
              onTap: !state.isReadOnly ? () => onAction(isOn) : null,
              onLongTap: !state.isReadOnly
                  ? () => onLongTap(context, colorValue)
                  : null,
              value: dimmerState,
              maxValue: state.stateDescription?.maximum,
              minValue: state.stateDescription?.minimum,
              onDragDone: !state.isReadOnly ? onDragDone : null,
              colorScheme: colorScheme,
              accentBackgroundColor: colorValue.toColor(fullOpacity: true),
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
                            ? Theme.of(context).colorScheme.onSurface
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

  void onLongTap(BuildContext context, HsbColor value) =>
      ItemWidgetFactory.openDialog(
          context,
          ColorItemDialog(
              itemName: item!.ohName,
              initialValue: value,
              colorScheme: colorScheme),
          item!,
          colorScheme);
}
