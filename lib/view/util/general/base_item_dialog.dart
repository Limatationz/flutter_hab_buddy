import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/items_table.dart';
import '../../../locator.dart';
import '../../../repository/item_repository.dart';
import '../../../util/icons/icons.dart';
import '../../main/items/item_widget_factory.dart';
import '../constants.dart';

class BaseItemDialog extends StatefulWidget {
  final Widget child;
  final Item item;
  final ColorScheme colorScheme;

  const BaseItemDialog(
      {super.key,
      required this.child,
      required this.item,
      required this.colorScheme});

  @override
  State<BaseItemDialog> createState() => _BaseItemDialogState();
}

class _BaseItemDialogState extends State<BaseItemDialog> {
  final _itemRepository = locator<ItemRepository>();

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.item.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: widget.colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(paddingScaffold),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: AutoHyphenatingText(
                  widget.item.label,
                  style:
                      DynamicTheme.of(context)!.theme.textTheme.headlineMedium,
                )),
                const Gap(listSpacing),
                IconButton(
                  color: widget.colorScheme.primary,
                    onPressed: toggleFavorite,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                        isFavorite ? LineIconsFilled.heart : LineIcons.heart)),
                IconButton(
                    color: widget.colorScheme.primary,
                    onPressed: () =>
                        ItemWidgetFactory.openEditSheet(context, widget.item),
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(LineIconsFilled.pencil))
              ]),
              const Gap(4),
              Text(widget.item.ohName),
              const Gap(12),
              widget.child
            ]));
  }

  Future<void> toggleFavorite() => _itemRepository
      .updateFavoriteByName(widget.item.ohName, !widget.item.isFavorite)
      .then((value) => setState(() {
            isFavorite = !isFavorite;
          }));
}
