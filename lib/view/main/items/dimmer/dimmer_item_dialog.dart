import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../item_widget_factory.dart';

class DimmerItemDialog extends StatefulWidget {
  final String itemName;

  const DimmerItemDialog({super.key, required this.itemName});

  @override
  State<DimmerItemDialog> createState() => _DimmerItemDialogState();
}

class _DimmerItemDialogState extends State<DimmerItemDialog> {
  final _itemRepository = locator<ItemRepository>();
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
          final value = double.parse(item.state);
          final isOn = value > 0;
          return
              FormBuilderSlider(
                name: "dimmer",
                initialValue: value,
                onChangeEnd: onDragDone,
                onChanged: (_) {},
                min: item.stateDescription?.minimum ?? 0,
                max: item.stateDescription?.maximum ?? 100,
                divisions: item.stateDescription?.step != null
                    ? (item.stateDescription?.maximum ?? 100) ~/
                        item.stateDescription!.step!
                    : null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12)),
          );
        });
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(widget.itemName, value);
  }
}
