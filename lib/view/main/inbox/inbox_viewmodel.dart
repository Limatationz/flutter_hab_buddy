import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/inbox/inbox_list_entry.dart';
import '../../../locator.dart';

class InboxViewModel extends BaseViewModel {
  final _inboxStore = locator.get<AppDatabase>().inboxStore;

  Stream<List<InboxListEntry>> get inbox => _inboxStore
      .all()
      .watch()
      .map((list) => list.map((e) => InboxListEntry(e)).toList());

  final ScrollController scrollController = ScrollController();

  Future<List<InboxEntry>> autoComplete(String query) async {
    return _inboxStore.autoComplete(query).get();
  }
}
