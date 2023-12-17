import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../locator.dart';
import '../../../repository/item_repository.dart';

class RoomsViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;
  final _itemRepository = locator<ItemRepository>();

  Stream<int> get countInboxStream => _inboxStore.count();

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch();

  Stream<bool> get hasRoomsStream =>
      _roomsStore.all().watch().map((event) => event.isNotEmpty);

  Stream<Map<int, List<Item>>> get itemsByRoomIdStream =>
      _itemsStore.watchGroupedByRoomId();

  final pageController = PageController();
  int currentPage = 0;
  Key pageViewKey = UniqueKey();

  RoomsViewModel();

  void onRoomChange(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    currentPage = index;
    notifyListeners();
  }

  Future<void> toNextRoom() async {
    final rooms = await _roomsStore.all().get();
    int nextIndex = currentPage + 1;
    if (nextIndex >= rooms.length) {
      nextIndex = 0;
      return;
    }
    pageController.animateToPage(nextIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    currentPage = nextIndex;
    notifyListeners();
  }

  Future<void> toPreviousRoom() async {
    final rooms = await _roomsStore.all().get();
    int nextIndex = currentPage - 1;
    if (nextIndex < 0) {
      nextIndex = rooms.length - 1;
      return;
    }
    pageController.animateToPage(nextIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    currentPage = nextIndex;
    notifyListeners();
  }

  Future<void> onRefresh() => _itemRepository.fetchData(insertToInbox: false);
}
