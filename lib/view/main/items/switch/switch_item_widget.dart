import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openhab/view/main/items/switch/switch_item_dialog.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/base_item_dialog.dart';
import '../../../util/general/widget_container.dart';

class SwitchItemWidget extends StatefulWidget {
  final Item item;
  final double width;

  const SwitchItemWidget({super.key, required this.item, required this.width});

  @override
  State<SwitchItemWidget> createState() => _SwitchItemWidgetState();
}

class _SwitchItemWidgetState extends State<SwitchItemWidget> {
  final _itemRepository = locator<ItemRepository>();

  bool get isOn => widget.item.state == "ON";

  @override
  Widget build(BuildContext context) {
    return WidgetContainer(
        width: widget.width,
        padding: const EdgeInsets.all(paddingContainer),
        onTap: onAction,
        onLongTap: () => onLongTap(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.label,
                style: DynamicTheme.of(context)!.theme.textTheme.titleLarge),
            Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  widget.item.icon ?? widget.item.type.icon,
                  color: isOn
                      ? DynamicTheme.of(context)!.theme.colorScheme.primary
                      : Colors.grey,
                  size: 40,
                )),
          ],
        ));
  }

  Future<void> onAction() async {
    await _itemRepository.switchAction(widget.item.ohName, !isOn);
  }

  Future<void> onLongTap(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            child: BaseItemDialog(
                child: SwitchItemDialog(itemName: widget.item.ohName))));
  }
}
