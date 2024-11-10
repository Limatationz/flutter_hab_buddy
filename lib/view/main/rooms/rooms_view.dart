import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal;
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/items_table.dart';
import '../../../generated/l10n.dart';
import '../../../util/color.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/base_elevated_button.dart';
import '../../util/general/base_refresh_indicator.dart';
import '../../util/general/wakelock_indicator.dart';
import '../inbox/inbox_action_button.dart';
import '../inbox/inbox_view.dart';
import '../items/add_complex/add_complex_item_selection_sheet.dart';
import '../items/add_complex/add_complex_item_widget.dart';
import '../items/general/item_widget.dart';
import '../items/sensors/sensor_item_widget.dart';
import 'add/room_add_sheet.dart';
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
    print('RoomsView: $initialRoomId');
    return ViewModelBuilder<RoomsViewModel>.reactive(
        viewModelBuilder: () => RoomsViewModel(initialRoomId),
        onViewModelReady: (model) {
          print('onViewModelReady: $initialRoomId');
        },
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              title: const Text('Rooms'),
              actions: [
                IconButton(
                    onPressed: () {
                      showRoomsSortSheet(
                        context,
                      );
                    },
                    tooltip: 'Sort rooms',
                    icon: Icon(LineIconsV5.variantfreesort_high_to_low)),
                WakelockIndicator(),
                InboxActionButton(countInbox: model.countInboxStream),
              ],
            ),
            body: StreamBuilder<bool>(
              stream: model.hasRoomsStream,
              builder: (context, hasRooms) {
                if (hasRooms.data ?? false) {
                  return StreamBuilder(
                      stream: model.roomsStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final rooms = snapshot.data ?? [];
                          final selectedRoomIndex = model.currentPage;
                          final selectedRoom = rooms[selectedRoomIndex.toInt()];
                          final selectedRoomColorScheme =
                              selectedRoom.color != null
                                  ? ColorScheme.fromSeed(
                                      seedColor: fromHex(selectedRoom.color!),
                                      brightness: Theme.of(context).brightness)
                                  : Theme.of(context).colorScheme;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRoomSelection(
                                  context,
                                  selectedRoom,
                                  selectedRoomColorScheme,
                                  rooms,
                                  (index) =>
                                      model.onRoomChange(index, animate: true)),
                              StreamBuilder(
                                  stream: model.itemsByRoomIdStream,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color:
                                              selectedRoomColorScheme.primary,
                                        ),
                                      );
                                    } else {
                                      return Expanded(
                                          child: PageView.builder(
                                              key: model.pageViewKey,
                                              controller: model.pageController,
                                              onPageChanged: model.onRoomChange,
                                              itemCount: rooms.length,
                                              itemBuilder: (context, index) {
                                                final room = rooms[index];
                                                final items =
                                                    snapshot.data?[room.id] ??
                                                        [];
                                                if (items.isEmpty) {
                                                  return _buildEmptyItemsForRoomState(
                                                      context, room.id);
                                                } else {
                                                  final senors = items
                                                      .where((e) => e.isSensor)
                                                      .toList();
                                                  final realItems = items
                                                      .where((e) => !e.isSensor)
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
                                                      selectedRoomColorScheme);
                                                }
                                              }));
                                    }
                                  })
                            ],
                          );
                        }
                      });
                } else {
                  return _buildEmptyRoomState(context);
                }
              },
            )));
  }

  Widget _buildRoomSelection(
      BuildContext context,
      Room selectedRoom,
      ColorScheme colorScheme,
      List<Room> allRooms,
      Function(int) onRoomChange) {
    return Container(
        decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
                bottom:
                    BorderSide(color: colorScheme.surfaceVariant, width: 3))),
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
              color: colorScheme.surfaceVariant,
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
      ColorScheme colorScheme) {
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
                            Wrap(
                                spacing: listSpacing,
                                runSpacing: listSpacing,
                                children: sensors),
                          if (sensors.isNotEmpty && items.isNotEmpty)
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: smallListSpacing),
                                child: Divider(
                                  color:
                                      colorScheme.onBackground.withOpacity(0.2),
                                )),
                          LayoutBuilder(
                              builder: (context, constraints) =>
                                  StaggeredGrid.count(
                                    crossAxisCount:
                                        getItemListCount(constraints.maxWidth),
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
                                      AddComplexItemWidget(
                                        colorScheme: colorScheme,
                                        roomId: roomId,
                                      )
                                    ],
                                  ))
                        ])))));
  }

  Widget _buildEmptyRoomState(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text("No rooms available"),
        const Gap(paddingScaffold),
        BaseElevatedButton(
          width: 150,
          text: S.current.addRoomHeadline,
          onPressed: () {
            showBarModalBottomSheet<int?>(
                context: context, builder: (context) => const RoomAddSheet());
          },
        ),
      ]),
    );
  }

  Widget _buildEmptyItemsForRoomState(BuildContext context, int roomId) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text("No items for the selected room available"),
        const Gap(paddingScaffold),
        BaseElevatedButton(
          width: 150,
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
          width: 200,
          text: S.current.addComplexItem,
          onPressed: () {
            AddComplexItemSelectionSheet.openSheet(context, roomId);
          },
        ),
      ]),
    );
  }
}
