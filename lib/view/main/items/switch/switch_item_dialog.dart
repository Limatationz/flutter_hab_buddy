import 'package:flutter/material.dart';

import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../general/item_state_combined_injector.dart';
import 'switch_item_control.dart';

class SwitchItemDialog extends StatelessWidget {
  final String itemName;
  final ColorScheme colorScheme;

  SwitchItemDialog(
      {super.key, required this.itemName, required this.colorScheme});

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateCombinedInjector(
        itemName: itemName,
        builder: (item, itemState) {
          final isOn = itemState.state == "ON";
          return Align(
              child: SwitchItemControl(
            onSwitchChanged: (newValue) => onAction(newValue),
            value: isOn,
            item: item,
            colorScheme: colorScheme,
          ));
        });
  }

  Future<void> onAction(String value) async {
    await _itemRepository.stringAction(itemName, value);
  }
}
