import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../locator.dart';
import '../../../repository/item_repository.dart';
import '../items/general/item_widget.dart';
import '../items/general/item_widget_factory.dart';
import '../items/sensors/sensor_item_widget.dart';

class RoomsViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;
  final _itemRepository = locator<ItemRepository>();

  Stream<int> get countInboxStream => _inboxStore.count();

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch().distinct();

  Stream<bool> get hasRoomsStream =>
      _roomsStore.all().watch().map((event) => event.isNotEmpty);

  Stream<Map<int, List<Item>>> get itemsByRoomIdStream =>
      _itemsStore.watchGroupedByRoomId().distinct();

  final pageController = PageController();
  int currentPage = 0;
  Key pageViewKey = UniqueKey();

  final int? initialRoomId;

  RoomsViewModel(this.initialRoomId) {
    print('RoomsViewModel: $initialRoomId');
    _roomsStore.all().get().then((rooms) {
      if (rooms.isEmpty) {
        return;
      }
      if (initialRoomId != null) {
        final index = rooms.indexWhere((element) => element.id == initialRoomId);
        if (index != -1) {
          currentPage = index;
        }
      }
    });
  }

  void onRoomChange(int index, {bool animate = false}) {
    print('onRoomChange: $index, animate: $animate');
    if (animate) {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
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

  List<ItemWidget> buildItemWidgets(
          BuildContext context, List<Item> items, ColorScheme colorScheme) =>
      items
          .map((e) =>
              ItemWidgetFactory.buildItem(item: e, colorScheme: colorScheme))
          .toList();

  List<SensorItemWidget> buildSensorItemWidgets(
          BuildContext context, List<Item> items, ColorScheme colorScheme) =>
      items
          .map((e) => SensorItemWidget(item: e, colorScheme: colorScheme))
          .toList();

  Future<int?> currentRoomId() async {
    final rooms = await _roomsStore.all().get();
    if (rooms.isEmpty) {
      return null;
    }
    return rooms[currentPage].id;
  }
}
