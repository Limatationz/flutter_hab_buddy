import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/services/snackbar_service.dart';
import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/items/item_type.dart';
import '../../../../../core/database/items/oh_item_type.dart';
import '../../../../../core/database/state/item_states_table.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../../util/constants.dart';
import '../../../../util/form/base_form_searchable_dropdown.dart';
import '../../../../util/general/base_elevated_button.dart';
import '../../../../util/general/delete_dialog.dart';
import '../../../../util/general/headline_padding_box.dart';
import '../../general/item_widget.dart';
import 'complex_player_data.dart';
import 'complex_player_item_base_widget.dart';

class ComplexPlayerAddSheet extends StatefulWidget {
  final int roomId;
  final ComplexPlayerData? complexPlayerData;

  const ComplexPlayerAddSheet(
      {super.key, required this.roomId, this.complexPlayerData});

  @override
  State<ComplexPlayerAddSheet> createState() => _ComplexPlayerAddSheetState();
}

class _ComplexPlayerAddSheetState extends State<ComplexPlayerAddSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;
  final _itemsRepository = locator<ItemRepository>();
  final _snackBarService = locator<SnackbarService>();

  bool get isAdd => widget.complexPlayerData == null;

  Stream<ItemState>? playerStateStream;
  Stream<ItemState>? imageStateStream;
  Stream<ItemState>? currentDurationStateStream;
  Stream<ItemState>? totalDurationStateStream;
  Stream<ItemState>? volumeDimmerStateStream;

  @override
  void initState() {
    if (!isAdd) {
      playerStateStream = _itemsStore
          .stateByName(widget.complexPlayerData!.playerItemName)
          .watchSingleOrNull()
          .whereNotNull();
      totalDurationStateStream = _itemsStore
          .stateByName(widget.complexPlayerData!.totalDurationItemName)
          .watchSingleOrNull()
          .whereNotNull();
      currentDurationStateStream = _itemsStore
          .stateByName(widget.complexPlayerData!.currentDurationItemName)
          .watchSingleOrNull()
          .whereNotNull();
      if (widget.complexPlayerData!.volumeDimmerItemName != null) {
        volumeDimmerStateStream = _itemsStore
            .stateByName(widget.complexPlayerData!.volumeDimmerItemName!)
            .watchSingleOrNull()
            .whereNotNull();
      }
      if (widget.complexPlayerData!.imageItemName != null) {
        imageStateStream = _itemsStore
            .stateByName(widget.complexPlayerData!.imageItemName!)
            .watchSingleOrNull()
            .whereNotNull();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                        isAdd ? "Add complex Player" : "Edit complex Player",
                        style: Theme.of(context)!.textTheme.headlineMedium)),
                if (!isAdd) const Gap(listSpacing),
                if (!isAdd)
                  IconButton(
                      onPressed: () async {
                        final result = await showDeleteItemDialog(
                            context: context,
                            itemLabel:
                                widget.complexPlayerData!.playerItemName);
                        if (result == true) {
                          _itemsRepository.removeItems([
                            widget.complexPlayerData!.playerItemName,
                            widget.complexPlayerData!.totalDurationItemName,
                            widget.complexPlayerData!.currentDurationItemName,
                            if (widget
                                    .complexPlayerData!.volumeDimmerItemName !=
                                null)
                              widget.complexPlayerData!.volumeDimmerItemName!,
                            if (widget.complexPlayerData!.imageItemName != null)
                              widget.complexPlayerData!.imageItemName!
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
            const HeadlinePaddingBox(),
            SizedBox(
                height: MediumWidthItemWidget.height,
                width: MediumWidthItemWidget.width,
                child: ComplexPlayerItemBaseWidget(
                  item: null,
                  colorScheme: Theme.of(context).colorScheme,
                  playerStateStream: playerStateStream,
                  imageStateStream: imageStateStream,
                  currentDurationStateStream: currentDurationStateStream,
                  totalDurationStateStream: totalDurationStateStream,
                  volumeDimmerStateStream: volumeDimmerStateStream,
                )),
            const Gap(24),
            FutureBuilder(
                future: _itemsRepository.getItemNamesByOhType(OhItemType.player,
                    onlyInbox: true),
                builder: (context, future) {
                  if (future.data?.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  } else {
                    return BaseFormSearchableDropdown<String>(
                      name: "playerItem",
                      initialValue: widget.complexPlayerData?.playerItemName,
                      items: future.data!,
                      label: "Player Item",
                      hintText:
                          "The player item that controls Play/Pause/Next/Previous",
                      validator: FormBuilderValidators.required(),
                      onChanged: (value) {
                        if (value != null) {
                          playerStateStream = _inboxStore
                              .byName(value)
                              .watchSingleOrNull()
                              .whereNotNull()
                              .map((event) =>
                                  ItemStateFromInboxEntry.convert(event));
                        } else {
                          playerStateStream = null;
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
                      name: "totalDurationItem",
                      initialValue:
                          widget.complexPlayerData?.totalDurationItemName,
                      items: future.data!,
                      label: "Total Duration Item",
                      hintText:
                          "The Number Item that contains the total duration of the media (in s or ms)",
                      validator: FormBuilderValidators.required(),
                      onChanged: (value) {
                        if (value != null) {
                          totalDurationStateStream = _inboxStore
                              .byName(value)
                              .watchSingleOrNull()
                              .whereNotNull()
                              .map((event) =>
                                  ItemStateFromInboxEntry.convert(event));
                        } else {
                          totalDurationStateStream = null;
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
                      name: "currentDurationItem",
                      initialValue:
                          widget.complexPlayerData?.currentDurationItemName,
                      items: future.data!,
                      label: "Current Duration Item",
                      hintText:
                          "The Number Item that contains the current duration of the media (in s or ms)",
                      validator: FormBuilderValidators.required(),
                      onChanged: (value) {
                        if (value != null) {
                          currentDurationStateStream = _inboxStore
                              .byName(value)
                              .watchSingleOrNull()
                              .whereNotNull()
                              .map((event) =>
                                  ItemStateFromInboxEntry.convert(event));
                        } else {
                          currentDurationStateStream = null;
                        }
                        setState(() {});
                      },
                    );
                  }
                }),
            const Gap(listSpacing),
            FutureBuilder(
                future:
                    _itemsRepository.getItemNamesByOhType(OhItemType.dimmer),
                builder: (context, future) {
                  if (future.data?.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  } else {
                    return BaseFormSearchableDropdown<String>(
                      name: "volumeDimmerItem",
                      initialValue:
                          widget.complexPlayerData?.volumeDimmerItemName,
                      items: future.data!,
                      label: "Volume Item",
                      hintText: "The Dimmer Item that controls the volume",
                      required: false,
                      onChanged: (value) {
                        if (value != null) {
                          volumeDimmerStateStream = _inboxStore
                              .byName(value)
                              .watchSingleOrNull()
                              .whereNotNull()
                              .map((event) =>
                                  ItemStateFromInboxEntry.convert(event));
                        } else {
                          volumeDimmerStateStream = null;
                        }
                        setState(() {});
                      },
                    );
                  }
                }),
            const Gap(listSpacing),
            FutureBuilder(
                future: _itemsRepository.getItemNamesByOhType(OhItemType.image),
                builder: (context, future) {
                  if (future.data?.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  } else {
                    return BaseFormSearchableDropdown<String>(
                      name: "image",
                      initialValue: widget.complexPlayerData?.imageItemName,
                      items: future.data!,
                      label: "Image Item",
                      hintText:
                          "The Image Item that displays an image of the media",
                      required: false,
                      onChanged: (value) {
                        if (value != null) {
                          imageStateStream = _inboxStore
                              .byName(value)
                              .watchSingleOrNull()
                              .whereNotNull()
                              .map((event) =>
                                  ItemStateFromInboxEntry.convert(event));
                        } else {
                          imageStateStream = null;
                        }
                        setState(() {});
                      },
                    );
                  }
                }),
            const SizedBox(height: 16),
            BaseElevatedButton(
                text: S.current.save,
                onPressed: () {
                  _save().then((value) {
                    if (value) {
                      Navigator.of(context).pop(true);
                    }
                  });
                })
          ],
        ));
  }

  Future<bool> _save() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formKey.currentState!.value;
      final playerItemName = values["playerItem"] as String;

      final inboxPlayerItem =
          await _inboxStore.byName(playerItemName).getSingleOrNull();
      final storedPlayerItem =
          await _itemsStore.byName(playerItemName).getSingleOrNull();
      if (inboxPlayerItem == null && storedPlayerItem == null) {
        _snackBarService.showSnackbar(
            message: S.current.complex_player_add_item_error,
            type: SnackbarType.error,
            title: S.current.errorHeadline);
        return false;
      }

      final totalDurationItem = values["totalDurationItem"] as String;
      final currentDurationItem = values["currentDurationItem"] as String;
      final volumeDimmerItem = values["volumeDimmerItem"] as String?;
      final imageItem = values["image"] as String?;
      final complexPlayerItem = ComplexPlayerData(
          playerItemName: playerItemName,
          totalDurationItemName: totalDurationItem,
          currentDurationItemName: currentDurationItem,
          volumeDimmerItemName: volumeDimmerItem,
          imageItemName: imageItem);

      final totalDurationItemData =
          await _inboxStore.byName(totalDurationItem).getSingleOrNull();
      final currentDurationItemData =
          await _inboxStore.byName(currentDurationItem).getSingleOrNull();
      final volumeDimmerItemData = volumeDimmerItem != null
          ? await _inboxStore.byName(volumeDimmerItem).getSingleOrNull()
          : null;
      final imageItemData = imageItem != null
          ? await _inboxStore.byName(imageItem).getSingleOrNull()
          : null;

      if (inboxPlayerItem != null &&
          totalDurationItemData != null &&
          currentDurationItemData != null) {
        // add
        final playerSuccess = await _itemsRepository.addItemFromInbox(
            itemName: inboxPlayerItem.name,
            type: ItemType.complexPlayer,
            roomId: widget.roomId);
        await _itemsStore.updateComplexJsonByName(
            complexPlayerItem.toJson(), playerItemName);

        final totalDurationSuccess = await _itemsRepository.addItemFromInbox(
            itemName: totalDurationItemData.name,
            type: ItemType.complexComponent,
            roomId: widget.roomId);

        final currentDurationSuccess = await _itemsRepository.addItemFromInbox(
            itemName: currentDurationItemData.name,
            type: ItemType.complexComponent,
            roomId: widget.roomId);

        final volumeDimmerSuccess = volumeDimmerItemData != null
            ? await _itemsRepository.addItemFromInbox(
                itemName: volumeDimmerItemData.name,
                type: ItemType.complexComponent,
                roomId: widget.roomId)
            : true;

        final imageSuccess = imageItemData != null
            ? await _itemsRepository.addItemFromInbox(
                itemName: imageItemData.name,
                type: ItemType.complexComponent,
                roomId: widget.roomId)
            : true;

        return playerSuccess &&
            totalDurationSuccess &&
            currentDurationSuccess &&
            volumeDimmerSuccess &&
            imageSuccess;
      } else {
        // update
        await _itemsStore.updateComplexJsonByName(
            complexPlayerItem.toJson(), playerItemName);

        // check what changed
        final oldComplexPlayerItem = widget.complexPlayerData;
        if (oldComplexPlayerItem != null) {
          if (oldComplexPlayerItem.totalDurationItemName != totalDurationItem) {
            await _itemsStore
                .deleteDataByName(oldComplexPlayerItem.totalDurationItemName);

            await _itemsRepository.addItemFromInbox(
                itemName: totalDurationItem,
                type: ItemType.complexComponent,
                roomId: widget.roomId);
          }
          if (oldComplexPlayerItem.currentDurationItemName !=
                  currentDurationItem &&
              currentDurationItemData != null) {
            await _itemsStore
                .deleteDataByName(oldComplexPlayerItem.currentDurationItemName);

            await _itemsRepository.addItemFromInbox(
                itemName: currentDurationItemData.name,
                type: ItemType.complexComponent,
                roomId: widget.roomId);
          }
          if (oldComplexPlayerItem.volumeDimmerItemName != volumeDimmerItem &&
              volumeDimmerItemData != null) {
            if (oldComplexPlayerItem.volumeDimmerItemName != null) {
              await _itemsStore
                  .deleteDataByName(oldComplexPlayerItem.volumeDimmerItemName!);
            }

            await _itemsRepository.addItemFromInbox(
                itemName: volumeDimmerItemData.name,
                type: ItemType.complexComponent,
                roomId: widget.roomId);
          }
          if (oldComplexPlayerItem.imageItemName != imageItem &&
              imageItemData != null) {
            if (oldComplexPlayerItem.imageItemName != null) {
              await _itemsStore
                  .deleteDataByName(oldComplexPlayerItem.imageItemName!);
            }

            await _itemsRepository.addItemFromInbox(
                itemName: imageItemData!.name,
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
