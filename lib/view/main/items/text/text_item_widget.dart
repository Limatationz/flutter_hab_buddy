import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/items/items_table.dart';
import '../../../util/general/widget_container.dart';
import '../general/item_widget.dart';
import '../item_widget_factory.dart';
import 'text_item_dialog.dart';

class TextItemWidget extends ItemWidget {
  const TextItemWidget(
      {super.key, required super.item, required super.colorScheme});

  @override
  Widget build(BuildContext context) {
    return WidgetContainer(
        key: ValueKey(item.state.toString()),
        onLongTap: () => onLongTap(context),
        colorScheme: colorScheme,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoHyphenatingText(item.label,
                maxLines: 3,
                style: DynamicTheme.of(context)!.theme.textTheme.titleMedium),
            Align(
                alignment: Alignment.bottomRight,
                child: Text(item.itemState,
                    style: DynamicTheme.of(context)!
                        .theme
                        .textTheme
                        .headlineSmall)),
          ],
        ));
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context, TextItemDialog(itemName: item.ohName), item);
}
