
import 'package:flutter/material.dart';

import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../general/item_state_combined_injector.dart';

class SwitchItemDialog extends StatelessWidget {
  final String itemName;

  SwitchItemDialog({super.key, required this.itemName});

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateCombinedInjector(
        itemName: itemName,
        builder: (item, itemState) {
          final isOn = itemState.state == "ON";
          return Align(
              child: IconButton(
                  onPressed: () => onAction(!isOn),
                  icon: Icon(
                    item.icon ?? item.type.icon,
                    color: isOn
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                  iconSize: 60));
        });
  }

  Future<void> onAction(bool on) async {
    await _itemRepository.switchAction(itemName, on);
  }
}
