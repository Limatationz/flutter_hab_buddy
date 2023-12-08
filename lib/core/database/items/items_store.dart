import 'package:drift/drift.dart';

import '../app_database.dart';
import '../rooms/rooms_table.dart';
import 'items_table.dart';

part 'items_store.g.dart';

@DriftAccessor(tables: [ItemsTable, RoomsTable])
class ItemsStore extends DatabaseAccessor<AppDatabase> with _$ItemsStoreMixin {
  ItemsStore(super.database);

  Stream<List<ItemWithRoom>> watch() => select(itemsTable)
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

  Future<List<Item>> getAll() => select(itemsTable).get();

  Future<void> insertOrUpdate(List<ItemsTableCompanion> data) async {
    await batch((batch) => batch.insertAllOnConflictUpdate(
          itemsTable,
          data,
        ));
  }

  Future<void> insertOrUpdateSingle(ItemsTableCompanion data) async {
    await insertOrUpdate([data]);
  }

  Future<void> deleteData() async {
    await delete(itemsTable).go();
  }

  Future<void> deleteDataByName(String name) async {
    await (delete(itemsTable)..where((tbl) => tbl.name.equals(name))).go();
  }
}
