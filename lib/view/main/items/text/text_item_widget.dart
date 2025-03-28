import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';

import 'package:flutter/material.dart';

import '../../../../core/database/items/items_table.dart';
import '../../../util/general/widget_container.dart';
import '../general/item_state_injector.dart';
import '../general/item_widget.dart';
import '../general/item_widget_factory.dart';
import 'text_item_dialog.dart';

class TextItemWidget extends SmallItemWidget {
  final bool disableTap;
  const TextItemWidget(
      {super.key, required super.item, required super.colorScheme, this.disableTap = false});

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: item!.ohName,
        builder: (itemState) {
          return WidgetContainer(
              key: ValueKey(itemState.state.toString()),
              onLongTap: () => onLongTap(context),
              colorScheme: colorScheme,
              disableTap: disableTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoHyphenatingText(item!.label,
                      maxLines: 3,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(itemState.state,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall)),
                ],
              ));
        });
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context, TextItemDialog(itemName: item!.ohName), item!, colorScheme);
}
