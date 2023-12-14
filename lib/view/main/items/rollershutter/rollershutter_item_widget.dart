import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/base_item_dialog.dart';
import '../../../util/general/dimmable_widget_container.dart';
import 'rollershutter_item_dialog.dart';

class RollershutterItemWidget extends StatefulWidget {
  final Item item;
  final double width;

  const RollershutterItemWidget(
      {super.key, required this.item, required this.width});

  @override
  State<RollershutterItemWidget> createState() =>
      _RollershutterItemWidgetState();
}

class _RollershutterItemWidgetState extends State<RollershutterItemWidget> {
  final _itemRepository = locator<ItemRepository>();

  double get numberState => double.parse(widget.item.state);

  bool get isDown => numberState == 0;

  @override
  Widget build(BuildContext context) {
    return DimmableWidgetContainer(
        key: ValueKey(numberState.toString()),
        width: widget.width,
        padding: const EdgeInsets.all(paddingContainer),
        onTap: onAction,
        onLongTap: () => onLongTap(context),
        value: numberState,
        maxValue: widget.item.stateDescription?.maximum ?? 100,
        minValue: widget.item.stateDescription?.minimum ?? 0,
        onDragDone: onDragDone,
        reversed: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.label,
                style: DynamicTheme.of(context)!.theme.textTheme.titleLarge),
            Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  widget.item.icon ?? widget.item.type.icon,
                  size: 40,
                )),
          ],
        ));
  }

  Future<void> onAction() async {
      await _itemRepository.rollershutterAction(
          widget.item.ohName, !isDown);
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(widget.item.ohName, value);
  }

  Future<void> onLongTap(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => Dialog(
                child: BaseItemDialog(
                    child: RollershutterItemDialog(
              itemName: widget.item.ohName,
              initialValue: numberState,
            ))));
  }
}

enum RollershutterState { up, down, half }
