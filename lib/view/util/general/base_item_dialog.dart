import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/items_table.dart';
import '../../../locator.dart';
import '../../../repository/automation_repository.dart';
import '../../../repository/item_repository.dart';
import '../../../util/icons/icons.dart';
import '../../main/automation/by_item/automations_by_item_view.dart';
import '../../main/items/general/item_widget_factory.dart';
import '../constants.dart';

class BaseItemDialog extends StatefulWidget {
  final Widget child;
  final Item item;
  final ColorScheme colorScheme;
  final bool hideItemName;
  final bool scrollable;

  const BaseItemDialog(
      {super.key,
      required this.child,
      required this.item,
      required this.colorScheme,
      this.hideItemName = false,
      this.scrollable = false});

  @override
  State<BaseItemDialog> createState() => _BaseItemDialogState();
}

class _BaseItemDialogState extends State<BaseItemDialog> {
  final _itemRepository = locator<ItemRepository>();
  final _automationRepository = locator<AutomationRepository>();

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
            color: widget.colorScheme.surface,
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
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
                const Gap(listSpacing),
                StreamBuilder2(
                    streams: StreamTuple2(
                        _automationRepository.automationEnabled,
                        _automationRepository
                            .countRulesForItemNameStream(widget.item.ohName)),
                    builder: (context, snapshot) {
                      final enabled = snapshot.snapshot1.data ?? false;
                      final count = snapshot.snapshot2.data ?? 0;
                      return badges.Badge(
                          badgeContent: Text(
                            count.toString(),
                            style: TextStyle(
                                color: widget.colorScheme.onSecondaryContainer),
                          ),
                          showBadge: count > 0,
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: widget.colorScheme.secondaryContainer,
                          ),
                          position: badges.BadgePosition.topEnd(end: -2),
                          child: IconButton(
                              color: widget.colorScheme.primary,
                              onPressed: enabled
                                  ? () {
                                      context.pushNamed(
                                          AutomationsByItemView.routeName,
                                          pathParameters: {
                                            "itemName": widget.item.ohName
                                          });
                                    }
                                  : null,
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(LineIconsFilled.automation)));
                    }),
                IconButton(
                    color: widget.colorScheme.primary,
                    onPressed: toggleFavorite,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                        isFavorite ? LineIconsFilled.heart : LineIcons.heart)),
                IconButton(
                    color: widget.colorScheme.primary,
                    onPressed: () =>
                        ItemWidgetFactory.openEditView(context, widget.item),
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(LineIconsFilled.pencil))
              ]),
              if (!widget.hideItemName) const Gap(4),
              if (!widget.hideItemName) Text(widget.item.ohName),
              const Gap(12),
              widget.scrollable ? Expanded(child: widget.child) : widget.child
            ]));
  }

  Future<void> toggleFavorite() => _itemRepository
      .updateFavoriteByName(widget.item.ohName, !widget.item.isFavorite)
      .then((value) => setState(() {
            isFavorite = !isFavorite;
          }));
}
