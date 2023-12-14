import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/dimmable_widget_container.dart';
import '../item_widget_factory.dart';
import 'rollershutter_item_dialog.dart';

class RollershutterItemWidget extends StatelessWidget {
  final Item item;
  final double width;

  RollershutterItemWidget({super.key, required this.item, required this.width});

  final _itemRepository = locator<ItemRepository>();

  double get numberState => double.parse(item.state);

  bool get isDown => numberState == 0;

  @override
  Widget build(BuildContext context) {
    return DimmableWidgetContainer(
        key: ValueKey(numberState.toString()),
        width: width,
        padding: const EdgeInsets.all(paddingContainer),
        onTap: !item.isReadOnly ? onAction : null,
        onLongTap: () => onLongTap(context),
        value: numberState,
        maxValue: item.stateDescription?.maximum ?? 100,
        minValue: item.stateDescription?.minimum ?? 0,
        onDragDone: !item.isReadOnly ? onDragDone : null,
        reversed: true,
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
