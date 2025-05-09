import 'package:flutter/material.dart';

import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../general/item_state_injector.dart';
import 'rollershutter_item_control.dart';

class RollerShutterItemDialog extends StatelessWidget {
  final _itemRepository = locator<ItemRepository>();

  final String itemName;
  final ColorScheme colorScheme;

  RollerShutterItemDialog(
      {super.key,
      required this.itemName,
      required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: itemName,
        builder: (itemState) {
          final numberState = double.parse(itemState.state);
          return RollershutterItemControl(
            key: ValueKey(numberState),
            initialValue: numberState,
            colorScheme: colorScheme,
            itemState: itemState,
            onRollershutterChanged: (newValue) {
              if (newValue is String) {
                onAction(newValue);
              } else if (newValue is double) {
                onDragDone(newValue);
              }
            },
          );
        });
  }

  Future<void> onAction(String body) async {
    await _itemRepository.stringAction(itemName, body);
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(itemName, value);
  }
}
