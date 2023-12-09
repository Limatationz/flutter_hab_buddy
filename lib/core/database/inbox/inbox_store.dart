import 'package:drift/drift.dart';

import '../app_database.dart';
import 'inbox_table.dart';

part 'inbox_store.g.dart';

@DriftAccessor(tables: [InboxTable])
class InboxStore extends DatabaseAccessor<AppDatabase> with _$InboxStoreMixin {
  InboxStore(super.database);

  MultiSelectable<InboxEntry> all() => (select(inboxTable)
    ..where((tbl) => tbl.type.equals(InboxEntryType.group.name).not())
    ..orderBy([
      (u) => OrderingTerm(expression: u.name),
    ]));

  MultiSelectable<InboxEntry> autoComplete(String query) => (select(inboxTable)
    ..where((tbl) => tbl.type.equals(InboxEntryType.group.name).not())
    ..where(
      (tbl) =>
          tbl.name.like("%$query%") |
          tbl.label.like("%$query%") |
          tbl.category.like("%$query%") |
          tbl.tags.like("%$query%") |
          tbl.groups.like("%$query%"),
    )
    ..orderBy([
      (u) => OrderingTerm(expression: u.name),
    ]));

  Future<void> insertOrUpdate(List<InboxEntry> data) async {
    await batch((batch) => batch.insertAllOnConflictUpdate(
          inboxTable,
          data,
        ));
  }

  Future<void> insertOrUpdateSingle(InboxEntry data) async {
    await insertOrUpdate([data]);
  }

  Future<void> deleteData() async {
    await delete(inboxTable).go();
  }

  Future<void> deleteDataByName(String name) async {
    await (delete(inboxTable)..where((tbl) => tbl.name.equals(name))).go();
  }

  Stream<int> count() {
    return (select(inboxTable)
          ..where((tbl) => tbl.type.equals(InboxEntryType.group.name).not()))
        .watch()
        .map((event) => event.length);
  }
}
