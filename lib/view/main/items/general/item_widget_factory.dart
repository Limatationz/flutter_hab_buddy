import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../core/database/items/oh_item_type.dart';
import '../../../util/general/bar_bottom_sheet.dart';
import '../../../util/general/base_item_dialog.dart';
import '../dimmer/dimmer_item_widget.dart';
import '../edit/item_edit_view.dart';
import '../player/base/player_item_widget.dart';
import '../player/complex/complex_player_add_sheet.dart';
import '../player/complex/complex_player_data.dart';
import '../player/complex/complex_player_item_widget.dart';
import '../rollershutter/rollershutter_item_widget.dart';
import '../switch/switch_item_widget.dart';
import '../text/text_item_widget.dart';
import 'item_widget.dart';

class ItemWidgetFactory {
  static ItemWidget buildItem(
      {required Item item, required ColorScheme colorScheme}) {
    switch (item.ohType) {
      case OhItemType.button:
        return SwitchItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
      case OhItemType.dimmer:
        return DimmerItemWidget(item: item, colorScheme: colorScheme);
      case OhItemType.rollershutter:
        return RollershutterItemWidget(item: item, colorScheme: colorScheme);
      case OhItemType.string:
      case OhItemType.number:
        return TextItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
      case OhItemType.player:
        if (item.type == ItemType.complexPlayer) {
          return ComplexPlayerItemWidget(
            item: item,
            colorScheme: colorScheme,
          );
        }
        return PlayerItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
      default:
        return TextItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
    }
  }

  static Future<void> openEditSheet(BuildContext context, Item item) {
    late final Widget child;
    if (item.type == ItemType.complexPlayer) {
      child = ComplexPlayerAddSheet(
          roomId: item.roomId,
          complexPlayerData: ComplexPlayerData.fromJson(item.complexJson!));
    } else {
      child = ItemEditView(item: item);
    }
    return showBarModalBottomSheet<Item>(
        context: context, builder: (context) => child);
  }

  static Future<bool> openComplexAddSheet(
      BuildContext context, ItemType itemType, int roomId) async {
    Widget? child;
    if (itemType == ItemType.complexPlayer) {
      child = ComplexPlayerAddSheet(
        roomId: roomId,
      );
    }
    if (child != null) {
      await showBarModalBottomSheet(
          context: context, builder: (context) => child!);
      return true;
    }
    return false;
  }

  static Future<void> openDialog(BuildContext context, Widget child, Item item,
      ColorScheme colorScheme) async {
    showDialog(
        context: context,
        builder: (_) => Dialog(
                child: BaseItemDialog(
              item: item,
              colorScheme: colorScheme,
              child: child,
            )));
  }
}
