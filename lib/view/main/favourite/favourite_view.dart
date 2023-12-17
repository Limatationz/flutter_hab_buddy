import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/items_table.dart';
import '../../../util/color.dart';
import '../../util/constants.dart';
import '../../util/general/base_refresh_indicator.dart';
import '../../util/general/widget_container.dart';
import '../inbox/inbox_action_button.dart';
import '../items/item_widget_factory.dart';
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
                      return StreamBuilder2<
                              Tuple2<Map<int, List<Item>>, Map<int, Size>>,
                              List<Room>>(
                          streams: StreamTuple2(
                              model.itemsByRoomIdStream, model.roomsStream),
                          builder: (context, snapshot) {
                            if (!snapshot.snapshot1.hasData ||
                                !snapshot.snapshot2.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              final groupedItems =
                                  snapshot.snapshot1.data!.item1;
                              final roomSizes = snapshot.snapshot1.data!.item2;
                              final rooms = snapshot.snapshot2.data!;

                              return BaseRefreshIndicator(
                                  onRefresh: model.onRefresh,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    final roomsCrossAxisCount =
                                        getRoomListCount(constraints.maxWidth,
                                            roomSizes.values.toList());

                                    return MasonryGridView.count(
                                      padding: const EdgeInsets.all(
                                          paddingContainer),
                                      crossAxisCount: roomsCrossAxisCount,
                                      crossAxisSpacing: paddingScaffold,
                                      mainAxisSpacing: paddingScaffold,
                                      itemCount: groupedItems.keys.length,
                                      itemBuilder: (context, index) {
                                        final mapIndex =
                                            roomsCrossAxisCount == 1
                                                ? index
                                                : (index % roomsCrossAxisCount);
                                        print(
                                            "mapIndex: $mapIndex, index: $index, roomsCrossAxisCount: $roomsCrossAxisCount");
                                        final roomId = groupedItems.keys
                                            .toList()[mapIndex];
                                        final items = groupedItems[roomId]!;
                                        final room = rooms.firstWhere(
                                            (element) => element.id == roomId);
                                        final roomColorScheme = room.color !=
                                                null
                                            ? ColorScheme.fromSeed(
                                                seedColor: fromHex(room.color!),
                                                brightness:
                                                    DynamicTheme.of(context)!
                                                        .theme
                                                        .brightness)
                                            : DynamicTheme.of(context)!
                                                .theme
                                                .colorScheme;
                                        final roomSize = roomSizes[roomId]!;

                                        return WidgetContainer(
                                            backgroundColor: roomColorScheme
                                                .primary
                                                .withOpacity(0.3),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(room.name,
                                                    style: DynamicTheme.of(
                                                            context)!
                                                        .theme
                                                        .textTheme
                                                        .headlineMedium),
                                                const Gap(listSpacing),
                                                // items
                                                _buildItemsView(context, items,
                                                    roomColorScheme),
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

  Widget _buildItemsView(
      BuildContext context, List<Item> items, ColorScheme colorScheme) {
    final senors = items.where((e) => e.isSensor).toList();
    final realItems = items.where((e) => !e.isSensor).toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (senors.isNotEmpty)
        Wrap(
            spacing: listSpacing,
            runSpacing: listSpacing,
            children: senors
                .map((e) => SensorItemWidget(
                      item: e,
                      colorScheme: colorScheme,
                    ))
                .toList()),
      if (senors.isNotEmpty)
        Padding(
            padding: const EdgeInsets.symmetric(vertical: smallListSpacing),
            child: Divider(
              color: colorScheme.onPrimary,
            )),
      LayoutBuilder(
          builder: (context, constraints) => StaggeredGrid.count(
                crossAxisCount: getItemListCount(constraints.maxWidth),
                mainAxisSpacing: listSpacing,
                crossAxisSpacing: listSpacing,
                children: realItems
                    .map((e) => ItemWidgetFactory(
                          item: e,
                          colorScheme: colorScheme,
                        ))
                    .toList(),
              ))
    ]);
  }

  Widget _buildEmptyState(BuildContext context) {
    return const Center(
      child: Text("No favorites available"),
    );
  }
}
