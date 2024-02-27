import 'dart:convert';

import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/items/items_table.dart';
import '../../../../core/database/state/state_utils.dart';
import '../../../util/general/widget_container.dart';
import '../general/item_state_injector.dart';
import '../general/item_widget.dart';
import '../general/item_widget_factory.dart';
import 'image_item_dialog.dart';

class ImageItemWidget extends SmallItemWidget {
  const ImageItemWidget(
      {super.key, required super.item, required super.colorScheme});

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: item!.ohName,
        builder: (itemState) {
          final image = parseImage(itemState.state);
          final imageColorSchemeFuture = image != null
              ? ColorScheme.fromImageProvider(
                  provider: MemoryImage(base64Decode(image)))
              : null;
          return WidgetContainer(
              key: ValueKey(itemState.state.toString()),
              onLongTap: () => onLongTap(context),
              colorScheme: colorScheme,
              backgroundImage: image != null
                  ? DecorationImage(
                      image: MemoryImage(base64Decode(image)),
                      fit: BoxFit.cover,
                    )
                  : null,
              child: FutureBuilder(
                  future: imageColorSchemeFuture,
                  builder: (context, future) {
                    final colorScheme = future.data;
                    return AutoHyphenatingText(item!.label,
                        maxLines: 3,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: colorScheme?.onSurface));
                  }));
        });
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context, ImageItemDialog(itemName: item!.ohName), item!, colorScheme);
}
