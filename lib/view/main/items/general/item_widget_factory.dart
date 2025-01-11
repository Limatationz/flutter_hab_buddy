import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart'
    show ModalScrollController;

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../core/database/items/oh_item_type.dart';
import '../../../util/general/bar_bottom_sheet.dart';
import '../../../util/general/base_item_dialog.dart';
import '../clock/clock_add_sheet.dart';
import '../clock/clock_item_widget.dart';
import '../color/color_item_widget.dart';
import '../dimmer/dimmer_item_control.dart';
import '../dimmer/dimmer_item_widget.dart';
import '../edit/item_edit_view.dart';
import '../image/image_item_widget.dart';
import '../location/location_item_widget.dart';
import '../player/base/player_item_widget.dart';
import '../player/complex/complex_player_add_sheet.dart';
import '../player/complex/complex_player_data.dart';
import '../player/complex/complex_player_item_widget.dart';
import '../rollershutter/rollershutter_item_control.dart';
import '../rollershutter/rollershutter_item_widget.dart';
import '../switch/switch_item_control.dart';
import '../switch/switch_item_widget.dart';
import '../text/text_item_widget.dart';
import '../thermostat/thermostat_add_sheet.dart';
import '../thermostat/thermostat_data.dart';
import '../thermostat/thermostat_item_widget.dart';
import '../weather/current/weather_current_widget.dart';
import '../weather/forecast/weather_forecast_widget.dart';
import '../weather/weather_add_sheet.dart';
import '../weather/weather_data.dart';
import 'item_widget.dart';

typedef OnItemStateChanged = void Function(dynamic value);

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
          return WeatherCurrentWidget(item: item, colorScheme: colorScheme);
        } else if (item.type == ItemType.weatherForecast) {
          return WeatherForecastWidget(item: item, colorScheme: colorScheme);
        }
        return TextItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
      case OhItemType.number:
        if (item.type == ItemType.thermostat) {
          return ThermostatItemWidget(
            item: item,
            colorScheme: colorScheme,
          );
        }
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
      case OhItemType.image:
        return ImageItemWidget(item: item, colorScheme: colorScheme);
      case OhItemType.color:
        return ColorItemWidget(item: item, colorScheme: colorScheme);
      case OhItemType.location:
        return LocationItemWidget(item: item, colorScheme: colorScheme);
      default:
        return TextItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
    }
  }

  static Widget buildControl(
      {required ItemWithState itemWithState,
      required ColorScheme colorScheme,
      required dynamic value,
      required OnItemStateChanged onItemStateChanged}) {
    switch (itemWithState.item.ohType) {
      case OhItemType.button:
        return SwitchItemControl(
          item: itemWithState.item,
          colorScheme: colorScheme,
          value: value,
          onSwitchChanged: onItemStateChanged,
        );
      case OhItemType.dimmer:
        return DimmerItemControl(
          itemState: itemWithState.state,
          colorScheme: colorScheme,
          initialValue: value,
          onDimmerChanged: onItemStateChanged,
          item: itemWithState.item,
        );
      case OhItemType.rollershutter:
        return RollershutterItemControl(
          itemState: itemWithState.state,
          colorScheme: colorScheme,
          initialValue: value,
          onRollershutterChanged: onItemStateChanged,
        );
      case OhItemType.string:
        if (itemWithState.item.type == ItemType.weather) {
          return WeatherCurrentWidget(
              item: itemWithState.item, colorScheme: colorScheme);
        } else if (itemWithState.item.type == ItemType.weatherForecast) {
          return WeatherForecastWidget(
              item: itemWithState.item, colorScheme: colorScheme);
        }
        return TextItemWidget(
          item: itemWithState.item,
          colorScheme: colorScheme,
        );
      case OhItemType.number:
        if (itemWithState.item.type == ItemType.thermostat) {
          return ThermostatItemWidget(
            item: itemWithState.item,
            colorScheme: colorScheme,
          );
        }
        return TextItemWidget(
          item: itemWithState.item,
          colorScheme: colorScheme,
        );
      case OhItemType.player:
        if (itemWithState.item.type == ItemType.complexPlayer) {
          return ComplexPlayerItemWidget(
            item: itemWithState.item,
            colorScheme: colorScheme,
          );
        }
        return PlayerItemWidget(
          item: itemWithState.item,
          colorScheme: colorScheme,
        );
      case OhItemType.dateTime:
        return ClockItemWidget(
            item: itemWithState.item, colorScheme: colorScheme);
      case OhItemType.image:
        return ImageItemWidget(
            item: itemWithState.item, colorScheme: colorScheme);
      case OhItemType.color:
        return ColorItemWidget(
            item: itemWithState.item, colorScheme: colorScheme);
      case OhItemType.location:
        return LocationItemWidget(
            item: itemWithState.item, colorScheme: colorScheme);
      default:
        return TextItemWidget(
          item: itemWithState.item,
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
        type: WeatherRequestType.current,
      );
    } else if (item.type == ItemType.weatherForecast) {
      child = WeatherAddSheet(
        roomId: item.roomId,
        item: item,
        type: WeatherRequestType.forecast,
      );
    } else if (item.type == ItemType.thermostat) {
      child = ThermostatAddSheet(
        roomId: item.roomId,
        thermostatData: item.complexJson != null
            ? ThermostatData.fromJson(item.complexJson!)
            : null,
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
      child = WeatherAddSheet(
        roomId: roomId,
        type: WeatherRequestType.current,
      );
    } else if (itemType == ItemType.weatherForecast) {
      child = WeatherAddSheet(
        roomId: roomId,
        type: WeatherRequestType.forecast,
      );
    } else if (itemType == ItemType.thermostat) {
      child = ThermostatAddSheet(
        roomId: roomId,
      );
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

  static Future<void> openDialog(
      BuildContext context, Widget child, Item item, ColorScheme colorScheme,
      {bool hideItemName = false, bool scrollable = false}) async {
    showDialog(
        context: context,
        builder: (_) => Dialog(
                child: BaseItemDialog(
              item: item,
              colorScheme: colorScheme,
              hideItemName: hideItemName,
              scrollable: scrollable,
              child: child,
            )));
  }
}
