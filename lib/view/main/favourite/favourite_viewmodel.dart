import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/items_table.dart';
import '../../../locator.dart';
import '../../../repository/item_repository.dart';

class FavouriteViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;
  final _itemsRepository = locator<ItemRepository>();

  Stream<int> get countInboxStream => _inboxStore.count();

  Stream<bool> get hasItemsStream => _itemsStore.hasFavorites();

  final BehaviorSubject<Tuple2<Map<int, List<Item>>, Map<int, Size>>>
      _itemsByRoomIdSubject = BehaviorSubject.seeded(Tuple2({}, {}));

  Stream<Tuple2<Map<int, List<Item>>, Map<int, Size>>>
      get itemsByRoomIdStream => _itemsByRoomIdSubject.stream;

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

      // get room sizes
      final roomSizes = Map.fromEntries(itemsByRoomId.entries.map((entry) {
        final crossAxisSize = entry.value.fold(0,
            (previousValue, element) => previousValue + element.crossAxisCount);
        final mainAxisSize = entry.value.fold(0.0,
            (previousValue, element) => previousValue + element.mainAxisCount);
        return MapEntry(
            entry.key, Size(crossAxisSize.toDouble(), mainAxisSize));
      }));

      // add to subject
      _itemsByRoomIdSubject.add(Tuple2(itemsByRoomId, roomSizes));
    });
  }

  Future<void> onRefresh() => _itemsRepository.fetchData(insertToInbox: false);
}
