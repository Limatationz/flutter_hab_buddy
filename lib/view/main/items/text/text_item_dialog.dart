import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../item_widget_factory.dart';

class TextItemDialog extends StatefulWidget {
  final String itemName;

  const TextItemDialog({super.key, required this.itemName});

  @override
  State<TextItemDialog> createState() => _TextItemDialogState();
}

class _TextItemDialogState extends State<TextItemDialog> {
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
          final isOn = item.state == "ON";
          return
              Text(item.transformedState ?? item.state,
                  style:
                      DynamicTheme.of(context)!.theme.textTheme.headlineLarge);
        });
  }

  Future<void> onAction(bool on) async {
    await _itemRepository.switchAction(widget.itemName, on);
  }
}
