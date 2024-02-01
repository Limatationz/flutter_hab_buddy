import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

import '../app_database.dart';
import '../rooms/rooms_table.dart';
import '../state/item_states_table.dart';
import 'item_type.dart';
import 'items_table.dart';
import 'oh_item_type.dart';

part 'items_store.g.dart';

@DriftAccessor(tables: [ItemsTable, RoomsTable, ItemStatesTable])
class ItemsStore extends DatabaseAccessor<AppDatabase> with _$ItemsStoreMixin {
  ItemsStore(super.database);

  MultiSelectable<Item> all() => (select(itemsTable)
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
          {bool onlyFavorites = false}) =>
      (select(itemsTable)
            ..where((tbl) => onlyFavorites
                ? tbl.isFavorite.equals(true)
                : tbl.isFavorite.equals(true) | tbl.isFavorite.equals(false))
            ..where(
                (tbl) => tbl.type.equalsValue(ItemType.complexComponent).not())
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

  Stream<ItemWithState?> watchByNameWithState(String name) =>
      (select(itemsTable)
            ..where((tbl) => tbl.ohName.equals(name))
            ..orderBy([
              (tbl) =>
                  OrderingTerm(expression: tbl.score, mode: OrderingMode.desc)
            ]))
          .join([
            leftOuterJoin(itemStatesTable,
                itemStatesTable.ohName.equalsExp(itemsTable.ohName)),
          ])
          .watchSingleOrNull()
          .map((row) {
            final item = row?.readTable(itemsTable);
            final state = row?.readTable(itemStatesTable);

            if (item != null && state != null) {
              return ItemWithState(item, state);
            } else {
              return null;
            }
          });

  SingleOrNullSelectable<ItemState> stateByName(String name) =>
      select(itemStatesTable)..where((tbl) => tbl.ohName.equals(name));

  MultiSelectable<ItemState> statesByNameList(List<String> names) =>
      select(itemStatesTable)..where((tbl) => tbl.ohName.isIn(names));

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

  Future<void> insertOrUpdateState(ItemStatesTableCompanion data) =>
      batch((batch) => batch.insertAllOnConflictUpdate(
            itemStatesTable,
            [data],
          ));

  Future<void> updateByName(ItemsTableCompanion data) =>
      (update(itemsTable)..where((tbl) => tbl.ohName.equals(data.ohName.value)))
          .write(data);

  Future<void> updateStateByName(ItemStatesTableCompanion data) =>
      (update(itemStatesTable)
            ..where((tbl) => tbl.ohName.equals(data.ohName.value)))
          .write(data);

  Future<void> updateStateValueByName(String name, String state) =>
      (update(itemStatesTable)..where((tbl) => tbl.ohName.equals(name)))
          .write(ItemStatesTableCompanion(state: Value(state)));

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

  Future<void> incrementScoreByName(String name) => executor.runCustom(
      'UPDATE items_table SET new_score = new_score + 1 WHERE oh_name = ?',
      [name]);

  Future<void> deleteData() =>
      Future.wait([delete(itemsTable).go(), delete(itemStatesTable).go()]);

  Future<void> deleteDataByName(String name) =>
      (delete(itemsTable)..where((tbl) => tbl.ohName.equals(name))).go();

  Future<void> deleteStateDataByName(String name) =>
      (delete(itemStatesTable)..where((tbl) => tbl.ohName.equals(name))).go();
}
