import 'dart:math';

import 'package:drift/drift.dart';

import '../app_database.dart';
import 'rooms_table.dart';

part 'rooms_store.g.dart';

@DriftAccessor(tables: [RoomsTable])
class RoomsStore extends DatabaseAccessor<AppDatabase> with _$RoomsStoreMixin {
  RoomsStore(super.database);

  MultiSelectable<Room> all() =>
      select(roomsTable)..orderBy([(t) => OrderingTerm(expression: t.sortKey)]);

  SingleSelectable<Room> byId(int id) => select(roomsTable)..where((tbl) => tbl.id.equals(id));

  Future<int> getLastSortKey() async {
    final allRooms = await all().get();
    if (allRooms.isEmpty) {
      return -1;
    } else {
      return allRooms.map((e) => e.sortKey).reduce(max);
    }
  }

  Future<void> insertOrUpdate(List<RoomsTableCompanion> data) async {
    await batch((batch) => batch.insertAllOnConflictUpdate(
          roomsTable,
          data,
        ));
  }

  Future<void> insertOrUpdateSingle(RoomsTableCompanion data) async {
    await insertOrUpdate([data]);
  }

  Future<int> insertOrUpdateSingleWithId(RoomsTableCompanion data) async {
    return await into(roomsTable).insertOnConflictUpdate(data);
  }

  Future<void> updateSortKey(int oldSortKey, int newSortKey) async {
    // get id of room with the oldSortKey
    final roomId = (await (select(roomsTable)
          ..where((tbl) => tbl.sortKey.equals(oldSortKey))
          ..limit(1))
        .getSingle())
        .id;

    int diff = 0;
    if (oldSortKey < newSortKey) {
      diff = 1;
    }

    // set new sortkey to the room
    await (update(roomsTable)..where((tbl) => tbl.id.equals(roomId)))
        .write(RoomsTableCompanion(
      sortKey: Value(newSortKey - diff ),
    ));

    // update the sortkeys of all rooms inbetween the old and new sortkey
    if (oldSortKey < newSortKey) {
      await (update(roomsTable)
            ..where(
                (tbl) => tbl.sortKey.isBetweenValues(oldSortKey, newSortKey - 1))
            ..where((tbl) => tbl.id.isNotValue(roomId)))
          .write(RoomsTableCompanion.custom(
              sortKey: roomsTable.sortKey - const Constant(1)));
    } else {
      await (update(roomsTable)
            ..where(
                (tbl) => tbl.sortKey.isBetweenValues(newSortKey, oldSortKey))
            ..where((tbl) => tbl.id.isNotValue(roomId)))
          .write(RoomsTableCompanion.custom(
              sortKey: roomsTable.sortKey + const Constant(1)));
    }
  }

  Future<void> deleteData() async {
    await delete(roomsTable).go();
  }

  Future<void> deleteDataById(int id) async {
    await (delete(roomsTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
