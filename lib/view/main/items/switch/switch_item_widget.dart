import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/dimmable_widget_container.dart';
import '../general/item_widget.dart';
import '../item_widget_factory.dart';
import 'switch_item_dialog.dart';

class SwitchItemWidget extends ItemWidget {

  SwitchItemWidget({super.key, required super.item, required super.colorScheme});

  final _itemRepository = locator<ItemRepository>();

  bool get isOn => item.state == "ON";

  @override
  Widget build(BuildContext context) {
    return DimmableWidgetContainer(
        key: ValueKey(isOn.toString()),
        onTap: !item.isReadOnly ? onAction : null,
        onLongTap: () => onLongTap(context),
        value: isOn ? 100 : 0,
        colorScheme: colorScheme,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoHyphenatingText(item.label,
                maxLines: 3,
                style: DynamicTheme.of(context)!.theme.textTheme.titleMedium),
            Align(
                alignment: Alignment.bottomRight,
                child: Icon(item.icon ?? item.type.icon,
                    size: iconSize,
                    color: DynamicTheme.of(context)!
                        .theme
                        .colorScheme
                        .onBackground)),
          ],
        ));
  }

  Future<void> onAction() async {
    await _itemRepository.switchAction(item.ohName, !isOn);
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context, SwitchItemDialog(itemName: item.ohName), item);
}
