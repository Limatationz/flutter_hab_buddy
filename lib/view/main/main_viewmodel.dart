import 'package:collection/collection.dart';
import 'package:stacked/stacked.dart';

import '../../core/database/app_database.dart';
import '../../core/network/converters/inbox.dart';
import '../../core/network/generated/client_index.dart';
import '../../locator.dart';

class MainViewModel extends BaseViewModel {
  final _inboxStore = locator.get<AppDatabase>().inboxStore;
  final api = locator.get<OpenHAB>();

  Future<void> fetchData() async {
    final result = await api.itemsGet();
    if (result.isSuccessful) {
      await _inboxStore.deleteData();
      await _inboxStore.insertOrUpdate(result.body!
          .map((e) => e.asDatabaseModel())
          .toList()
          .whereNotNull()
          .toList());
    } else {
      print(result.error);
    }
  }
}
