import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';
import 'package:reorderables/reorderables.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/favourites/favourites_view_settings.dart';
import '../../../generated/l10n.dart';
import '../../../util/color.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';
import '../../util/general/base_refresh_indicator.dart';
import '../../util/general/base_scaffold.dart';
import '../../util/general/wall_mount_indicator.dart';
import '../../util/general/widget_container.dart';
import '../inbox/inbox_action_button.dart';
import '../items/general/item_widget.dart';
import '../items/sensors/sensor_item_widget.dart';
import 'favourite_settings_dialog.dart';
import 'favourite_viewmodel.dart';

class FavouriteView extends StatelessWidget {
  static const String routePath = '/favourite';
  static const String routeName = 'FavouriteView';

  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouriteViewModel>.reactive(
        viewModelBuilder: () => FavouriteViewModel(),
        builder: (context, model, _) => BaseScaffold(
            bodyBuilder: (context, isWallMountEnabled) => isWallMountEnabled
                ? SafeArea(child: _buildBody(context, model))
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar.medium(
                        title: Text(S.current.navigationFavorites),
                        actions: [
                          if (model.viewSettings.viewType ==
                              FavouriteViewType.manual)
                            IconButton(
                              onPressed: model.toggleReorder,
                              tooltip: 'Reorder rooms and items',
                              icon: Icon(
                                LineIconsV5.layout_9,
                                color: model.reorderEnabled
                                    ? ColorScheme.of(context).primary
                                    : null,
                              ),
                            ),
                          IconButton(
                              onPressed: () {
                                showFavouriteSettingsDialog(context, model);
                              },
                              icon: const Icon(LineIconsV5.gear_eye)),
                          WallMountModeIndicator(),
                          InboxActionButton(countInbox: model.countInboxStream),
                        ],
                      )
                    ],
                    body: _buildBody(context, model),
                  )));
  }

  Widget _buildBody(BuildContext context, FavouriteViewModel model) =>
      StreamBuilder<bool>(
        stream: model.hasItemsStream,
        builder: (context, hasItems) {
          if (hasItems.data ?? false) {
            return StreamBuilder2<Map<int, List<Item>>, List<Room>>(
                streams:
                    StreamTuple2(model.itemsByRoomIdStream, model.roomsStream),
                builder: (context, snapshot) {
                  if (!snapshot.snapshot1.hasData ||
                      !snapshot.snapshot2.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final groupedItems = snapshot.snapshot1.data!;
                    final rooms = snapshot.snapshot2.data!;

                    return BaseRefreshIndicator(
                        onRefresh: model.onRefresh,
                        child: LayoutBuilder(builder: (context, constraints) {
                          final roomsCrossAxisCount =
                              getRoomListCount(constraints.maxWidth);

                          if (model.viewSettings.viewType ==
                              FavouriteViewType.auto) {
                            final itemWidgetsByRoomId =
                                model.buildItemWidgetsByRoomIdForAuto(
                                    groupedItems,
                                    rooms,
                                    Theme.of(context).colorScheme,
                                    Theme.of(context).brightness);

                            final layout = getGridLayout(
                                roomsCrossAxisCount, itemWidgetsByRoomId);

                            return SingleChildScrollView(child: Padding(
                                padding: const EdgeInsets.all(
                                     paddingContainer),
                                child: StaggeredGrid.count(
                                  crossAxisCount: roomsCrossAxisCount,
                                  crossAxisSpacing:
                                      model.viewSettings.viewMode ==
                                              FavouriteViewMode.compact
                                          ? 0
                                          : paddingScaffold,
                                  mainAxisSpacing:
                                      model.viewSettings.viewMode ==
                                              FavouriteViewMode.compact
                                          ? 0
                                          : paddingScaffold,
                                  children: List.generate(
                                    layout.values.expand((list) => list).length,
                                    // Total number of rooms
                                    (index) {
                                      final flattenedRooms = layout.entries
                                          .expand((entry) => entry.value)
                                          .toList();

                                      final roomId = flattenedRooms[index];
                                      final items =
                                          itemWidgetsByRoomId[roomId]!;
                                      final sensors = items.item2;
                                      final realItems = items.item1;

                                      final room = rooms.firstWhere(
                                          (element) => element.id == roomId);
                                      final roomColorScheme = room.color != null
                                          ? ColorScheme.fromSeed(
                                              seedColor: fromHex(room.color!),
                                              brightness:
                                                  Theme.of(context).brightness)
                                          : Theme.of(context).colorScheme;

                                      switch (model.viewSettings.viewMode) {
                                        case FavouriteViewMode.compact:
                                          return StaggeredGridTile.fit(
                                              crossAxisCellCount: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30,
                                                    left: paddingScaffold),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  // Damit der Chip außerhalb des Stacks sichtbar ist
                                                  children: [
                                                    // Der eigentliche Container mit etwas Margin
                                                    WidgetContainer(
                                                      backgroundColor:
                                                          roomColorScheme
                                                              .primary
                                                              .withValues(
                                                                  alpha: 0.3),
                                                      onTap: () {
                                                        model.navigateToRoom(
                                                            context, room);
                                                      },
                                                      child: _buildItemsView(
                                                          realItems,
                                                          sensors,
                                                          roomColorScheme),
                                                    ),

                                                    // Der Chip-Tag oben links, überlappend
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child:
                                                          Transform.translate(
                                                        offset: const Offset(
                                                            -12, -24),
                                                        // Halb über dem Container
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: roomColorScheme
                                                                .surfaceContainer,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color: roomColorScheme
                                                                    .onPrimary),
                                                          ),
                                                          child: Text(room.name,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                      color: roomColorScheme
                                                                          .onSurface)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        case FavouriteViewMode.normal:
                                          return StaggeredGridTile.fit(
                                            crossAxisCellCount: 1,
                                            child: WidgetContainer(
                                              backgroundColor: roomColorScheme
                                                  .primary
                                                  .withValues(alpha: 0.3),
                                              onTap: () {
                                                model.navigateToRoom(
                                                    context, room);
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(room.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium),
                                                  const Gap(listSpacing),
                                                  _buildItemsView(realItems,
                                                      sensors, roomColorScheme),
                                                ],
                                              ),
                                            ),
                                          );
                                      }
                                    },
                                  ),
                                )));
                          } else {
                            // manual layout
                            return _buildManualLayout(context, model,
                                groupedItems, rooms, roomsCrossAxisCount);
                          }
                        }));
                  }
                });
          } else {
            return _buildEmptyState(context);
          }
        },
      );

  // Problem: When reordering the rooms, the sensors can not be reordered
  Widget _buildManualLayout(
      BuildContext context,
      FavouriteViewModel model,
      Map<int, List<Item>> groupedItems,
      List<Room> rooms,
      int roomsCrossAxisCount) {
    final manualRoomsSortOrder = model.viewSettings.manualRoomsSortOrder;
    final itemWidgetsByRoomId = model.buildItemWidgetsByRoomIdForManual(
        groupedItems,
        rooms,
        manualRoomsSortOrder,
        Theme.of(context).colorScheme,
        Theme.of(context).brightness);

    if (model.reorderEnabled) {
      return Padding(
          padding: const EdgeInsets.all(paddingContainer),
          child: ReorderableStaggeredScrollView.grid(
            key: ValueKey("rooms" + model.reorderEnabled.toString()),
            crossAxisCount: roomsCrossAxisCount,
            isLongPressDraggable: false,
            isDragNotification: true,
            enable: false,
            hitTestBehavior: HitTestBehavior.opaque,
            onAccept: (item1, item2, accepted, list) {
              model.onReorderRooms(list.map((e) => e.toString()).toList());
            },
            children: itemWidgetsByRoomId.entries.mapIndexed(
              (index, e) {
                final roomId = e.key;
                final items = itemWidgetsByRoomId[roomId]!;
                final sensors = items.item2;
                final realItems = items.item1;

                final room =
                    rooms.firstWhere((element) => element.id == roomId);
                final roomColorScheme = room.color != null
                    ? ColorScheme.fromSeed(
                        seedColor: fromHex(room.color!),
                        brightness: Theme.of(context).brightness)
                    : Theme.of(context).colorScheme;

                return ReorderableStaggeredScrollViewGridCountItem(
                  key: ValueKey(roomId),
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  widget: WidgetContainer(
                    backgroundColor:
                        roomColorScheme.primary.withValues(alpha: 0.3),
                    disableTap: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(room.name,
                            style: Theme.of(context).textTheme.headlineMedium),
                        const Gap(listSpacing),
                        _buildItemsReorderView(
                            realItems, sensors, roomColorScheme, roomId, model),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.all(paddingContainer),
          child: StaggeredGrid.count(
            crossAxisCount: roomsCrossAxisCount,
            crossAxisSpacing: paddingScaffold,
            mainAxisSpacing: paddingScaffold,
            children: itemWidgetsByRoomId.entries.mapIndexed(
              (index, e) {
                final roomId = e.key;
                final items = itemWidgetsByRoomId[roomId]!;
                final sensors = items.item2;
                final realItems = items.item1;

                final room =
                    rooms.firstWhere((element) => element.id == roomId);
                final roomColorScheme = room.color != null
                    ? ColorScheme.fromSeed(
                        seedColor: fromHex(room.color!),
                        brightness: Theme.of(context).brightness)
                    : Theme.of(context).colorScheme;

                return StaggeredGridTile.fit(
                  crossAxisCellCount: 1,
                  child: ReorderableDragStartListener(
                    index: index,
                    key: ValueKey(roomId),
                    child: WidgetContainer(
                      backgroundColor:
                          roomColorScheme.primary.withValues(alpha: 0.3),
                      onTap: () {
                        model.navigateToRoom(context, room);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(room.name,
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const Gap(listSpacing),
                          _buildItemsView(realItems, sensors, roomColorScheme),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ));
    }
  }

  Widget _buildItemsView(List<ItemWidget> items, List<SensorItemWidget> sensors,
      ColorScheme colorScheme) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (sensors.isNotEmpty)
        Wrap(spacing: listSpacing, runSpacing: listSpacing, children: sensors),
      if (sensors.isNotEmpty)
        Padding(
            padding: const EdgeInsets.symmetric(vertical: smallListSpacing),
            child: Divider(
              color: colorScheme.onSurface.withValues(alpha: 0.2),
            )),
      LayoutBuilder(
          builder: (context, constraints) => StaggeredGrid.count(
                crossAxisCount: getItemListCount(constraints.maxWidth),
                mainAxisSpacing: listSpacing,
                crossAxisSpacing: listSpacing,
                children: items
                    .map((e) => StaggeredGridTile.count(
                        crossAxisCellCount: e.crossAxisCount,
                        mainAxisCellCount: e.mainAxisCount,
                        child: e))
                    .toList(),
              ))
    ]);
  }

  Widget _buildItemsReorderView(
      List<ItemWidget> items,
      List<SensorItemWidget> sensors,
      ColorScheme colorScheme,
      int roomId,
      FavouriteViewModel model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (sensors.isNotEmpty)
        ReorderableWrap(
            onReorder: model.reorderSensors,
            spacing: listSpacing,
            runSpacing: listSpacing,
            children: sensors),
      if (sensors.isNotEmpty)
        Padding(
            padding: const EdgeInsets.symmetric(vertical: smallListSpacing),
            child: Divider(
              color: colorScheme.onSurface.withValues(alpha: 0.2),
            )),
      LayoutBuilder(
          builder: (context, constraints) =>
              ReorderableStaggeredScrollView.grid(
                key: ValueKey(
                    "items-$roomId-" + model.reorderEnabled.toString()),
                crossAxisCount: getItemListCount(constraints.maxWidth),
                children: items
                    .map((e) => ReorderableStaggeredScrollViewGridCountItem(
                        key: ValueKey(e.item?.ohName ?? ""),
                        crossAxisCellCount: e.crossAxisCount,
                        mainAxisCellCount: e.mainAxisCount.toInt(),
                        widget: e))
                    .toList(),
              ))
    ]);
  }

  Widget _buildEmptyState(BuildContext context) {
    return const Center(
      child: Text("No favorites available"),
    );
  }

  Map<int, List<int>> getGridLayoutOld(int crossAxisCount,
      Map<int, Tuple2<List<ItemWidget>, List<SensorItemWidget>>> itemsByRoom) {
    if (crossAxisCount == 1) {
      return {0: itemsByRoom.keys.toList()};
    } else {
      final realItemsByRoom =
          itemsByRoom.map((key, value) => MapEntry(key, value.item1));
      final Map<int, int> sensorCountByRoom =
          itemsByRoom.map((key, value) => MapEntry(key, value.item2.length));

      // get height of each room
      final roomsByHeight = Map.fromEntries(realItemsByRoom.entries.map((e) =>
          MapEntry(
              e.key,
              e.value.fold<double>(
                      0,
                      (previousValue, element) =>
                          previousValue + element.mainAxisCount) +
                  sensorCountByRoom[e.key]!)));
      // sort by height
      final sortedRoomsByHeight = roomsByHeight.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      final sortedRoomsByHeightMap =
          Map.fromEntries(sortedRoomsByHeight.map((e) => MapEntry(e.key, e)));

      // calculate layout by height of the rooms with the cross axis count
      final layout = <int, List<int>>{};
      int currentCrossAxisIndex = 0;
      double currentMainAxisIndex = 0;
      for (final entry in sortedRoomsByHeightMap.values) {
        final room = entry.key;
        final height = entry.value;
        if (currentMainAxisIndex + height > crossAxisCount) {
          currentCrossAxisIndex++;
          currentMainAxisIndex = 0;
        }
        layout.putIfAbsent(currentCrossAxisIndex, () => []);
        layout[currentCrossAxisIndex]!.add(room);
        currentMainAxisIndex += height;
      }
      return layout;
    }
  }

  Map<int, List<int>> getGridLayout(int crossAxisCount,
      Map<int, Tuple2<List<ItemWidget>, List<SensorItemWidget>>> itemsByRoom) {
    if (crossAxisCount == 1) {
      return {0: itemsByRoom.keys.toList()};
    }

    final realItemsByRoom =
        itemsByRoom.map((key, value) => MapEntry(key, value.item1));
    final Map<int, int> sensorCountByRoom =
        itemsByRoom.map((key, value) => MapEntry(key, value.item2.length));

    // Compute the height of each room
    final roomsByHeight = realItemsByRoom.map((roomId, items) => MapEntry(
          roomId,
          items.fold<double>(
                  0,
                  (prev, item) =>
                      prev + item.mainAxisCount) + // Sum of item heights
              sensorCountByRoom[roomId]!, // Add sensor items
        ));

    // Sort rooms by height in descending order
    final sortedRooms = roomsByHeight.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Initialize columns
    final columnHeights = List<double>.filled(crossAxisCount, 0);
    final layout = <int, List<int>>{
      for (var i = 0; i < crossAxisCount; i++) i: []
    };

    // Distribute rooms into columns
    for (final entry in sortedRooms) {
      final roomId = entry.key;
      final roomHeight = entry.value;

      // Find the column with the least height
      int targetColumn = 0;
      double minHeight = columnHeights[0];

      for (int i = 1; i < crossAxisCount; i++) {
        if (columnHeights[i] < minHeight) {
          minHeight = columnHeights[i];
          targetColumn = i;
        }
      }

      // Place room in the best column
      layout[targetColumn]!.add(roomId);
      columnHeights[targetColumn] += roomHeight;
    }

    return layout;
  }
}
