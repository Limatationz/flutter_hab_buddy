import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show IconData;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:path/path.dart' as p;
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../locator.dart';
import '../../util/shared_prefs_keys.dart';
import '../network/generated/openHAB.swagger.dart';
import 'converter/command_description_converter.dart';
import 'converter/icon_data_converter.dart';
import 'converter/json_converter.dart';
import 'converter/rule_converters.dart';
import 'converter/state_description_converter.dart';
import 'converter/string_list_converter.dart';
import 'inbox/inbox_store.dart';
import 'inbox/inbox_table.dart';
import 'items/item_type.dart';
import 'items/items_store.dart';
import 'items/items_table.dart';
import 'items/oh_item_type.dart';
import 'rooms/rooms_store.dart';
import 'rooms/rooms_table.dart';
import 'rules/rule_trigger.dart';
import 'rules/rules_store.dart';
import 'rules/rules_table.dart';
import 'state/item_states_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  InboxTable,
  RoomsTable,
  ItemsTable,
  ItemStatesTable,
  RulesTable,
], daos: [
  InboxStore,
  RoomsStore,
  ItemsStore,
  RulesStore,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.defaults() : super(driftDatabase(name: 'app_db'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement("PRAGMA foreign_key = ON");
          if (kDebugMode && false) {
            final m = Migrator(this);
            for (final table in allTables) {
              await m.deleteTable(table.actualTableName);
              await m.createTable(table);
            }
          }

          await initScores();
        },
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {});
  }

  Future<void> initScores() async {
    // set score of items to new score
    await customStatement("UPDATE items_table SET score = new_score");

    // reset score if time is over
    final prefs = locator<StreamingSharedPreferences>();
    final lastScoreReset =
        prefs.getInt(lastItemScoreResetKey, defaultValue: 0).getValue();
    if (lastScoreReset == 0) {
      // First start
      prefs.setInt(
          lastItemScoreResetKey, DateTime.now().millisecondsSinceEpoch);
    } else {
      final lastScoreResetDate =
          DateTime.fromMillisecondsSinceEpoch(lastScoreReset);
      if (DateTime.now().difference(lastScoreResetDate).inDays > 14) {
        // Reset all scores after 14 days
        prefs.setInt(
            lastItemScoreResetKey, DateTime.now().millisecondsSinceEpoch);
        await customStatement(
            'UPDATE items_table SET score = score / 10 WHERE score > 0');
        await customStatement('UPDATE items_table SET new_score = score');
      }
    }
  }

  Future<void> deleteAllData() async {
    for (var table in allTables) {
      print("db table delete -> $table");
      await delete(table).go();
    }
  }
}
