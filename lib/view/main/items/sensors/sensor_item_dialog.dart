
import 'package:flutter/material.dart';

import '../general/item_state_combined_injector.dart';
import 'sensor_item_dialog_chart.dart';

class SensorItemDialog extends StatelessWidget {
  final String itemName;
  final ColorScheme colorScheme;

  const SensorItemDialog(
      {super.key, required this.itemName, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return ItemStateCombinedInjector(
        itemName: itemName,
        builder: (item, itemState) {
         return Column(children: [
            Text(itemState.state,
                style: Theme.of(context).textTheme.headlineLarge),
            SensorItemDialogChart(
                item: item, itemState: itemState, colorScheme: colorScheme),
          ]);
        });
  }
}
