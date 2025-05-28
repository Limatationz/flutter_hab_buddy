import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../app_database.dart';
import '../rooms/rooms_table.dart';
import '../../hive/state/item_state.dart';
import 'item_type.dart';
import 'items_table.dart';
import 'oh_item_type.dart';

part 'items_store.g.dart';

@DriftAccessor(tables: [ItemsTable, RoomsTable])
class ItemsStore extends DatabaseAccessor<AppDatabase> with _$ItemsStoreMixin {
  late final Box<ItemState> _statesBox;

  ItemsStore(super.database) {
    Hive.openBox<ItemState>('itemStatesBox')
        .then((value) {
      _statesBox = value;
    });
  }

  MultiSelectable<Item> all() => (select(itemsTable)
    ..orderBy([
      (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
    ]));

  MultiSelectable<Item> inbox() => (select(itemsTable)
    ..where((tbl) => tbl.roomId.isNull())
    ..orderBy([
      (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
    ]));

  MultiSelectable<Item> nonInbox() => (select(itemsTable)
    ..where((tbl) => tbl.roomId.isNotNull())
    ..orderBy([
      (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
    ]));

  Stream<List<String>> watchAllOhNames() => select(itemsTable)
      .watch()
      .map((rows) => rows.map((e) => e.ohName).toList());

  Stream<bool> hasFavorites() =>
      (select(itemsTable)..where((tbl) => tbl.isFavorite.equals(true)))
          .watch()
          .map((event) => event.isNotEmpty);

  MultiSelectable<Item> byRoomId(int roomId) => select(itemsTable)
    ..where((tbl) => tbl.roomId.equals(roomId))
    ..orderBy([
      (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
    ]);

  MultiSelectable<Item> byOhType(OhItemType type) =>
      (select(itemsTable)..where((tbl) => tbl.ohType.equalsValue(type)));

  MultiSelectable<Item> byTypes(List<ItemType> types) =>
      (select(itemsTable)..where((tbl) => tbl.type.isInValues(types)));

  Stream<Map<int, List<Item>>> watchGroupedByRoomId(
          {bool onlyFavorites = false,
          Map<int, RoomItemsSortOption> sortOptions = const {}}) =>
      (select(itemsTable)
            ..where((tbl) => onlyFavorites
                ? tbl.isFavorite.equals(true)
                : tbl.isFavorite.equals(true) | tbl.isFavorite.equals(false))
            ..where(
                (tbl) => tbl.type.equalsValue(ItemType.complexComponent).not())
            ..where((tbl) => tbl.roomId.isNotNull()))
          .watch()
          .map((rows) {
            print("watchGroupedByRoomId triggered");
        final grouped = groupBy(rows, (e) => e.roomId!);
        // now we need to sort each group
        for (final entry in grouped.entries) {
          final roomId = entry.key;
          final items = entry.value;
          final sortOption = sortOptions[roomId] ?? RoomItemsSortOption.byScore;
          switch (sortOption) {
            case RoomItemsSortOption.manual:
              items.sort(
                  (a, b) => a.manualOrderIndex.compareTo(b.manualOrderIndex));
              break;
            case RoomItemsSortOption.byScore:
              items.sort((a, b) => b.score.compareTo(a.score));
              break;
          }
          grouped[roomId] = items;
        }
        return grouped;
      });

  SingleOrNullSelectable<Item> byName(String name) => select(itemsTable)
    ..where((tbl) => tbl.ohName.equals(name))
    ..orderBy([
      (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
    ]);

  Stream<ItemWithState?> watchByNameWithState(String name) => Rx.combineLatest2(
          (select(itemsTable)
                ..where((tbl) => tbl.ohName.equals(name))
                ..orderBy([
                  (tbl) => OrderingTerm(
                      expression: tbl.score, mode: OrderingMode.desc)
                ]))
              .watchSingleOrNull(),
          _statesBox.watch(key: name),
          (item, state) => Tuple2(item, state)).map((tuple) {
        final item = tuple.item1;
        final state = tuple.item2.value as ItemState?;

        if (item != null && state != null) {
          return ItemWithState(item, state);
        } else {
          return null;
        }
      });

  Future<ItemWithState?> getByNameWithState(String name) async {
    final item = (await (select(itemsTable)
          ..where((tbl) => tbl.ohName.equals(name))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
          ]))
        .getSingleOrNull());
    final state = await _statesBox.get(name);

    if (item != null && state != null) {
      return ItemWithState(item, state);
    } else {
      return null;
    }
  }

  ItemState? getStateByName(String name) => _statesBox.get(name);

  // Stream that emits the current state of the item and starts with the current state
  Stream<ItemState?> watchStateByName(String name) =>
      _statesBox.watch(key: name).map((e) => e.value as ItemState?).startWith(getStateByName(name));

  List<ItemState?> statesByNameList(List<String> names) => _statesBox.keys
      .where((e) => names.contains(e.key))
      .map((e) => _statesBox.get(e))
      .toList();

  Stream<List<ItemState?>> watchStatesByNameList(List<String> names) =>
      Rx.combineLatest(names.map((e) => _statesBox.watch(key: e)), (states) {
        return states.map((e) => e.value as ItemState?).toList();
      });

  Stream<Map<Room, List<Item>>> watchGroupedByRoom() => select(itemsTable)
      .join([
        leftOuterJoin(roomsTable, roomsTable.id.equalsExp(itemsTable.roomId)),
      ])
      .watch()
      .map((rows) {
        return rows.fold<Map<Room, List<Item>>>({}, (map, row) {
          final room = row.readTable(roomsTable);
          final item = row.readTable(itemsTable);

          if (map.containsKey(room)) {
            map[room]!.add(item);
          } else {
            map[room] = [item];
          }

          return map;
        });
      });

  Stream<int> watchInboxItemsCount() =>
      (select(itemsTable)..where((tbl) => tbl.roomId.isNull()))
          .watch()
          .map((event) => event.length);

  Future<void> insertOrUpdate(List<ItemsTableCompanion> data) =>
      batch((batch) => batch.insertAllOnConflictUpdate(
            itemsTable,
            data,
          ));

  Future<void> insertOrUpdateSingle(ItemsTableCompanion data) =>
      insertOrUpdate([data]);

  Future<void> insertOrUpdateStateSingle(String ohName, ItemState data) =>
      _statesBox.put(ohName, data);

  Future<void> insertOrUpdateStates(List<(String, ItemState)> data) =>
      Future.wait(data.map((e) => _statesBox.put(e.$1, e.$2)).toList());

  Future<void> updateByNameSingle(ItemsTableCompanion data) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(data.ohName.value)))
          .write(data);

  Future<void> updateByName(List<ItemsTableCompanion> data) => batch((batch) {
        for (final item in data) {
          batch.update(itemsTable, item,
              where: (table) => table.ohName.equals(item.ohName.value));
        }
      });

  Future<void> updateStateByNameSingle(String name, ItemState data) =>
      _statesBox.put(name, data);

  Future<void> updateStatesByName(List<(String, ItemState)> data) =>
      Future.wait(data.map((e) => _statesBox.put(e.$1, e.$2)).toList());

  Future<void> updateStateValueByName(String name, String state) async {
    final storedState = _statesBox.get(name);
    if (storedState != null) {
      storedState.state = state;
      return storedState.save();
    } else {
      return _statesBox.put(name, ItemState(ohName: name, state: state));
    }
  }

  Future<void> updateComplexJsonByName(
          Map<String, dynamic> data, String name) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(name)))
          .write(ItemsTableCompanion(complexJson: Value(data)));

  Future<void> updateFavoriteByName(String name, bool favorite) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(name)))
          .write(ItemsTableCompanion(isFavorite: Value(favorite)));

  Future<void> updateScoreByName(String name, double score) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(name)))
          .write(ItemsTableCompanion(score: Value(score)));

  Future<void> updateManualOrderIndexByName(
          String ohName, int manualOrderIndex) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(ohName))).write(
          ItemsTableCompanion(manualOrderIndex: Value(manualOrderIndex)));

  Future<void> incrementScoreByName(String name) => executor.runCustom(
      'UPDATE items_table SET new_score = new_score + 1 WHERE oh_name = ?',
      [name]);

  Future<void> deleteData() =>
      Future.wait([delete(itemsTable).go(), _statesBox.clear()]);

  Future<void> deleteDataByName(String name) =>
      (delete(itemsTable)..where((tbl) => tbl.ohName.equals(name))).go();

  Future<void> deleteDataByNames(List<String> names) =>
      (delete(itemsTable)..where((tbl) => tbl.ohName.isIn(names))).go();

  Future<void> deleteStateDataByName(String name) => _statesBox.delete(name);
}
