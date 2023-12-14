import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show IconData;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:path/path.dart' as p;

import '../network/generated/openHAB.swagger.dart';
import 'converter/command_description_converter.dart';
import 'converter/icon_data_converter.dart';
import 'converter/map_converter.dart';
import 'converter/state_description_converter.dart';
import 'converter/string_list_converter.dart';
import 'inbox/inbox_store.dart';
import 'inbox/inbox_table.dart';
import 'items/item_type.dart';
import 'items/items_store.dart';
import 'items/items_table.dart';
import 'rooms/rooms_store.dart';
import 'rooms/rooms_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  InboxTable,
  RoomsTable,
  ItemsTable,
], daos: [
  InboxStore,
  RoomsStore,
  ItemsStore,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(constructDb());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await customStatement("PRAGMA foreign_key = ON");
      if (kDebugMode && false) {
        final m = Migrator(this);
        for (final table in allTables) {
          await m.deleteTable(table.actualTableName);
          await m.createTable(table);
        }
      }
    }, onCreate: (Migrator m) async {
      await m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {

    });
  }

  Future<void> deleteAllData() async {
    for (var table in allTables) {
      print("db table delete -> $table");
      await delete(table).go();
    }
  }
}

DatabaseConnection constructDb() {
  return DatabaseConnection.delayed(Future(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();

      final cachebase = (await getTemporaryDirectory()).path;

      // We can't access /tmp on Android, which sqlite3 would try by default.
      // Explicitly tell it about the correct temporary directory.
      sqlite3.tempDirectory = cachebase;
    }

    return NativeDatabase.createBackgroundConnection(file);
  }));
}

Future<void> validateDatabaseSchema(GeneratedDatabase database) async {
  // This method validates that the actual schema of the opened database matches
  // the tables, views, triggers and indices for which drift_dev has generated
  // code.
  // Validating the database's schema after opening it is generally a good idea,
  // since it allows us to get an early warning if we change a table definition
  // without writing a schema migration for it.
  //
  // For details, see: https://drift.simonbinder.eu/docs/advanced-features/migrations/#verifying-a-database-schema-at-runtime
  if (kDebugMode) {
    await VerifySelf(database).validateDatabaseSchema();
  }
}