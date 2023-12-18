import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/chart_repository.dart';
import '../../../../repository/item_repository.dart';
import 'sensor_item_dialog_chart.dart';

class SensorItemDialog extends StatefulWidget {
  final String itemName;
  final ColorScheme colorScheme;

  const SensorItemDialog(
      {super.key, required this.itemName, required this.colorScheme});

  @override
  State<SensorItemDialog> createState() => _SensorItemDialogState();
}

class _SensorItemDialogState extends State<SensorItemDialog> {
  final _itemRepository = locator<ItemRepository>();
  final _chartRepository = locator<ChartRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Item?>(
        stream: _itemsStore.byName(widget.itemName).watchSingleOrNull(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          final item = snapshot.data!;
          return Column(
              children: [
            Text(item.itemState,
                style: DynamicTheme.of(context)!.theme.textTheme.headlineLarge),
            SensorItemDialogChart(item: item, colorScheme: widget.colorScheme),
          ]);
        });
  }
}
