import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal;
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';
import 'package:stacked/stacked.dart';
import 'package:reorderables/reorderables.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/items_table.dart';
import '../../../core/database/rooms/rooms_table.dart';
import '../../../generated/l10n.dart';
import '../../../util/color.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/base_elevated_button.dart';
import '../../util/general/base_refresh_indicator.dart';
import '../../util/general/base_scaffold.dart';
import '../../util/general/wall_mount_indicator.dart';
import '../inbox/inbox_action_button.dart';
import '../inbox/inbox_view.dart';
import '../items/add_complex/add_complex_item_selection_sheet.dart';
import '../items/add_complex/add_complex_item_widget.dart';
import '../items/general/item_widget.dart';
import '../items/sensors/sensor_item_widget.dart';
import 'add/room_add_view.dart';
import 'rooms_viewmodel.dart';
import 'sort/rooms_sort_sheet.dart';

class RoomsView extends StatelessWidget {
  static const String routePath = '/rooms';
  static const String routeName = 'RoomsView';

  final int? initialRoomId;

  const RoomsView({super.key, this.initialRoomId});

  // TODO: Pull to refresh

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoomsViewModel>.reactive(
        viewModelBuilder: () => RoomsViewModel(initialRoomId),
        builder: (context, model, _) => StreamBuilder<bool>(
              stream: model.hasRoomsStream,
              builder: (context, hasRooms) {
                if (hasRooms.data ?? false) {
                  return StreamBuilder(
                      stream: model.roomsStream,
                      builder: (context, snapshot) {
                        print("refresh rooms");
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final rooms = snapshot.data ?? [];
                          final selectedRoomIndex = model.currentPage;
                          final selectedRoom = rooms[selectedRoomIndex.toInt()];
                          final selectedRoomColorScheme =
                              selectedRoom.getColorScheme(context);
                          return BaseScaffold(
                              key: ValueKey(rooms.length),
                              colorScheme: selectedRoomColorScheme,
                              appBar: AppBar(
                                title: Text(S.current.navigationRooms),
                                actions: [
                                  MenuAnchor(
                                    menuChildren: <Widget>[
                                      if (selectedRoom.itemsSortOption ==
                                          RoomItemsSortOption.manual)
                                        MenuItemButton(
                                            onPressed: model.toggleItemsReorder,
                                            leadingIcon: const Icon(
                                              LineIconsV5.layout_9,
                                            ),
                                            child: const Text('Reorder Items')),
                                      MenuItemButton(
                                          onPressed: () =>
                                              context.pushNamed<int?>(
                                                RoomAddView.routeNameAdd,
                                              ),
                                          leadingIcon:
                                              const Icon(LineIconsV5.plus),
                                          child: const Text('Add Room')),
                                      MenuItemButton(
                                          onPressed: () {
                                            context.pushNamed<int?>(
                                                RoomAddView.routeNameEdit,
                                                pathParameters: {
                                                  "id":
                                                      selectedRoom.id.toString()
                                                }).then((result) {
                                                  if (result == -1) {
                                                    // room was deleted -> go to first room
                                                    model.onRoomChange(0);
                                                  }
                                            });
                                          },
                                          leadingIcon:
                                              const Icon(LineIconsV5.pencil_1),
                                          child: const Text('Edit Room')),
                                      MenuItemButton(
                                          onPressed: () => showRoomsSortSheet(
                                                context,
                                              ),
                                          leadingIcon: const Icon(
                                              LineIconsV5.sort_high_to_low),
                                          child: const Text('Sort Rooms')),
                                    ],
                                    builder: (_, MenuController controller,
                                        Widget? child) {
                                      return IconButton(
                                        onPressed: () {
                                          if (controller.isOpen) {
                                            controller.close();
                                          } else {
                                            controller.open();
                                          }
                                        },
                                        icon: const Icon(
                                            LineIconsV5.menu_kebab_1),
                                      );
                                    },
                                  ),
                                  WallMountModeIndicator(),
                                  InboxActionButton(
                                      countInbox: model.countInboxStream),
                                ],
                              ),
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildRoomSelection(
                                      context,
                                      selectedRoom,
                                      selectedRoomColorScheme,
                                      rooms,
                                      (index) => model.onRoomChange(index,
                                          animate: false)),
                                  StreamBuilder(
                                      stream: model.itemsByRoomIdStream(
                                          Map.fromEntries(rooms.map((e) =>
                                              MapEntry(
                                                  e.id, e.itemsSortOption)))),
                                      builder: (context, snapshot) {
                                        print("refresh items by room");
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: selectedRoomColorScheme
                                                  .primary,
                                            ),
                                          );
                                        } else {
                                          return Expanded(
                                              child: PageView.builder(
                                                  key: model.pageViewKey,
                                                  controller:
                                                      model.pageController,
                                                  onPageChanged:
                                                      model.onRoomChange,
                                                  itemCount: rooms.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final room = rooms[index];
                                                    final items = snapshot
                                                            .data?[room.id] ??
                                                        [];
                                                    if (items.isEmpty) {
                                                      return _buildEmptyItemsForRoomState(
                                                          context, room.id);
                                                    } else {
                                                      final senors = items
                                                          .where(
                                                              (e) => e.isSensor)
                                                          .toList();
                                                      final realItems = items
                                                          .where((e) =>
                                                              !e.isSensor)
                                                          .toList();
                                                      return _buildItemsView(
                                                          context,
                                                          model.buildItemWidgets(
                                                              context,
                                                              realItems,
                                                              selectedRoomColorScheme),
                                                          model.buildSensorItemWidgets(
                                                              context,
                                                              senors,
                                                              selectedRoomColorScheme),
                                                          model.onRefresh,
                                                          room.id,
                                                          selectedRoomColorScheme,
                                                          room.itemsSortOption,
                                                          model
                                                              .itemsReorderEnabled,
                                                          (list) => model
                                                              .onReorderItems(
                                                                  list,
                                                                  room.id),
                                                          (list, oldIndex,
                                                                  newIndex) =>
                                                              model
                                                                  .onReorderSensors(
                                                                      list,
                                                                      oldIndex,
                                                                      newIndex,
                                                                      room.id));
                                                    }
                                                  }));
                                        }
                                      })
                                ],
                              ));
                        }
                      });
                } else {
                  return _buildEmptyRoomState(context);
                }
              },
            ));
  }

  Widget _buildRoomSelection(
      BuildContext context,
      Room selectedRoom,
      ColorScheme colorScheme,
      List<Room> allRooms,
      Function(int) onRoomChange) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: paddingScaffold),
        decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
                bottom: BorderSide(
                    color: colorScheme.surfaceContainerHighest, width: 1))),
        child: Wrap(
          spacing: smallPadding,
          children: allRooms
              .map((e) => Theme(
                  data: ThemeData.from(colorScheme: colorScheme),
                  child: ChoiceChip(
                    label: Text(e.name),
                    selected: e == selectedRoom,
                    onSelected: (value) {
                      onRoomChange(allRooms.indexOf(e));
                    },
                    showCheckmark: false,
                  )))
              .toList(),
        ));
  }

  Widget _buildRoomSelectionOld(
      BuildContext context,
      Room selectedRoom,
      ColorScheme colorScheme,
      List<Room> allRooms,
      Function(int) onRoomChange) {
    return Container(
        decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
                bottom: BorderSide(
                    color: colorScheme.surfaceContainerHighest, width: 3))),
        child: DropdownButtonHideUnderline(
            child: DropdownButton2<Room>(
          value: selectedRoom,
          isExpanded: true,
          items: allRooms
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: colorScheme.onSurfaceVariant))))
              .toList(),
          onChanged: (room) {
            if (room != null) {
              final index = allRooms.indexOf(room);
              onRoomChange(index);
            }
          },
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
            ),
          ),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 12),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(LineIcons.chevron_down,
                size: 18, color: colorScheme.primary),
            openMenuIcon: Icon(LineIcons.chevron_up,
                size: 18, color: colorScheme.primary),
          ),
        )));
  }

  Widget _buildItemsView(
      BuildContext context,
      List<ItemWidget> items,
      List<SensorItemWidget> sensors,
      Future<void> Function() onRefresh,
      int roomId,
      ColorScheme colorScheme,
      RoomItemsSortOption sortOption,
      bool isReorderEnabled,
      Future<void> Function(List<String>) onReorderItems,
      Future<void> Function(
              List<String> oldOrderNames, int oldIndex, int newIndex)
          onReorderSensors) {
    return Container(
        color: colorScheme.surface,
        child: BaseRefreshIndicator(
            onRefresh: onRefresh,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(paddingScaffold),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (sensors.isNotEmpty)
                            isReorderEnabled
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: colorScheme.outline,
                                        )),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.all(
                                                  listSpacing / 2),
                                              child: Text("Reorder Mode",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium)),
                                          ReorderableWrap(
                                            spacing: listSpacing,
                                            runSpacing: listSpacing,
                                            enableReorder: sensors.length > 1,
                                            onReorder: (oldIndex, newIndex) {
                                              print(
                                                  "onReorder: $oldIndex, $newIndex");
                                              onReorderSensors(
                                                  sensors
                                                      .map((e) => e.item.ohName)
                                                      .toList(),
                                                  oldIndex,
                                                  newIndex);
                                            },
                                            needsLongPressDraggable: false,
                                            children: sensors,
                                          )
                                        ]))
                                : Wrap(
                                    spacing: listSpacing,
                                    runSpacing: listSpacing,
                                    children: sensors),
                          if (sensors.isNotEmpty)
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: smallListSpacing),
                                child: Divider(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.2),
                                )),
                          LayoutBuilder(
                              builder: (context, constraints) =>
                                  isReorderEnabled
                                      // when reorder is enabled we need the reorderable staggered grid
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: colorScheme.outline,
                                              )),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            listSpacing / 2),
                                                    child: Text("Reorder Mode",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium)),
                                                ReorderableStaggeredScrollView
                                                    .grid(
                                                  isLongPressDraggable: false,
                                                  crossAxisCount:
                                                      getItemListCount(
                                                          constraints.maxWidth),
                                                  enable: isReorderEnabled,
                                                  isDragNotification: true,
                                                  onAccept: (item1, item2,
                                                      accepted, list) {
                                                    onReorderItems(list
                                                        .map(
                                                            (e) => e.toString())
                                                        .toList());
                                                  },
                                                  children: items
                                                      .map((e) => ReorderableStaggeredScrollViewGridCountItem(
                                                          key: ValueKey(
                                                              e.item?.ohName ??
                                                                  ""),
                                                          crossAxisCellCount:
                                                              e.crossAxisCount,
                                                          mainAxisCellCount: e
                                                              .mainAxisCount
                                                              .toInt(),
                                                          widget: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      listSpacing /
                                                                          2),
                                                              child: e)))
                                                      .toList(),
                                                )
                                              ]))
                                      // otherwise we use the normal grid because it needs less performance
                                      : StaggeredGrid.count(
                                          crossAxisCount: getItemListCount(
                                              constraints.maxWidth),
                                          mainAxisSpacing: listSpacing,
                                          crossAxisSpacing: listSpacing,
                                          children: [
                                            ...items.map((e) =>
                                                StaggeredGridTile.count(
                                                    crossAxisCellCount:
                                                        e.crossAxisCount,
                                                    mainAxisCellCount:
                                                        e.mainAxisCount,
                                                    child: e)),
                                            StaggeredGridTile.count(
                                                crossAxisCellCount:
                                                    smallGridCrossAxisCount,
                                                mainAxisCellCount:
                                                    smallGridMainAxisCount,
                                                child: AddComplexItemWidget(
                                                  colorScheme: colorScheme,
                                                  roomId: roomId,
                                                ))
                                          ],
                                        ))
                        ])))));
  }

  Widget _buildEmptyRoomState(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.current.navigationRooms)),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text("No rooms available"),
            const Gap(paddingScaffold),
            BaseElevatedButton(
              maxWidth: 150,
              text: S.current.addRoomHeadline,
              onPressed: () {
                context.pushNamed<int?>(RoomAddView.routeNameAdd);
              },
            ),
          ]),
        ));
  }

  Widget _buildEmptyItemsForRoomState(BuildContext context, int roomId) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text("No items for the selected room available"),
        const Gap(paddingScaffold),
        BaseElevatedButton(
          maxWidth: 150,
          text: S.current.navigationInbox,
          onPressed: () {
            modal.showMaterialModalBottomSheet(
                useRootNavigator: true,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12))),
                builder: (_) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.95,
                    child: InboxView(
                      roomId: roomId,
                    )));
          },
        ),
        const Gap(paddingScaffold),
        BaseElevatedButton(
          maxWidth: 200,
          text: S.current.addComplexItem,
          onPressed: () {
            AddComplexItemSelectionSheet.openSheet(context, roomId);
          },
        ),
      ]),
    );
  }
}
