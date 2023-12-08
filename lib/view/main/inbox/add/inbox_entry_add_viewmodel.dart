import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../locator.dart';

class InboxEntryAddViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch();

  final InboxEntry entry;
  final fbKey = GlobalKey<FormBuilderState>();

  InboxEntryAddViewModel(this.entry);

  Future<bool> save() async {
    if (fbKey.currentState?.saveAndValidate() ?? false) {
      final data = fbKey.currentState!.value;
      final item = ItemsTableCompanion.insert(
        itemType: data["itemType"],
        type: entry.type,
        name: entry.name,
        label: entry.label,
        category: entry.category != null
            ? Value(entry.category!)
            : const Value.absent(),
        tags: entry.tags != null ? Value(entry.tags!) : const Value.absent(),
        groups:
            entry.groups != null ? Value(entry.groups!) : const Value.absent(),
        roomId: data["roomId"],
        state: entry.state,
      );
      await _itemsStore.insertOrUpdateSingle(item);
      await _inboxStore.deleteDataByName(entry.name);
      return true;
    }
    return false;
  }
}
