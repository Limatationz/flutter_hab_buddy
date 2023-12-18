import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/items_table.dart';
import '../../../locator.dart';
import '../../../repository/item_repository.dart';
import '../../../util/color.dart';
import '../items/general/item_widget.dart';
import '../items/item_widget_factory.dart';
import '../items/sensors/sensor_item_widget.dart';

class FavouriteViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;
  final _itemsRepository = locator<ItemRepository>();

  Stream<int> get countInboxStream => _inboxStore.count();

  Stream<bool> get hasItemsStream => _itemsStore.hasFavorites();

  final BehaviorSubject<Map<int, List<Item>>> _itemsByRoomIdSubject =
      BehaviorSubject.seeded({});

  Stream<Map<int, List<Item>>> get itemsByRoomIdStream =>
      _itemsByRoomIdSubject.stream;

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch();

  FavouriteViewModel() {
    _itemsStore.watchGroupedByRoomId(onlyFavorites: true).listen((map) {
      final roomScores = map.map((key, value) => MapEntry(
            key,
            value.fold<double>(
                0, (previousValue, element) => previousValue + element.score),
          ));

      // sort by score
      final sortedRoomScores = roomScores.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // get room ids
      final sortedRoomIds = sortedRoomScores.map((e) => e.key).toList();

      // sort items by room id
      final itemsByRoomId = Map.fromEntries(sortedRoomIds.map((roomId) {
        final items = map[roomId]!;
        return MapEntry(roomId, items);
      }));

      // add to subject
      _itemsByRoomIdSubject.add(itemsByRoomId);
    });
  }

  Future<void> onRefresh() => _itemsRepository.fetchData(insertToInbox: false);

  List<ItemWidget> buildItemWidgets(
          List<Item> items, ColorScheme colorScheme) =>
      items
          .map((e) =>
              ItemWidgetFactory.buildItem(item: e, colorScheme: colorScheme))
          .toList();

  List<SensorItemWidget> buildSensorItemWidgets(
          List<Item> items, ColorScheme colorScheme) =>
      items
          .map((e) => SensorItemWidget(item: e, colorScheme: colorScheme))
          .toList();

  Map<int, Tuple2<List<ItemWidget>, List<SensorItemWidget>>>
      buildItemWidgetsByRoomId(
              Map<int, List<Item>> itemsByRoomId,
              List<Room> rooms,
              ColorScheme defaultColorScheme,
              Brightness brightness) =>
          itemsByRoomId.map((key, value) {
            final room = rooms.firstWhere((element) => element.id == key);
            final realItems =
                value.where((element) => !element.isSensor).toList();
            final sensorItems =
                value.where((element) => element.isSensor).toList();
            final colorScheme = room.color != null
                ? ColorScheme.fromSeed(
                    seedColor: fromHex(room.color!), brightness: brightness)
                : defaultColorScheme;
            final itemWidgets = buildItemWidgets(realItems, colorScheme);
            final sensorItemWidgets =
                buildSensorItemWidgets(sensorItems, colorScheme);
            return MapEntry(key, Tuple2(itemWidgets, sensorItemWidgets));
          });
}
