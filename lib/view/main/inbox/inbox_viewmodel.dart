import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../locator.dart';

class InboxViewModel extends BaseViewModel {
  final _itemsStore = locator.get<AppDatabase>().itemsStore;

  Stream<List<InboxItemEntry>> get inbox => _itemsStore
      .inbox()
      .watch().map((items) => items.map((e) => InboxItemEntry(e)).toList());

  final ScrollController scrollController = ScrollController();
  final textEditingController = TextEditingController();

  final BehaviorSubject<String> _searchSubject = BehaviorSubject.seeded('');

  Stream<List<InboxItemEntry>> get filteredInbox =>
      Rx.combineLatest2(inbox, _searchSubject.stream,
          (List<InboxItemEntry> inbox, String search) {
        if (search.isEmpty) {
          return inbox;
        }
        return inbox
            .where((element) =>
                element.entry.ohLabel
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                (element.entry.ohCategory
                        ?.toLowerCase()
                        .contains(search.toLowerCase()) ??
                    false) ||
                element.entry.ohName.toLowerCase().contains(search.toLowerCase()))
            .toList();
      });
  final searchFocusNode = FocusNode();

  InboxViewModel() {
    textEditingController.addListener(() {
      _searchSubject.add(textEditingController.text);
    });
  }

  void resetSearch(){
    textEditingController.clear();
    searchFocusNode.unfocus();
  }
}

class InboxItemEntry extends ISuspensionBean {
  final Item entry;

  InboxItemEntry(this.entry);

  @override
  String getSuspensionTag() => entry.ohName;

}