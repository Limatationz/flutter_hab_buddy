import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
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
  final textEditingController = TextEditingController();

  final BehaviorSubject<String> _searchSubject = BehaviorSubject.seeded('');

  Stream<List<InboxListEntry>> get filteredInbox =>
      Rx.combineLatest2(inbox, _searchSubject.stream,
          (List<InboxListEntry> inbox, String search) {
        if (search.isEmpty) {
          return inbox;
        }
        return inbox
            .where((element) =>
                element.entry.label
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                (element.entry.category
                        ?.toLowerCase()
                        .contains(search.toLowerCase()) ??
                    false) ||
                element.entry.name.toLowerCase().contains(search.toLowerCase()))
            .toList();
      });

  InboxViewModel() {
    textEditingController.addListener(() {
      _searchSubject.add(textEditingController.text);
    });
  }
}
