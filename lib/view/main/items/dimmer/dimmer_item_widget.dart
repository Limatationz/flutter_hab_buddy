import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/base_item_dialog.dart';
import '../../../util/general/dimmable_widget_container.dart';
import '../../../util/general/widget_container.dart';
import '../../../util/general/dimmable_icon.dart';
import 'dimmer_item_dialog.dart';

class DimmerItemWidget extends StatefulWidget {
  final Item item;
  final double width;

  const DimmerItemWidget({super.key, required this.item, required this.width});

  @override
  State<DimmerItemWidget> createState() => _DimmerItemWidgetState();
}

class _DimmerItemWidgetState extends State<DimmerItemWidget> {
  final _itemRepository = locator<ItemRepository>();

  double get dimmerState => double.parse(widget.item.state);

  bool get isOn => dimmerState > 0;

  @override
  Widget build(BuildContext context) {
    return DimmableWidgetContainer(
        key: ValueKey(dimmerState.toString()),
        width: widget.width,
        padding: const EdgeInsets.all(paddingContainer),
        onTap: onAction,
        onLongTap: () => onLongTap(context),
        value: dimmerState,
        onDragDone: onDragDone,
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

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(widget.item.ohName, value);
  }

  Future<void> onLongTap(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            child: BaseItemDialog(
                child: DimmerItemDialog(itemName: widget.item.ohName))));
  }
}
