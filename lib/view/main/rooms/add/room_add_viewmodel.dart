import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/rooms/rooms_table.dart';
import '../../../../locator.dart';
import '../../../../util/color.dart';

class RoomAddViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;

  final fbKey = GlobalKey<FormBuilderState>();

  int? roomId;
  Room? editedRoom;
  bool get isAdd => roomId == null;

  IconData? roomIcon;

  RoomAddViewModel(this.roomId) {
    if (roomId != null){
      // we want to edit the room
      _roomsStore.byId(roomId!).getSingle().then((room){
        editedRoom = room;

        // set the form values
        fbKey.currentState!.patchValue({
          "name": room.name,
          "description": room.description,
          "color": fromHex(room.color!),
          "itemsSortOption": room.itemsSortOption,
        });

        if (room.level != null){
          fbKey.currentState!.patchValue({
            "level": room.level.toString()
          });
        }

        roomIcon = room.icon;

        notifyListeners();
      });
    }
  }

  Future<int?> save() async {
    if (fbKey.currentState?.saveAndValidate() ?? false) {
      final data = fbKey.currentState!.value;

      final name = data["name"] as String;
      final description = data["description"] as String?;
      final level = data["level"] as String?;
      final levelInt = level != null ? int.parse(level) : null;
      final color = data["color"] as Color?;
      final sortKey = await _roomsStore.getLastSortKey();
      final itemsSortOption = data["itemsSortOption"] as RoomItemsSortOption;

      final room = RoomsTableCompanion.insert(
        name: name,
        description:
            description != null ? Value(description) : const Value.absent(),
        level: levelInt != null ? Value(levelInt) : const Value.absent(),
        color: color != null ? Value(color.toHex()) : const Value.absent(),
        icon: roomIcon != null ? Value(roomIcon!) : const Value.absent(),
        sortKey: sortKey + 1,
        itemsSortOption: itemsSortOption
      );
      final id = await _roomsStore.insertOrUpdateSingleWithId(room);
      return id;
    }
    return null;
  }

  Future<int?> update() async {
    if ((fbKey.currentState?.saveAndValidate() ?? false) && roomId != null && editedRoom != null) {
      final data = fbKey.currentState!.value;

      final name = data["name"] as String;
      final description = data["description"] as String?;
      final level = data["level"] as String?;
      final levelInt = level != null ? int.parse(level) : null;
      final color = data["color"] as Color?;
      final itemsSortOption = data["itemsSortOption"] as RoomItemsSortOption;

      final room = RoomsTableCompanion(
        id: Value(roomId!),
        name: Value(name),
        description:
        description != null ? Value(description) : const Value.absent(),
        level: levelInt != null ? Value(levelInt) : const Value.absent(),
        color: color != null ? Value(color.toHex()) : const Value.absent(),
        icon: roomIcon != null ? Value(roomIcon!) : const Value.absent(),
        sortKey: Value(editedRoom!.sortKey),
        itemsSortOption: Value(itemsSortOption)
      );
      final id = await _roomsStore.insertOrUpdateSingleWithId(room);
      return id;
    }
    return null;
  }

  Future<bool> onDelete() async {
    if (roomId != null) {
      final items = await _itemsStore.byRoomId(roomId!).get();
      for (final item in items) {
        // remove the item from the room
        await _itemsStore.insertOrUpdateSingle(item.toCompanion(false).copyWith(roomId: const Value.absent()));
      }

      // remove the room
      await _roomsStore.deleteDataById(roomId!);
      return true;
    }
    return false;
  }

  void setIcon(IconData? icon) {
    roomIcon = icon;
    notifyListeners();
  }
}
