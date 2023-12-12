import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal;
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../generated/l10n.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/base_elevated_button.dart';
import '../inbox/inbox_action_button.dart';
import '../inbox/inbox_view.dart';
import '../items/item_widget_factory.dart';
import 'add/room_add_sheet.dart';
import 'rooms_viewmodel.dart';

class RoomsView extends StatelessWidget {
  static const String routePath = '/rooms';
  static const String routeName = 'RoomsView';

  const RoomsView({super.key});

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
                  return StreamBuilder2(
                      streams: StreamTuple2(
                          model.roomsStream, model.currentRoomIdStream),
                      builder: (context, snapshot) {
                        if (!snapshot.snapshot1.hasData ||
                            !snapshot.snapshot2.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final rooms = snapshot.snapshot1.data ?? [];
                          final selectedRoomId = snapshot.snapshot2.data ?? 0;
                          final selectedRoom = rooms.firstWhere(
                              (element) => element.id == selectedRoomId);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRoomSelection(context, selectedRoom, rooms,
                                  model.onRoomChange),
                              // TODO: use pageview and a page for every room
                              Expanded(
                                  child: StreamBuilder(
                                stream: model.itemsOfCurrentRoomStream,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    final items = snapshot.data ?? [];
                                    if (items.isEmpty) {
                                      return _buildEmptyItemsForRoomState(
                                          context);
                                    } else {
                                      return _buildItemsView(context, items);
                                    }
                                  }
                                },
                              ))
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

  Widget _buildRoomSelection(BuildContext context, Room selectedRoom,
      List<Room> allRooms, Function(Room?) onRoomChange) {
    return Material(
        elevation: 4,
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
                          ?.copyWith(
                              color: DynamicTheme.of(context)!
                                  .theme
                                  .colorScheme
                                  .onSurfaceVariant))))
              .toList(),
          onChanged: onRoomChange,
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: DynamicTheme.of(context)!.theme.colorScheme.surfaceVariant,
            ),
          ),
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.only(right: 12),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(LineIcons.chevron_down,
                size: 18,
                color: DynamicTheme.of(context)!.theme.colorScheme.primary),
            openMenuIcon: Icon(LineIcons.chevron_up,
                size: 18,
                color: DynamicTheme.of(context)!.theme.colorScheme.primary),
          ),
        )));
  }

  Widget _buildItemsView(BuildContext context, List<Item> items) {
    return Padding(
        padding: const EdgeInsets.all(paddingScaffold),
        child: LayoutBuilder(
            builder: (context, constraints) => Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: listSpacing,
                  spacing: listSpacing,
                  children: items
                      .map((e) => ItemWidgetFactory(
                            item: e,
                            parentWidth: constraints.maxWidth,
                          ))
                      .toList(),
                )));
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
