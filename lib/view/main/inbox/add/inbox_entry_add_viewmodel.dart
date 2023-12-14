import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../locator.dart';

class InboxEntryAddViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch();

  final InboxEntry entry;
  final fbKey = GlobalKey<FormBuilderState>();
  IconData? itemIcon;
  int? addRoomId;

  InboxEntryAddViewModel(this.entry);

  Future<bool> save() async {
    if (fbKey.currentState?.saveAndValidate() ?? false) {
      final data = fbKey.currentState!.value;
      final itemType = data["itemType"] as ItemType;
      final int roomId = data["roomId"];
      final String? customLabel = data["customLabel"];

      final item = ItemsTableCompanion.insert(
        type: itemType,
        ohType: entry.type,
        ohName: entry.name,
        ohLabel: entry.label,
        ohCategory: entry.category != null
            ? Value(entry.category!)
            : const Value.absent(),
        ohTags: entry.tags != null ? Value(entry.tags!) : const Value.absent(),
        ohGroups:
            entry.groups != null ? Value(entry.groups!) : const Value.absent(),
        ohUnitSymbol: entry.unitSymbol != null
            ? Value(entry.unitSymbol!)
            : const Value.absent(),
        state: entry.state,
        stateDescription: entry.stateDescription != null
            ? Value(entry.stateDescription!)
            : const Value.absent(),
        commandDescription: entry.commandDescription != null
            ? Value(entry.commandDescription!)
            : const Value.absent(),
        transformedState: entry.transformedState != null
            ? Value(entry.transformedState!)
            : const Value.absent(),
        roomId: roomId,
        icon: itemIcon != null ? Value(itemIcon) : const Value.absent(),
        customLabel:
            customLabel != null ? Value(customLabel) : const Value.absent(),
      );
      await _itemsStore.insertOrUpdateSingle(item);
      await _inboxStore.deleteDataByName(entry.name);
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
