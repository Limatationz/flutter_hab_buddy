import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/services/snackbar_service.dart';
import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/items/item_type.dart';
import '../../../../../core/database/items/oh_item_type.dart';
import '../../../../core/hive/state/item_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../../../util/form/base_form_searchable_dropdown.dart';
import '../../../util/general/delete_dialog.dart';
import '../general/item_widget.dart';
import 'thermostat_data.dart';
import 'thermostat_item_base_widget.dart';

class ThermostatAddView extends StatefulWidget {
  final int roomId;
  final ThermostatData? thermostatData;

  const ThermostatAddView(
      {super.key, required this.roomId, this.thermostatData});

  @override
  State<ThermostatAddView> createState() => _ThermostatAddViewState();
}

class _ThermostatAddViewState extends State<ThermostatAddView> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _itemsRepository = locator<ItemRepository>();
  final _snackBarService = locator<SnackbarService>();

  bool get isAdd => widget.thermostatData == null;

  Stream<ItemState>? heatingSetpointStateStream;
  Stream<ItemState>? currentTemperatureStateStream;
  Stream<ItemState>? currentHumidityStateStream;
  Stream<ItemState>? modeStateStream;

  @override
  void initState() {
    if (!isAdd) {
      heatingSetpointStateStream = _itemsStore
          .watchStateByName(widget.thermostatData!.heatingSetpointItemName)
          .whereNotNull();
      currentTemperatureStateStream = _itemsStore
          .watchStateByName(widget.thermostatData!.currentTemperatureItemName)
          .whereNotNull();
      if (widget.thermostatData!.modeItemName != null) {
        modeStateStream = _itemsStore
            .watchStateByName(widget.thermostatData!.modeItemName!)
            .whereNotNull();
      }
      if (widget.thermostatData!.currentHumidityItemName != null) {
        currentHumidityStateStream = _itemsStore
            .watchStateByName(widget.thermostatData!.currentHumidityItemName!)
            .whereNotNull();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isAdd ? "Add Thermostat" : "Edit Thermostat"),
          actions: [
            if (!isAdd)
              IconButton(
                  onPressed: () async {
                    final result = await showDeleteItemDialog(
                        context: context,
                        itemLabel:
                            widget.thermostatData!.heatingSetpointItemName);
                    if (result == true) {
                      _itemsRepository.removeItems([
                        widget.thermostatData!.heatingSetpointItemName,
                        widget.thermostatData!.currentTemperatureItemName,
                        if (widget
                                .thermostatData!.currentHumidityItemName !=
                            null)
                          widget.thermostatData!.currentHumidityItemName!,
                        if (widget.thermostatData!.modeItemName != null)
                          widget.thermostatData!.modeItemName!
                      ]).then((value) {
                        if (value) {
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  },
                  visualDensity: VisualDensity.compact,
                  iconSize: 28,
                  icon: Icon(
                    LineIconsFilled.trash_can,
                    color: Theme.of(context).colorScheme.error,
                  )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(LineIconsV5.floppy_disk_1),
            onPressed: () {
              _save().then((value) {
                if (value) {
                  Navigator.of(context).pop(null);
                }
              });
            }),
        body: FormBuilder(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(paddingScaffold),
          children: [
            Center(child: SizedBox(
                height: MediumWidthItemWidget.height,
                width: MediumWidthItemWidget.width,
                child: ThermostatItemBaseWidget(
                  item: null,
                  colorScheme: Theme.of(context).colorScheme,
                  heatingSetpointStream: heatingSetpointStateStream,
                  currentTemperatureStream: currentTemperatureStateStream,
                  currentHumidityStream: currentHumidityStateStream,
                  modeStream: modeStateStream,
                ))),
            const Gap(24),
            FutureBuilder(
                future: _itemsRepository.getItemNamesByOhType(OhItemType.number),
                builder: (context, future) {
                  if (future.data?.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  } else {
                    return BaseFormSearchableDropdown<String>(
                      name: "heatingSetpoint",
                      initialValue: widget.thermostatData?.heatingSetpointItemName,
                      items: future.data!,
                      label: "Heating Setpoint Item",
                      hintText:
                          "The Number Item that contains the heating setpoint",
                      validator: FormBuilderValidators.required(),
                      onChanged: (value) {
                        if (value != null) {
                          heatingSetpointStateStream = _itemsStore
                              .watchStateByName(value)
                              .whereNotNull();
                        } else {
                          heatingSetpointStateStream = null;
                        }
                        setState(() {});
                      },
                    );
                  }
                }),
            const Gap(listSpacing),
            FutureBuilder(
                future: _itemsRepository.getItemNamesByOhType(
                  OhItemType.number,
                ),
                builder: (context, future) {
                  if (future.data?.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  } else {
                    return BaseFormSearchableDropdown<String>(
                      name: "currentTemperature",
                      initialValue:
                          widget.thermostatData?.currentTemperatureItemName,
                      items: future.data!,
                      label: "Current Temperature Item",
                      hintText:
                          "The Number Item that contains the current temperature",
                      validator: FormBuilderValidators.required(),
                      onChanged: (value) {
                        if (value != null) {
                          currentTemperatureStateStream = _itemsStore
                              .watchStateByName(value)
                              .whereNotNull();
                        } else {
                          currentTemperatureStateStream = null;
                        }
                        setState(() {});
                      },
                    );
                  }
                }),
            const Gap(listSpacing),
            FutureBuilder(
                future:
                    _itemsRepository.getItemNamesByOhType(OhItemType.number),
                builder: (context, future) {
                  if (future.data?.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  } else {
                    return BaseFormSearchableDropdown<String>(
                      name: "currentHumidity",
                      initialValue:
                          widget.thermostatData?.currentHumidityItemName,
                      items: future.data!,
                      label: "Current Humidity Item",
                      hintText:
                          "The Number Item that contains the current humidity",
                      onChanged: (value) {
                        if (value != null) {
                          currentHumidityStateStream = _itemsStore
                              .watchStateByName(value)
                              .whereNotNull();
                        } else {
                          currentHumidityStateStream = null;
                        }
                        setState(() {});
                      },
                    );
                  }
                }),
            const Gap(listSpacing),
            FutureBuilder(
                future:
                    _itemsRepository.getItemNamesByOhType(OhItemType.string),
                builder: (context, future) {
                  if (future.data?.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  } else {
                    return BaseFormSearchableDropdown<String>(
                      name: "mode",
                      initialValue:
                          widget.thermostatData?.modeItemName,
                      items: future.data!,
                      label: "Mode Item",
                      hintText: "The String Item that contains the mode (AUTO/MANUAL/OFF)",
                      required: false,
                      onChanged: (value) {
                        if (value != null) {
                          modeStateStream = _itemsStore
                              .watchStateByName(value)
                              .whereNotNull();
                        } else {
                          modeStateStream = null;
                        }
                        setState(() {});
                      },
                    );
                  }
                }),
          ],
        )));
  }

  Future<bool> _save() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formKey.currentState!.value;
      final setpointItem = values["heatingSetpoint"] as String;

      final inboxSetpointItem =
          await _itemsStore.byName(setpointItem).getSingleOrNull();
      final storedSetpointItem =
          await _itemsStore.byName(setpointItem).getSingleOrNull();
      if (inboxSetpointItem == null && storedSetpointItem == null) {
        _snackBarService.showSnackbar(
            message: S.current.complex_player_add_item_error,
            type: SnackbarType.error,
            title: S.current.errorHeadline);
        return false;
      }

      final currentTemperatureItem = values["currentTemperature"] as String;
      final currentHumidityItem = values["currentHumidity"] as String?;
      final modeItem = values["mode"] as String?;
      final thermostatItem = ThermostatData(
          heatingSetpointItemName: setpointItem,
          currentTemperatureItemName: currentTemperatureItem,
          currentHumidityItemName: currentHumidityItem,
          modeItemName: modeItem,);

      final currentTemperatureInboxItemData =
          await _itemsStore.byName(currentTemperatureItem).getSingleOrNull() ;
      final currentTemperatureStoredItemData =
          await _itemsStore.byName(currentTemperatureItem).getSingleOrNull();
      final currentHumidityItemData = currentHumidityItem != null
          ? await _itemsStore.byName(currentHumidityItem).getSingleOrNull()
          : null;
      final modeItemData = modeItem != null
          ? await _itemsStore.byName(modeItem).getSingleOrNull()
          : null;

      if (inboxSetpointItem != null &&
          (currentTemperatureInboxItemData != null || currentTemperatureStoredItemData != null)) {
        // add
        final setpointSuccess = await _itemsRepository.addItemFromInbox(
            item: inboxSetpointItem,
            type: ItemType.thermostat,
            roomId: widget.roomId);
        await _itemsStore.updateComplexJsonByName(
            thermostatItem.toJson(), setpointItem);

        final currentTemperatureSuccess = currentTemperatureInboxItemData != null ? await _itemsRepository.addItemFromInbox(
            item: currentTemperatureInboxItemData,
            type: ItemType.complexComponent,
            roomId: widget.roomId) : true;

        final currentHumiditySuccess = currentHumidityItemData != null
            ? await _itemsRepository.addItemFromInbox(
            item: currentHumidityItemData,
                type: ItemType.complexComponent,
                roomId: widget.roomId)
            : true;

        final modeSuccess = modeItemData != null
            ? await _itemsRepository.addItemFromInbox(
            item: modeItemData,
                type: ItemType.complexComponent,
                roomId: widget.roomId)
            : true;

        return setpointSuccess &&
            currentTemperatureSuccess &&
            currentHumiditySuccess &&
            modeSuccess;
      } else {
        // update
        await _itemsStore.updateComplexJsonByName(
            thermostatItem.toJson(), setpointItem);

        // check what changed
        final oldThermostatItem = widget.thermostatData;
        if (oldThermostatItem != null) {
          if (oldThermostatItem.currentTemperatureItemName != currentTemperatureItem && currentTemperatureInboxItemData != null) {
            await _itemsStore
                .deleteDataByName(oldThermostatItem.currentTemperatureItemName);

            await _itemsRepository.addItemFromInbox(
                item: currentTemperatureInboxItemData,
                type: ItemType.complexComponent,
                roomId: widget.roomId);
          }

          if (oldThermostatItem.currentHumidityItemName != currentHumidityItem &&
              currentHumidityItemData != null) {
            if (oldThermostatItem.currentHumidityItemName != null) {
              await _itemsStore
                  .deleteDataByName(oldThermostatItem.currentHumidityItemName!);
            }

            await _itemsRepository.addItemFromInbox(
                item: currentHumidityItemData,
                type: ItemType.complexComponent,
                roomId: widget.roomId);
          }
          if (oldThermostatItem.modeItemName != modeItem &&
              modeItemData != null) {
            if (oldThermostatItem.modeItemName != null) {
              await _itemsStore
                  .deleteDataByName(oldThermostatItem.modeItemName!);
            }

            await _itemsRepository.addItemFromInbox(
                item: modeItemData,
                type: ItemType.complexComponent,
                roomId: widget.roomId);
          }
          return true;
        } else {
          _snackBarService.showSnackbar(
              message: S.current.updateFailedError,
              type: SnackbarType.error,
              title: S.current.errorHeadline);
          return false;
        }
      }
    }
    _snackBarService.showSnackbar(
      message: S.current.errorHeadline,
      type: SnackbarType.error,
    );
    return false;
  }
}
