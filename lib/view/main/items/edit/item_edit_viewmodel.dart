import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../locator.dart';

class ItemEditViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;

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

      final update = ItemsTableCompanion.insert(
        type: itemType,
        ohType: item.ohType,
        ohName: item.ohName,
        ohLabel: item.ohLabel,
        ohCategory: item.ohCategory != null
            ? Value(item.ohCategory!)
            : const Value.absent(),
        ohTags:
            item.ohTags != null ? Value(item.ohTags!) : const Value.absent(),
        ohGroups: item.ohGroups != null
            ? Value(item.ohGroups!)
            : const Value.absent(),
        roomId: roomId,
        state: item.state,
        stateDescription: item.stateDescription != null
            ? Value(item.stateDescription!)
            : const Value.absent(),
        transformedState: item.transformedState != null
            ? Value(item.transformedState!)
            : const Value.absent(),
        icon: itemIcon != null ? Value(itemIcon) : const Value.absent(),
        customLabel:
            customLabel != null ? Value(customLabel) : const Value.absent(),
      );
      await _itemsStore.updateByName(update);
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
}
