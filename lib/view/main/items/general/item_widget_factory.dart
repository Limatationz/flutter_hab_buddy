import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' show ModalScrollController;

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../core/database/items/oh_item_type.dart';
import '../../../util/general/bar_bottom_sheet.dart';
import '../../../util/general/base_item_dialog.dart';
import '../clock/clock_add_sheet.dart';
import '../clock/clock_item_widget.dart';
import '../dimmer/dimmer_item_widget.dart';
import '../edit/item_edit_view.dart';
import '../player/base/player_item_widget.dart';
import '../player/complex/complex_player_add_sheet.dart';
import '../player/complex/complex_player_data.dart';
import '../player/complex/complex_player_item_widget.dart';
import '../rollershutter/rollershutter_item_widget.dart';
import '../switch/switch_item_widget.dart';
import '../text/text_item_widget.dart';
import '../weather/weather_add_sheet.dart';
import '../weather/weather_item_widget.dart';
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
        if (item.type == ItemType.weather) {
          return WeatherItemWidget(item: item, colorScheme: colorScheme);
        }
        return TextItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
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
      case OhItemType.dateTime:
        return ClockItemWidget(item: item, colorScheme: colorScheme);
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
    } else if (item.type == ItemType.clock) {
      child = ClockAddSheet(
        roomId: item.roomId,
        item: item,
      );
    } else if (item.type == ItemType.weather) {
      child = WeatherAddSheet(
        roomId: item.roomId,
        item: item,
      );
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
    } else if (itemType == ItemType.clock) {
      child = ClockAddSheet(
        roomId: roomId,
      );
    } else if (itemType == ItemType.weather) {
      child = WeatherAddSheet(roomId: roomId);
    }
    if (child != null) {
      final result = await showBarModalBottomSheet<Item?>(
          context: context,
          builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: child!));
      return result != null;
    }
    return false;
  }

  static Future<void> openDialog(BuildContext context, Widget child, Item item,
      ColorScheme colorScheme, {bool hideItemName = false}) async {
    showDialog(
        context: context,
        builder: (_) => Dialog(
                child: BaseItemDialog(
              item: item,
              colorScheme: colorScheme,
                hideItemName: hideItemName,
              child: child,
            )));
  }
}
