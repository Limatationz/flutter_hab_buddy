import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../core/hive/state/item_state.dart';
import '../general/multiple_items_state_injector.dart';
import 'thermostat_data.dart';

class ThermostatItemDialog extends StatelessWidget {
  final String itemName;
  final ColorScheme colorScheme;

  ThermostatItemDialog(
      {super.key, required this.itemName, required this.colorScheme});

  final _itemRepository = locator<ItemRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Item?>(
        stream: _itemsStore.byName(itemName).watchSingleOrNull(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          final item = snapshot.data!;
          final config = ThermostatData.fromJson(item.complexJson!);
          return MultipleItemStatesInjector(
              itemNames: [
                item.ohName,
              ],
              builder: (itemsStates) {
                final heatingSetpointState = itemsStates[item.ohName]!;
                final heatingSetpoint = heatingSetpointState?.state;

                return Column(children: [
                  ThermostatGauge(
                    heatingSetpointItemName: item.ohName,
                    colorScheme: colorScheme,
                    width: 200,
                    radiusFactor: 1,
                  ),
                ]);
              });
        });
  }

  Future<void> onAction(String action) async {
    await _itemRepository.stringAction(itemName, action);
  }
}

class ThermostatGauge extends StatefulWidget {
  final double width;
  final double radiusFactor;
  final String heatingSetpointItemName;
  final ColorScheme colorScheme;

  const ThermostatGauge(
      {super.key,
      required this.heatingSetpointItemName,
      required this.colorScheme,
      required this.width,
      required this.radiusFactor});

  @override
  State<ThermostatGauge> createState() => _ThermostatGaugeState();
}

class _ThermostatGaugeState extends State<ThermostatGauge> {
  final _itemRepository = locator<ItemRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  double _value = 0;
  ItemState? itemsState;

  @override
  void initState() {
    _itemsStore
        .watchStateByName(widget.heatingSetpointItemName)
        .listen((event) {
      if (event != null && mounted) {
        setState(() {
          _value = double.parse(event.state);
          itemsState ??= event;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Listener(
          behavior: HitTestBehavior.translucent,
          onPointerUp: (event) {
            onSetpointChange(_value);
          },
          child: Center(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  width: 200,
                  height: 160,
                  child: RadialGauge(
                    track: RadialTrack(
                      start: 0,
                      end: 40,
                      color: widget.colorScheme.secondaryContainer,
                      hideTrack: false,
                      trackStyle: TrackStyle(
                        showLabel: true,
                        secondaryRulerPerInterval: 4,
                        primaryRulerColor: widget.colorScheme.primary,
                        primaryRulersHeight: 5,
                        primaryRulersWidth: 1,
                      ),
                    ),
                    shapePointer: [
                      RadialShapePointer(
                        value: _value,
                        isInteractive: true,
                        color: widget.colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                    ],
                  )))),
      Center(
          child: Text(
        _value.toStringAsFixed(1),
        style: Theme.of(context).textTheme.titleMedium,
      ))
    ]);
  }

  Future<void> onSetpointChange(double value) =>
      _itemRepository.stringAction(
          widget.heatingSetpointItemName, value.toString());
}
