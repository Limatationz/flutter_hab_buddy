import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';

class ItemEditViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _itemsRepository = locator<ItemRepository>();

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch();

  final Item item;
  final fbKey = GlobalKey<FormBuilderState>();
  IconData? itemIcon;
  int? addRoomId;

  ItemEditViewModel(this.item) {
    itemIcon = item.icon;
  }

  Future<bool> save() async {
    if (fbKey.currentState?.saveAndValidate() ?? false) {
      final data = fbKey.currentState!.value;
      final itemType = data["itemType"] as ItemType;
      final int roomId = data["roomId"];
      final String? customLabel = data["customLabel"];

      final update = item.copyWith(
        type: Value(itemType),
        roomId: Value(roomId),
        icon: itemIcon != null ? Value(itemIcon) : const Value.absent(),
        customLabel:
            customLabel != null ? Value(customLabel) : const Value.absent(),
      ).toCompanion(false);
      await _itemsStore.updateByNameSingle(update);
      return true;
    }
    return false;
  }

  void setIcon(IconData? icon) {
    itemIcon = icon;
    notifyListeners();
  }

  void onRoomAdd(int? roomId) {
    if (roomId != null) {
      addRoomId = roomId;
      notifyListeners();
    }
  }

  Future<void> onDelete() => _itemsRepository.removeItem(item.ohName);
}
