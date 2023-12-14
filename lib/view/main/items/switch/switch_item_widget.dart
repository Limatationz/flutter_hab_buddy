import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/base_item_dialog.dart';
import '../../../util/general/dimmable_widget_container.dart';
import '../item_widget_factory.dart';
import 'switch_item_dialog.dart';

class SwitchItemWidget extends StatelessWidget {
  final Item item;
  final double width;

  SwitchItemWidget({super.key, required this.item, required this.width});
  final _itemRepository = locator<ItemRepository>();

  bool get isOn => item.state == "ON";

  @override
  Widget build(BuildContext context) {
    return DimmableWidgetContainer(
        key: ValueKey(isOn.toString()),
        width: width,
        padding: const EdgeInsets.all(paddingContainer),
        onTap: !item.isReadOnly ? onAction : null,
        onLongTap: () => onLongTap(context),
        value: isOn ? 100 : 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.label,
                style: DynamicTheme.of(context)!.theme.textTheme.titleLarge),
            Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  item.icon ?? item.type.icon,
                  size: 40,
                )),
          ],
        ));
  }

  Future<void> onAction() async {
    await _itemRepository.switchAction(item.ohName, !isOn);
  }

  void onLongTap(BuildContext context) =>
      ItemWidgetFactory.openDialog(
          context, SwitchItemDialog(itemName: item.ohName), item);
}
