
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';

import '../../../core/database/app_database.dart';
import '../../../util/color.dart';
import '../../util/constants.dart';
import '../../util/general/base_refresh_indicator.dart';
import '../../util/general/widget_container.dart';
import '../inbox/inbox_action_button.dart';
import '../items/general/item_widget.dart';
import '../items/sensors/sensor_item_widget.dart';
import 'favourite_viewmodel.dart';

class FavouriteView extends StatelessWidget {
  static const String routePath = '/favourite';
  static const String routeName = 'FavouriteView';

  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouriteViewModel>.reactive(
        viewModelBuilder: () => FavouriteViewModel(),
        builder: (context, model, _) => Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar.medium(
                        title: const Text("Favorites"),
                        actions: [
                          InboxActionButton(countInbox: model.countInboxStream),
                        ],
                      )
                    ],
                body: StreamBuilder<bool>(
                  stream: model.hasItemsStream,
                  builder: (context, hasItems) {
                    if (hasItems.data ?? false) {
                      return StreamBuilder2<Map<int, List<Item>>, List<Room>>(
                          streams: StreamTuple2(
                              model.itemsByRoomIdStream, model.roomsStream),
                          builder: (context, snapshot) {
                            if (!snapshot.snapshot1.hasData ||
                                !snapshot.snapshot2.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              final groupedItems = snapshot.snapshot1.data!;
                              final rooms = snapshot.snapshot2.data!;

                              final itemWidgetsByRoomId =
                                  model.buildItemWidgetsByRoomId(
                                      groupedItems,
                                      rooms,
                                      Theme.of(context)
                                          .colorScheme,
                                      Theme.of(context)
                                          .brightness);

                              return BaseRefreshIndicator(
                                  onRefresh: model.onRefresh,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    final roomsCrossAxisCount =
                                        getRoomListCount(constraints.maxWidth);

                                    final layout = getGridLayout(
                                        roomsCrossAxisCount,
                                        itemWidgetsByRoomId);

                                    return MasonryGridView.count(
                                      padding: const EdgeInsets.all(
                                          paddingContainer),
                                      crossAxisCount: roomsCrossAxisCount,
                                      crossAxisSpacing: paddingScaffold,
                                      mainAxisSpacing: paddingScaffold,
                                      itemCount: groupedItems.keys.length,
                                      itemBuilder: (context, index) {
                                        final layoutIndex =
                                            index % layout.keys.length;
                                        final roomIndex = index -
                                            layoutIndex *
                                                (roomsCrossAxisCount - 1);
                                        print(
                                            "layoutIndex: $layoutIndex, roomIndex: $roomIndex, index: $index, roomsCrossAxisCount: $roomsCrossAxisCount");
                                        final roomId = layout.entries
                                            .elementAt(layoutIndex)
                                            .value
                                            .elementAt(roomIndex);
                                        final items =
                                            itemWidgetsByRoomId[roomId]!;
                                        final sensors = items.item2;
                                        final realItems = items.item1;

                                        final room = rooms.firstWhere(
                                            (element) => element.id == roomId);
                                        final roomColorScheme = room.color !=
                                                null
                                            ? ColorScheme.fromSeed(
                                                seedColor: fromHex(room.color!),
                                                brightness:
                                                    Theme.of(context)
                                                        .brightness)
                                            : Theme.of(context)
                                                .colorScheme;

                                        return WidgetContainer(
                                            backgroundColor: roomColorScheme
                                                .primary
                                                .withOpacity(0.3),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(room.name,
                                                    style: Theme.of(
                                                            context)
                                                        .textTheme
                                                        .headlineMedium),
                                                const Gap(listSpacing),
                                                // items
                                                _buildItemsView(realItems,
                                                    sensors, roomColorScheme),
                                              ],
                                            ));
                                      },
                                    );
                                  }));
                            }
                          });
                    } else {
                      return _buildEmptyState(context);
                    }
                  },
                ))));
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
              color: colorScheme.onBackground.withOpacity(0.2),
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

  Widget _buildEmptyState(BuildContext context) {
    return const Center(
      child: Text("No favorites available"),
    );
  }

  Map<int, List<int>> getGridLayout(int crossAxisCount,
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
}
