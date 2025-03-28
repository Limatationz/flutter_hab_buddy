import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';

import 'package:flutter/material.dart';

import '../../../../../core/database/items/items_table.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../../util/general/widget_container.dart';
import '../../general/item_state_injector.dart';
import '../../general/item_widget.dart';
import '../../general/item_widget_factory.dart';
import 'player_item_dialog.dart';

class PlayerItemWidget extends MediumWidthItemWidget {
  final bool disableTap;

  PlayerItemWidget(
      {super.key,
      required super.item,
      required super.colorScheme,
      this.disableTap = false})
      : assert(item != null);

  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: item!.ohName,
        builder: (itemState) {
          bool isPlaying = itemState.state == "PLAY";
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
                      style: Theme.of(context).textTheme.titleMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () => onAction("PREVIOUS"),
                        icon: const Icon(LineIconsFilled.previous),
                      ),
                      if (!isPlaying)
                        IconButton.filled(
                          style: IconButton.styleFrom(
                              backgroundColor: colorScheme.primary),
                          onPressed: () => onAction("PLAY"),
                          icon: const Icon(LineIcons.play),
                        )
                      else
                        IconButton.filled(
                          style: IconButton.styleFrom(
                              backgroundColor: colorScheme.primary),
                          onPressed: () => onAction("PAUSE"),
                          icon: const Icon(LineIcons.pause),
                        ),
                      IconButton(
                        onPressed: () => onAction("NEXT"),
                        icon: const Icon(LineIconsFilled.next),
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  Future<void> onAction(String action) async {
    await _itemRepository.stringAction(item!.ohName, action);
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context,
      PlayerItemDialog(
        itemName: item!.ohName,
        colorScheme: colorScheme,
      ),
      item!,
      colorScheme);
}
