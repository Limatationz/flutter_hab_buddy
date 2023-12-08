import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../locator.dart';

class InboxViewModel extends BaseViewModel {
  final _inboxStore = locator.get<AppDatabase>().inboxStore;

  Stream<List<InboxEntry>> get inbox => _inboxStore.all().watch();

  final ScrollController scrollController = ScrollController();

  Future<List<InboxEntry>> autoComplete(String query) async {
    return _inboxStore.autoComplete(query).get();
  }

}