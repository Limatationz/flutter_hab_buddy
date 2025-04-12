import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/hive/state/item_state.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../general/item_state_combined_injector.dart';
import '../general/item_state_injector.dart';
import 'dimmer_item_control.dart';

class DimmerItemDialog extends StatelessWidget {
  final String itemName;
  final ColorScheme colorScheme;

  DimmerItemDialog(
      {super.key, required this.itemName, required this.colorScheme});

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateCombinedInjector(
        itemName: itemName,
        builder: (item, itemState) {
          final doubleValue = double.parse(itemState.state);
          return DimmerItemControl(
              key: ValueKey(doubleValue),
              onDimmerChanged: (newValue) {
                if (newValue is double) {
                  onDragDone(newValue);
                } else if (newValue is String) {
                  onAction(newValue);
                }
              },
              item: item,
              itemState: itemState,
              colorScheme: colorScheme,
              initialValue: doubleValue);
        });
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(itemName, value);
  }

  Future<void> onAction(String body) async {
    await _itemRepository.stringAction(itemName, body);
  }
}
