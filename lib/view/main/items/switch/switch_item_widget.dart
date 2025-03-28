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
import 'switch_item_dialog.dart';

class SwitchItemWidget extends SmallItemWidget {
  final bool disableTap;

  SwitchItemWidget(
      {super.key,
      required super.item,
      required super.colorScheme,
      this.disableTap = false})
      : assert(item != null);

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: item!.ohName,
        builder: (itemState) {
          final isOn = itemState.state == "ON";
          return DimmableWidgetContainer(
              key: ValueKey(isOn.toString()),
              onTap: () => !itemState.isReadOnly ? onAction(isOn) : null,
              onLongTap: () => onLongTap(context),
              value: isOn ? 100 : 0,
              colorScheme: colorScheme,
              disableTap: disableTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: AutoHyphenatingText(item!.label,
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

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context,
      SwitchItemDialog(
        itemName: item!.ohName,
        colorScheme: colorScheme,
      ),
      item!,
      colorScheme);
}
