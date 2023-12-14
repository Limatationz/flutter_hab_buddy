import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../util/constants.dart';
import '../../../util/general/base_item_dialog.dart';
import '../../../util/general/widget_container.dart';
import '../item_widget_factory.dart';
import 'text_item_dialog.dart';

class TextItemWidget extends StatelessWidget {
  final Item item;
  final double width;

  const TextItemWidget({super.key, required this.item, required this.width});

  @override
  Widget build(BuildContext context) {
    return WidgetContainer(
        key: ValueKey(item.state.toString()),
        width: width,
        padding: const EdgeInsets.all(paddingContainer),
        onLongTap: () => onLongTap(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.label,
                style: DynamicTheme
                    .of(context)!
                    .theme
                    .textTheme
                    .titleLarge),
            Align(
                alignment: Alignment.bottomRight,
                child: Text(item.itemState,
                    style: DynamicTheme
                        .of(context)!
                        .theme
                        .textTheme
                        .headlineSmall)),
          ],
        ));
  }

  void onLongTap(BuildContext context) =>
    ItemWidgetFactory.openDialog(
        context, TextItemDialog(itemName: item.ohName), item);
}
