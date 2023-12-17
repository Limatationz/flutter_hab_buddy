import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

import '../app_database.dart';
import '../rooms/rooms_table.dart';
import 'items_table.dart';

part 'items_store.g.dart';

@DriftAccessor(tables: [ItemsTable, RoomsTable])
class ItemsStore extends DatabaseAccessor<AppDatabase> with _$ItemsStoreMixin {
  ItemsStore(super.database);

  Stream<List<ItemWithRoom>> watch() => (select(itemsTable)
        ..orderBy([
          (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
        ]))
      .join([
        leftOuterJoin(roomsTable, roomsTable.id.equalsExp(itemsTable.roomId)),
      ])
      .watch()
      .map((rows) {
        return rows.map((row) {
          return ItemWithRoom(
            row.readTable(itemsTable),
            row.readTable(roomsTable),
          );
        }).toList();
      });

  Future<List<Item>> getAll() => (select(itemsTable)
        ..orderBy([
          (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
        ]))
      .get();

  Stream<bool> hasFavorites() =>
      (select(itemsTable)..where((tbl) => tbl.isFavorite.equals(true)))
          .watch()
          .map((event) => event.isNotEmpty);

  MultiSelectable<Item> byRoomId(int roomId) => select(itemsTable)
    ..where((tbl) => tbl.roomId.equals(roomId))
    ..orderBy([
      (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
    ]);

  Stream<Map<int, List<Item>>> watchGroupedByRoomId(
          {bool onlyFavorites = false}) =>
      (select(itemsTable)
            ..where((tbl) => onlyFavorites
                ? tbl.isFavorite.equals(true)
                : tbl.isFavorite.equals(true) | tbl.isFavorite.equals(false))
            ..orderBy([
              (tbl) =>
                  OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
            ]))
          .watch()
          .map((rows) {
        return groupBy(rows, (e) => e.roomId);
      });

  SingleOrNullSelectable<Item> byName(String name) => select(itemsTable)
    ..where((tbl) => tbl.ohName.equals(name))
    ..orderBy([
      (tbl) => OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
    ]);

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

  Future<void> insertOrUpdate(List<ItemsTableCompanion> data) =>
      batch((batch) => batch.insertAllOnConflictUpdate(
            itemsTable,
            data,
          ));

  Future<void> insertOrUpdateSingle(ItemsTableCompanion data) =>
      insertOrUpdate([data]);

  Future<void> updateByName(ItemsTableCompanion data) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(data.ohName.value)))
          .write(data);

  Future<void> updateFavoriteByName(String name, bool favorite) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(name)))
          .write(ItemsTableCompanion(isFavorite: Value(favorite)));

  Future<void> updateScoreByName(String name, double score) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(name)))
          .write(ItemsTableCompanion(score: Value(score)));

  Future<void> incrementScoreByName(String name) => executor.runCustom(
      'UPDATE items_table SET new_score = new_score + 1 WHERE oh_name = ?',
      [name]);

  Future<void> deleteData() => delete(itemsTable).go();

  Future<void> deleteDataByName(String name) =>
      (delete(itemsTable)..where((tbl) => tbl.ohName.equals(name))).go();
}
