import 'dart:async';

import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/state/state_utils.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../../util/constants.dart';
import '../../general/multiple_items_state_injector.dart';
import 'complex_player_data.dart';

class ComplexPlayerItemDialog extends StatelessWidget {
  final String itemName;
  final ColorScheme colorScheme;

  ComplexPlayerItemDialog(
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
          final config = ComplexPlayerData.fromJson(item.complexJson!);
          return MultipleItemStatesInjector(
              itemNames: [
                item.ohName,
                if (config.imageItemName != null) config.imageItemName!,
              ],
              builder: (itemsStates) {
                final playerState = itemsStates[item.ohName]!;
                final isPlaying = playerState.state == "PLAY";
                final imageState = config.imageItemName != null
                    ? itemsStates[config.imageItemName!]
                    : null;
                final image = parseImage(imageState?.state);

                return Column(children: [
                  if (image != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: listSpacing),
                      child: CachedMemoryImage(
                        uniqueKey: config.imageItemName!,
                        base64: image,
                        height: 200,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(LineIcons.image),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
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
                  ),
                  const Gap(listSpacing),
                  MultipleItemStatesInjector(
                      itemNames: [
                        config.currentDurationItemName,
                        config.totalDurationItemName
                      ],
                      builder: (itemsStates) {
                        final currentDurationState =
                            itemsStates[config.currentDurationItemName];
                        final currentDuration =
                            parseDuration(currentDurationState?.state);
                        final totalDurationState =
                            itemsStates[config.totalDurationItemName];
                        final totalDuration =
                            parseDuration(totalDurationState?.state);

                        return Row(children: [
                          Text(currentDuration != null
                              ? Duration(seconds: currentDuration)
                                  .toString()
                                  .split('.')
                                  .first
                              : "-"),
                          const Gap(12),
                          Expanded(
                              child: LinearProgressIndicator(
                                  value: currentDuration != null &&
                                          totalDuration != null
                                      ? currentDuration / totalDuration
                                      : 0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      colorScheme.primary))),
                          const Gap(12),
                          Text(totalDuration != null
                              ? Duration(seconds: totalDuration)
                                  .toString()
                                  .split('.')
                                  .first
                              : "-"),
                        ]);
                      }),
                  if (config.volumeDimmerItemName != null)
                    const Gap(listSpacing),
                  if (config.volumeDimmerItemName != null)
                    VolumeSlider(itemName: config.volumeDimmerItemName!)
                ]);
              });
        });
  }

  Future<void> onAction(String action) async {
    await _itemRepository.playerStringAction(itemName, action);
  }
}

class VolumeSlider extends StatefulWidget {
  final String itemName;

  const VolumeSlider({super.key, required this.itemName});

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  final _itemRepository = locator<ItemRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  double _value = 0;
  ItemState? itemsState;

  @override
  void initState() {
    _itemsStore
        .stateByName(widget.itemName)
        .watchSingleOrNull()
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
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LineIcons.volume_low),
          Expanded(
              child: SizedBox(
                  height: 20,
                  child: Slider(
                    value: _value,
                    min: itemsState?.stateDescription?.minimum ?? 0,
                    max: itemsState?.stateDescription?.maximum ?? 100,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    onChangeEnd: (value) {
                      onVolumeChange(value);
                    },
                  ))),
          const Icon(LineIcons.volume_high),
        ],
      ),
      Center(
        child: Text("${_value.toStringAsFixed(0)}%"),
      )
    ]);
  }

  Future<void> onVolumeChange(double value) =>
      _itemRepository.playerStringAction(widget.itemName, value.toString());
}
