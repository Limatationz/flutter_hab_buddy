import 'dart:async';

import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/items/items_table.dart';
import '../../../../../core/database/state/state_utils.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../../util/general/widget_container.dart';
import '../../general/item_widget.dart';
import '../../general/item_widget_factory.dart';
import 'complex_player_data.dart';
import 'complex_player_item_dialog.dart';

class ComplexPlayerItemBaseWidget extends MediumWidthItemWidget {
  final Stream<ItemState>? playerStateStream;
  final Stream<ItemState>? imageStateStream;
  final Stream<ItemState>? currentDurationStateStream;
  final Stream<ItemState>? totalDurationStateStream;
  final Stream<ItemState>? volumeDimmerStateStream;
  final bool disableTap;

  ComplexPlayerItemBaseWidget({
    super.key,
    required super.item,
    required super.colorScheme,
    this.playerStateStream,
    this.imageStateStream,
    this.currentDurationStateStream,
    this.totalDurationStateStream,
    this.volumeDimmerStateStream,
    this.disableTap = false,
  });

  final _itemRepository = locator<ItemRepository>();

  bool get isMock => item == null;

  @override
  Widget build(BuildContext context) {
    final config = item?.complexJson != null
        ? ComplexPlayerData.fromJson(item!.complexJson!)
        : null;
    return StreamBuilder3(
        streams: StreamTuple3<ItemState?, ItemState?, ItemState?>(
            playerStateStream ?? const Stream.empty(),
            imageStateStream ?? const Stream.empty(),
            volumeDimmerStateStream ?? const Stream.empty()),
        builder: (context, snapshots) {
          if (!isMock && (snapshots.snapshot1.data == null)) {
            return const SizedBox();
          }
          final playerState = snapshots.snapshot1.data;
          final isPlaying = playerState?.state == "PLAY";
          final imageState =
              imageStateStream != null ? snapshots.snapshot2.data : null;
          final image = parseImage(imageState?.state);
          final volumeDimmerState =
              volumeDimmerStateStream != null ? snapshots.snapshot3.data : null;

          return WidgetContainer(
              key: ValueKey(playerState.toString()),
              onLongTap: item != null ? () => onLongTap(context) : null,
              colorScheme: colorScheme,
              disableTap: disableTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoHyphenatingText(!isMock ? item!.label : "Complex Player",
                      maxLines: 3,
                      style: Theme.of(context).textTheme.titleMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (image != null)
                        CachedMemoryImage(
                          uniqueKey: config?.imageItemName ?? image,
                          base64: image,
                          height: 40,
                          width: 40,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(LineIcons.image, size: 40),
                        )
                      else if (isMock)
                        const Icon(LineIcons.image, size: 40),
                      IconButton(
                        onPressed:
                            item != null ? () => onAction("PREVIOUS") : null,
                        icon: const Icon(LineIconsFilled.previous),
                      ),
                      if (!isPlaying)
                        IconButton.filled(
                          style: IconButton.styleFrom(
                              backgroundColor: colorScheme.primary),
                          onPressed:
                              item != null ? () => onAction("PLAY") : null,
                          icon: const Icon(LineIcons.play),
                        )
                      else
                        IconButton.filled(
                          style: IconButton.styleFrom(
                              backgroundColor: colorScheme.primary),
                          onPressed:
                              item != null ? () => onAction("PAUSE") : null,
                          icon: const Icon(LineIcons.pause),
                        ),
                      IconButton(
                        onPressed: item != null ? () => onAction("NEXT") : null,
                        icon: const Icon(LineIconsFilled.next),
                      ),
                    ],
                  ),
                  StreamBuilder2(
                      streams: StreamTuple2(
                        currentDurationStateStream ?? const Stream.empty(),
                        totalDurationStateStream ?? const Stream.empty(),
                      ),
                      builder: (context, snapshots) {
                        final currentDurationState =
                            currentDurationStateStream != null
                                ? snapshots.snapshot1.data
                                : null;
                        final currentDuration =
                            parseDuration(currentDurationState?.state);
                        final totalDurationState =
                            totalDurationStateStream != null
                                ? snapshots.snapshot2.data
                                : null;
                        final totalDuration =
                            parseDuration(totalDurationState?.state);
                        return Row(children: [
                          Text(currentDuration != null
                              ? Duration(seconds: currentDuration)
                                  .toString()
                                  .split('.')
                                  .first
                                  .substring(
                                      (totalDuration ?? double.infinity) < 3600
                                          ? 2
                                          : 0)
                              : isMock
                                  ? "00:00"
                                  : "-"),
                          const Gap(12),
                          Expanded(
                              child: LinearProgressIndicator(
                                  value: currentDuration != null &&
                                          totalDuration != null
                                      ? currentDuration / totalDuration
                                      : isMock
                                          ? 0.3
                                          : 0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      colorScheme.primary))),
                          const Gap(12),
                          Text(totalDuration != null
                              ? Duration(seconds: totalDuration.toInt())
                                  .toString()
                                  .split('.')
                                  .first
                                  .substring(totalDuration < 3600 ? 2 : 0)
                              : isMock
                                  ? "00:00"
                                  : "-"),
                          if (volumeDimmerState != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Gap(12),
                                const Icon(LineIcons.volume_medium),
                                const Gap(2),
                                Text(volumeDimmerState.state),
                              ],
                            )
                        ]);
                      })
                ],
              ));
        });
  }

  Future<void> onAction(String action) async {
    await _itemRepository.stringAction(item!.ohName, action);
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context,
      ComplexPlayerItemDialog(
        itemName: item!.ohName,
        colorScheme: colorScheme,
      ),
      item!,
      colorScheme);
}
