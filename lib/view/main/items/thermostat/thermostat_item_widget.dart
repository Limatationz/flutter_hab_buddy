import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../locator.dart';
import '../general/item_widget.dart';
import 'thermostat_data.dart';
import 'thermostat_item_base_widget.dart';

class ThermostatItemWidget extends MediumWidthItemWidget {
  final bool disableTap;
  ThermostatItemWidget({
    super.key,
    required super.item,
    required super.colorScheme,
    this.disableTap = false,
  }) : assert(item != null);

  final _itemsStore = locator<AppDatabase>().itemsStore;

  @override
  Widget build(BuildContext context) {
    final config = ThermostatData.fromJson(item!.complexJson!);
    return ThermostatItemBaseWidget(
      item: item,
      colorScheme: colorScheme,
      heatingSetpointStream: _itemsStore
          .watchStateByName(item!.ohName)
          .whereNotNull(),
      currentTemperatureStream: _itemsStore
          .watchStateByName(config.currentTemperatureItemName)
          .whereNotNull(),
      currentHumidityStream: config.currentHumidityItemName != null
          ? _itemsStore
              .watchStateByName(config.currentHumidityItemName!)
              .whereNotNull()
          : null,
      modeStream: config.modeItemName != null
          ? _itemsStore
              .watchStateByName(config.modeItemName!)
              .whereNotNull()
          : null,
      disableTap: disableTap,
    );
  }
}
