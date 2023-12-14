import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../../../util/general/base_item_dialog.dart';
import '../../../util/general/widget_container.dart';
import 'text_item_dialog.dart';

class TextItemWidget extends StatefulWidget {
  final Item item;
  final double width;

  const TextItemWidget({super.key, required this.item, required this.width});

  @override
  State<TextItemWidget> createState() => _TextItemWidgetState();
}

class _TextItemWidgetState extends State<TextItemWidget> {
  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return WidgetContainer(
        key: ValueKey(widget.item.state.toString()),
        width: widget.width,
        padding: const EdgeInsets.all(paddingContainer),
        onLongTap: () => onLongTap(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.label,
                style: DynamicTheme.of(context)!.theme.textTheme.titleLarge),
            Align(
                alignment: Alignment.bottomRight,
                child: Text(widget.item.state,
                    style: DynamicTheme.of(context)!
                        .theme
                        .textTheme
                        .headlineSmall)),
          ],
        ));
  }

  Future<void> onLongTap(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            child: BaseItemDialog(
                child: TextItemDialog(itemName: widget.item.ohName))));
  }
}
