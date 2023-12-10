import 'package:drift/drift.dart';

import '../app_database.dart';
import 'rooms_table.dart';

part 'rooms_store.g.dart';

@DriftAccessor(tables: [RoomsTable])
class RoomsStore extends DatabaseAccessor<AppDatabase> with _$RoomsStoreMixin {
  RoomsStore(super.database);

  MultiSelectable<Room> all() => select(roomsTable);

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

  Future<void> deleteData() async {
    await delete(roomsTable).go();
  }

  Future<void> deleteDataById(int id) async {
    await (delete(roomsTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
