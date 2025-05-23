import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../locator.dart';

class InboxViewModel extends BaseViewModel {
  final _itemsStore = locator.get<AppDatabase>().itemsStore;

  Stream<List<Item>> get inbox => _itemsStore
      .inbox()
      .watch();

  final ScrollController scrollController = ScrollController();
  final textEditingController = TextEditingController();

  final BehaviorSubject<String> _searchSubject = BehaviorSubject.seeded('');

  Stream<List<Item>> get filteredInbox =>
      Rx.combineLatest2(inbox, _searchSubject.stream,
          (List<Item> inbox, String search) {
        if (search.isEmpty) {
          return inbox;
        }
        return inbox
            .where((element) =>
                element.ohLabel
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                (element.ohCategory
                        ?.toLowerCase()
                        .contains(search.toLowerCase()) ??
                    false) ||
                element.ohName.toLowerCase().contains(search.toLowerCase()))
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