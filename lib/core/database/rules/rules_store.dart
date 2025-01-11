import 'dart:math';

import 'package:drift/drift.dart';

import '../app_database.dart';
import 'rules_table.dart';

part 'rules_store.g.dart';

@DriftAccessor(tables: [RulesTable])
class RulesStore extends DatabaseAccessor<AppDatabase> with _$RulesStoreMixin {
  RulesStore(super.database);

  MultiSelectable<Rule> all() => select(rulesTable);

  MultiSelectable<Rule> editable() =>
      select(rulesTable)..where((tbl) => tbl.editable.equals(true));

  SingleOrNullSelectable<Rule> byUid(String uid) =>
      select(rulesTable)..where((tbl) => tbl.uid.equals(uid));

  MultiSelectable<Rule> editableByItemName(String itemName) {
    final itemNamePattern =
        '%"itemName":"$itemName"%'; // Pattern to match the itemName in the JSON

    return select(rulesTable)
      ..where((tbl) =>
          tbl.triggers.like(itemNamePattern) |
          tbl.actions.like(itemNamePattern));
  }

  Future<void> insertOrUpdate(List<RulesTableCompanion> data) async {
    await batch((batch) => batch.insertAllOnConflictUpdate(
          rulesTable,
          data,
        ));
  }

  Future<void> insertOrUpdateSingle(RulesTableCompanion data) async {
    await insertOrUpdate([data]);
  }

  Future<int> insertOrUpdateSingleWithId(RulesTableCompanion data) async {
    return await into(rulesTable).insertOnConflictUpdate(data);
  }

  Future<void> deleteData() async {
    await delete(rulesTable).go();
  }

  Future<void> deleteDataByUid(String uid) async {
    await (delete(rulesTable)..where((tbl) => tbl.uid.equals(uid))).go();
  }
}
