import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/rooms/rooms_table.dart';
import '../../../locator.dart';
import '../../../repository/item_repository.dart';
import '../items/add_complex/add_complex_item_widget.dart';
import '../items/general/item_widget.dart';
import '../items/general/item_widget_factory.dart';
import '../items/sensors/sensor_item_widget.dart';

class RoomsViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _itemRepository = locator<ItemRepository>();

  Stream<int> get countInboxStream => _itemsStore.watchInboxItemsCount();

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch().distinct();

  Stream<bool> get hasRoomsStream =>
      _roomsStore.all().watch().map((event) => event.isNotEmpty);

  Stream<Map<int, List<Item>>> itemsByRoomIdStream(
          Map<int, RoomItemsSortOption> sortOptions) =>
      _itemsStore.watchGroupedByRoomId(sortOptions: sortOptions).distinct();

  final pageController = PageController();
  int currentPage = 0;
  Key pageViewKey = UniqueKey();

  final int? initialRoomId;

  bool _itemsReorderEnabled = false;

  bool get itemsReorderEnabled => _itemsReorderEnabled;

  RoomsViewModel(this.initialRoomId) {
    print('RoomsViewModel: $initialRoomId');
    _roomsStore.all().get().then((rooms) {
      if (rooms.isEmpty) {
        return;
      }
      if (initialRoomId != null) {
        final index =
            rooms.indexWhere((element) => element.id == initialRoomId);
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
    _itemsReorderEnabled = false;
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

  Future<void> onRefresh() => _itemRepository.fetchData();

  List<ItemWidget> buildItemWidgets(
          BuildContext context, List<Item> items, ColorScheme colorScheme) =>
      items
          .map((e) => ItemWidgetFactory.buildItem(
              item: e,
              colorScheme: colorScheme,
              disableTap: itemsReorderEnabled))
          .toList();

  List<SensorItemWidget> buildSensorItemWidgets(
          BuildContext context, List<Item> items, ColorScheme colorScheme) =>
      items
          .map((e) => SensorItemWidget(
                item: e,
                colorScheme: colorScheme,
                disableTap: itemsReorderEnabled,
                initiallyExpanded: itemsReorderEnabled,
              ))
          .toList();

  Future<int?> currentRoomId() async {
    final rooms = await _roomsStore.all().get();
    if (rooms.isEmpty) {
      return null;
    }
    return rooms[currentPage].id;
  }

  Future<void> onReorderItems(List<String> keys, int roomId) async {
    print('onReorderItems: $keys');
    final ohNames = keys.map((e) => e.substring(3, e.length - 3)).toList();
    print('onReorderItems: $ohNames');
    keys.remove(AddComplexItemWidget.keyName);

    int index = 0;
    for (final ohName in ohNames) {
      print('ohName: $ohName, index: $index');
      await _itemsStore.updateManualOrderIndexByName(ohName, index);
      index++;
    }

    notifyListeners();
  }

  Future<void> onReorderSensors(List<String> oldSensorOrderNames, int oldIndex,
      int newIndex, int roomId) async {
    print('onReorderSensors: $oldSensorOrderNames');

    final newSensorOrderNames = List<String>.from(oldSensorOrderNames);
    newSensorOrderNames.removeAt(oldIndex);
    newSensorOrderNames.insert(newIndex, oldSensorOrderNames[oldIndex]);
    print('newSensorOrderNames: $newSensorOrderNames');
    for (var i = 0; i < newSensorOrderNames.length; i++) {
      await _itemsStore.updateManualOrderIndexByName(newSensorOrderNames[i], i);
    }

    notifyListeners();
  }

  void toggleItemsReorder() {
    _itemsReorderEnabled = !_itemsReorderEnabled;
    notifyListeners();
  }
}
