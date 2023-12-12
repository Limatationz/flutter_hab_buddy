import 'package:collection/collection.dart';
import 'package:stacked/stacked.dart';

import '../../core/database/app_database.dart';
import '../../core/network/converters/inbox.dart';
import '../../core/network/generated/client_index.dart';
import '../../locator.dart';

class MainViewModel extends BaseViewModel {
  final _inboxStore = locator.get<AppDatabase>().inboxStore;
  final _itemsStore = locator.get<AppDatabase>().itemsStore;
  final api = locator.get<OpenHAB>();

  Future<void> fetchData() async {
    final result = await api.itemsGet();
    if (result.isSuccessful) {
      final storedItems = await _itemsStore.getAll();
      await _inboxStore.deleteData();
      final addToInbox = <InboxEntry>[];

      for (final item in result.body!) {
        if (storedItems
                .firstWhereOrNull((element) => element.ohName == item.name) ==
            null) {
          // Item is not stored yet
          final dbItem = item.asDatabaseModel();
          if(dbItem != null) {
            addToInbox.add(dbItem);
          }
        } else {
          // Item is already stored -> update
          final update = item.asItemUpdate();
          if (update != null) {
            await _itemsStore.updateByName(update);
          }
          storedItems.removeWhere((element) => element.ohName == item.name);
        }
      }

      // Delete all items that are not available anymore
      for (final item in storedItems) {
        await _itemsStore.deleteDataByName(item.ohName);
      }

      await _inboxStore.insertOrUpdate(addToInbox);
    } else {
      print(result.error);
    }
  }
}
