import 'dart:async';

import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/items/items_table.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../core/database/state/item_states_table.dart';
import '../../../util/general/dimmable_widget_container.dart';
import '../general/item_widget.dart';
import '../general/item_widget_factory.dart';
import 'thermostat_data.dart';
import 'thermostat_item_dialog.dart';

class ThermostatItemBaseWidget extends MediumWidthItemWidget {
  final Stream<ItemState>? heatingSetpointStream;
  final Stream<ItemState>? currentTemperatureStream;
  final Stream<ItemState>? modeStream;
  final Stream<ItemState>? currentHumidityStream;

  ThermostatItemBaseWidget({
    super.key,
    required super.item,
    required super.colorScheme,
    this.heatingSetpointStream,
    this.currentTemperatureStream,
    this.modeStream,
    this.currentHumidityStream,
  });

  final _itemRepository = locator<ItemRepository>();

  bool get isMock => item == null;

  @override
  Widget build(BuildContext context) {
    final config = item?.complexJson != null
        ? ThermostatData.fromJson(item!.complexJson!)
        : null;
    return StreamBuilder4(
        streams: StreamTuple4<ItemState?, ItemState?, ItemState?, ItemState?>(
          heatingSetpointStream ?? const Stream.empty(),
          currentTemperatureStream ?? const Stream.empty(),
          currentHumidityStream ?? const Stream.empty(),
          modeStream ?? const Stream.empty(),
        ),
        builder: (context, snapshots) {
          if (!isMock && (snapshots.snapshot1.data == null)) {
            return const SizedBox();
          }
          final setpointState = snapshots.snapshot1.data;
          final double currentSetpoint =
              setpointState != null ? double.parse(setpointState.state) : 0;

          final currentTempState = currentTemperatureStream != null
              ? snapshots.snapshot2.data
              : null;
          final currentTemp = currentTempState?.itemState;

          final currentHumidity =
              currentHumidityStream != null ? snapshots.snapshot3.data : null;
          final humidity = currentHumidity?.itemState;

          final modeState =
              modeStream != null ? snapshots.snapshot4.data : null;
          final mode = modeState?.itemState;

          return DimmableWidgetContainer(
              key: ValueKey(setpointState.toString()),
              value: currentSetpoint,
              minValue: setpointState?.stateDescription?.minimum ?? 0,
              maxValue: setpointState?.stateDescription?.maximum ?? 30,
              onDragDone:
                  !(setpointState?.isReadOnly ?? true) ? onDragDone : null,
              onLongTap: item != null ? () => onLongTap(context) : null,
              colorScheme: colorScheme,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoHyphenatingText(!isMock ? item!.label : "Thermostat",
                        maxLines: 3,
                        style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                setpointState?.itemState ??
                                    (isMock ? "20.0 °C" : "-"),
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              if (mode != null || isMock)
                                Text(
                                  mode ?? (isMock ? "AUTO" : "-"),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.thermostat_rounded,
                                  color: colorScheme.primary,
                                ),
                                const Gap(6),
                                Text(
                                  currentTemp ?? (isMock ? "21.5 °C" : "-"),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ]),
                              if (currentHumidityStream != null || isMock)
                                Row(children: [
                                  Icon(
                                    Icons.water_drop_outlined,
                                    color: colorScheme.primary,
                                  ),
                                  const Gap(6),
                                  Text(
                                    humidity ?? (isMock ? "54 %" : "-"),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                ]),
                            ]),
                      ],
                    ),
                    const Spacer()
                  ]));
        });
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.playerStringAction(
        item!.ohName, value.toStringAsFixed(2));
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context,
      ThermostatItemDialog(
        itemName: item!.ohName,
        colorScheme: colorScheme,
      ),
      item!,
      colorScheme);
}
