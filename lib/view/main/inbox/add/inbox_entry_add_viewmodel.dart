import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';

class InboxEntryAddViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsRepository = locator<ItemRepository>();

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch();

  final InboxEntry entry;
  final fbKey = GlobalKey<FormBuilderState>();
  IconData? itemIcon;
  int? addRoomId;
  bool isFavorite = false;

  InboxEntryAddViewModel(this.entry) {
    if (ItemType.forEntryType(entry.type).length == 1) {
      itemIcon = ItemType.forEntryType(entry.type).first.icon;
    }
  }

  Future<bool> save() async {
    if (fbKey.currentState?.saveAndValidate() ?? false) {
      final data = fbKey.currentState!.value;
      final itemType = data["itemType"] as ItemType;
      final int roomId = data["roomId"];
      final String? customLabel = data["customLabel"];

      return _itemsRepository.addItemFromInbox(
          itemName: entry.name,
          type: itemType,
          roomId: roomId,
          customLabel: customLabel,
          icon: itemIcon,
          isFavorite: isFavorite);
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

  void onFavoriteToggle() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void setIconOnTypeChange(ItemType type) {
    itemIcon = type.icon;
    notifyListeners();
  }
}
