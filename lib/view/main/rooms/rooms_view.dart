import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
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
import '../inbox/inbox_action_button.dart';
import '../inbox/inbox_view.dart';
import '../items/add_complex/add_complex_item_widget.dart';
import '../items/item_widget_factory.dart';
import '../items/sensors/sensor_item_widget.dart';
import 'add/room_add_sheet.dart';
import 'rooms_viewmodel.dart';

class RoomsView extends StatelessWidget {
  static const String routePath = '/rooms';
  static const String routeName = 'RoomsView';

  const RoomsView({super.key});

  // TODO: Pull to refresh

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoomsViewModel>.reactive(
        viewModelBuilder: () => RoomsViewModel(),
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              title: const Text('Rooms'),
              actions: [
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
                                      brightness: DynamicTheme.of(context)!
                                          .theme
                                          .brightness)
                                  : DynamicTheme.of(context)!.theme.colorScheme;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRoomSelection(
                                  context,
                                  selectedRoom,
                                  selectedRoomColorScheme,
                                  rooms,
                                  model.onRoomChange),
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
                                                      context);
                                                } else {
                                                  return _buildItemsView(
                                                      context,
                                                      items,
                                                      model.onRefresh,
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
                      style: DynamicTheme.of(context)!
                          .theme
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

  Widget _buildItemsView(BuildContext context, List<Item> items,
      Future<void> Function() onRefresh, ColorScheme colorScheme) {
    final senors = items.where((e) => e.isSensor).toList();
    final realItems = items.where((e) => !e.isSensor).toList();

    return Container(
        color: colorScheme.surface,
        padding: const EdgeInsets.all(paddingScaffold),
        child: BaseRefreshIndicator(
            onRefresh: onRefresh,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                  if (senors.isNotEmpty && realItems.isNotEmpty)
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: smallListSpacing),
                        child: Divider()),
                  LayoutBuilder(
                      builder: (context, constraints) => StaggeredGrid.count(
                            crossAxisCount:
                                getItemListCount(constraints.maxWidth),
                            mainAxisSpacing: listSpacing,
                            crossAxisSpacing: listSpacing,
                            children: [
                              ...realItems.map((e) => ItemWidgetFactory(
                                    item: e,
                                    colorScheme: colorScheme,
                                  )),
                              AddComplexItemWidget(
                                colorScheme: colorScheme,
                              )
                            ],
                          ))
                ]))));
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

  Widget _buildEmptyItemsForRoomState(BuildContext context) {
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
                    child: const InboxView()));
          },
        ),
      ]),
    );
  }
}
