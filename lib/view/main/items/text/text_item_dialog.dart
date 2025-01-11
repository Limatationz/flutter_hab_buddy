
import 'package:flutter/material.dart';

import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../general/item_state_injector.dart';

class TextItemDialog extends StatelessWidget {
  final String itemName;

  TextItemDialog({super.key, required this.itemName});

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: itemName,
        builder: (itemState) {
          return Text(itemState.state,
              style: Theme.of(context).textTheme.headlineLarge);
        });
  }

  Future<void> onAction(bool on) async {
    await _itemRepository.stringAction(itemName, on ? "ON" : "OFF");
  }
}
