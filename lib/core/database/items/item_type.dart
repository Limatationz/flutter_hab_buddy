import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../../generated/l10n.dart';
import '../../../view/main/items/clock/clock_item_base_widget.dart';
import '../../../view/main/items/general/item_widget.dart';
import '../../../view/main/items/player/complex/complex_player_item_base_widget.dart';
import '../../../view/main/items/weather/current/weather_current_widget.dart';
import '../../../view/main/items/weather/forecast/weather_forecast_widget.dart';
import 'oh_item_type.dart';

enum ItemType {
  text,
  button,
  light,
  rollerShutter,
  fan,
  heater,
  thermostat,
  temperature,
  humidity,
  airPressure,
  airQuality,
  smokeDetector,
  waterDetector,
  motionDetector,
  doorContact,
  windowContact,
  powerOutlet,
  energy,
  complexPlayer,
  clock,
  player,
  color,
  number,
  dimmer,
  dateTime,
  image,
  location,
  call,
  presence,
  complexComponent,
  weather,
  weatherForecast,
  unknown;

  IconData get icon {
    switch (this) {
      case ItemType.number:
        return Icons.numbers;
      case ItemType.text:
        return Icons.abc;
      case ItemType.dimmer:
        return Icons.linear_scale;
      case ItemType.button:
        return Icons.power_settings_new;
      case ItemType.rollerShutter:
        return Icons.roller_shades;
      case ItemType.dateTime:
        return Icons.event;
      case ItemType.color:
        return Icons.pallet;
      case ItemType.complexPlayer:
      case ItemType.player:
        return Icons.play_circle;
      case ItemType.image:
        return Icons.image;
      case ItemType.location:
        return Icons.location_on;
      case ItemType.call:
        return Icons.phone;
      case ItemType.windowContact:
        return Icons.sensor_window;
      case ItemType.doorContact:
        return Icons.sensor_door;
      case ItemType.unknown:
        return Icons.help;
      case ItemType.light:
        return Icons.lightbulb;
      case ItemType.powerOutlet:
        return Icons.power;
      case ItemType.temperature:
        return Icons.thermostat;
      case ItemType.humidity:
        return Icons.water;
      case ItemType.airPressure:
        return Icons.air;
      case ItemType.airQuality:
        return Icons.air;
      case ItemType.smokeDetector:
        return Icons.smoke_free;
      case ItemType.waterDetector:
        return Icons.water;
      case ItemType.motionDetector:
        return Icons.online_prediction;
      case ItemType.fan:
        return Icons.mode_fan_off;
      case ItemType.heater:
        return Icons.fireplace;
      case ItemType.thermostat:
        return Icons.thermostat;
      case ItemType.presence:
        return Icons.person;
      case ItemType.energy:
        return Icons.bolt;
      case ItemType.complexComponent:
        return Icons.widgets;
      case ItemType.clock:
        return Icons.access_time;
      case ItemType.weather:
        return Icons.cloud;
      case ItemType.weatherForecast:
        return Icons.cloud_queue;
    }
  }

  String get description {
    switch (this) {
      case ItemType.number:
        return S.current.itemTypeNumber;
      case ItemType.text:
        return S.current.itemTypeText;
      case ItemType.dimmer:
        return S.current.itemTypeDimmer;
      case ItemType.button:
        return S.current.itemTypeButton;
      case ItemType.rollerShutter:
        return S.current.itemTypeRollerShutter;
      case ItemType.dateTime:
        return S.current.itemTypeDateTime;
      case ItemType.color:
        return S.current.itemTypeColor;
      case ItemType.complexPlayer:
        return S.current.itemTypeComplexPlayer;
      case ItemType.player:
        return S.current.itemTypePlayer;
      case ItemType.image:
        return S.current.itemTypeImage;
      case ItemType.location:
        return S.current.itemTypeLocation;
      case ItemType.call:
        return S.current.itemTypeCall;
      case ItemType.windowContact:
        return S.current.itemTypeWindowContact;
      case ItemType.doorContact:
        return S.current.itemTypeDoorContact;
      case ItemType.unknown:
        return S.current.itemTypeUnknown;
      case ItemType.light:
        return S.current.itemTypeLight;
      case ItemType.powerOutlet:
        return S.current.itemTypePowerOutlet;
      case ItemType.temperature:
        return S.current.itemTypeTemperature;
      case ItemType.humidity:
        return S.current.itemTypeHumidity;
      case ItemType.airPressure:
        return S.current.itemTypeAirPressure;
      case ItemType.airQuality:
        return S.current.itemTypeAirQuality;
      case ItemType.smokeDetector:
        return S.current.itemTypeSmokeDetector;
      case ItemType.waterDetector:
        return S.current.itemTypeWaterDetector;
      case ItemType.motionDetector:
        return S.current.itemTypeMotionDetector;
      case ItemType.fan:
        return S.current.itemTypeFan;
      case ItemType.heater:
        return S.current.itemTypeHeater;
      case ItemType.thermostat:
        return S.current.itemTypeThermostat;
      case ItemType.presence:
        return S.current.itemTypePresence;
      case ItemType.energy:
        return S.current.itemTypeEnergy;
      case ItemType.clock:
        return S.current.clock;
      case ItemType.weather:
        return S.current.weather;
      case ItemType.weatherForecast:
        return S.current.weatherForecast;
      case ItemType.complexComponent:
        return "";
    }
  }

  static Set<ItemType> forEntryType(OhItemType type) {
    switch (type) {
      case OhItemType.button:
        return {
          ItemType.button,
          ItemType.light,
          ItemType.powerOutlet,
          ItemType.fan,
          ItemType.smokeDetector,
          ItemType.waterDetector,
          ItemType.motionDetector,
          ItemType.heater,
          ItemType.thermostat,
          ItemType.doorContact,
          ItemType.windowContact,
          ItemType.presence,
        };
      case OhItemType.dimmer:
        return {
          ItemType.light,
          ItemType.fan,
          ItemType.heater,
          ItemType.thermostat,
          ItemType.dimmer
        };
      case OhItemType.rollershutter:
        return {ItemType.rollerShutter};
      case OhItemType.contact:
        return {
          ItemType.doorContact,
          ItemType.windowContact,
        };
      case OhItemType.number:
        return {
          ItemType.temperature,
          ItemType.humidity,
          ItemType.airPressure,
          ItemType.airQuality,
          ItemType.energy,
          ItemType.text,
          ItemType.number,
        };
      case OhItemType.string:
        return {ItemType.text};
      case OhItemType.dateTime:
        return {ItemType.dateTime};
      case OhItemType.color:
        return {ItemType.light, ItemType.text, ItemType.color};
      case OhItemType.player:
        return {ItemType.player};
      case OhItemType.image:
        return {ItemType.image};
      case OhItemType.location:
        return {ItemType.location};
      case OhItemType.call:
        return {ItemType.call};
      case OhItemType.unknown:
        return {ItemType.unknown};
      case OhItemType.group:
        return {};
    }
  }

  static List<ItemType> get complexTypes => [
        ItemType.complexPlayer,
        ItemType.complexComponent,
        ItemType.clock,
        ItemType.weather,
        ItemType.weatherForecast,
      ];

  static List<Tuple2<ItemType, ItemWidget>> getComplexWidgets(
      BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return [
      Tuple2(ItemType.complexPlayer,
          ComplexPlayerItemBaseWidget(item: null, colorScheme: colorScheme)),
      Tuple2(ItemType.clock,
          ClockItemBaseWidget(item: null, colorScheme: colorScheme)),
      Tuple2(ItemType.weather,
          WeatherCurrentWidget(item: null, colorScheme: colorScheme)),
      Tuple2(ItemType.weatherForecast,
          WeatherForecastWidget(item: null, colorScheme: colorScheme)),
    ];
  }
}
