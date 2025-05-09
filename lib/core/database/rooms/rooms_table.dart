import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ColorScheme, Theme, BuildContext;

import '../../../util/color.dart';
import '../app_database.dart';
import '../converter/icon_data_converter.dart';

@DataClassName("Room")
class RoomsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get icon => text().map(const IconDataConverter()).nullable()();
  TextColumn get color => text().nullable()();
  IntColumn get level => integer().nullable()();
  IntColumn get sortKey => integer()();
  TextColumn get itemsSortOption => textEnum<RoomItemsSortOption>()();
}

enum RoomItemsSortOption {
  byScore,
  manual;

  String get localized { // TODO: translate
    switch (this) {
      case RoomItemsSortOption.byScore:
        return "Score";
      case RoomItemsSortOption.manual:
        return "Manual";
    }
  }
}

extension RoomsTableExtension on Room {
  ColorScheme getColorScheme(BuildContext context) {
    return color != null
        ? ColorScheme.fromSeed(
        seedColor: fromHex(color!),
        brightness: Theme.of(context).brightness)
        : Theme.of(context).colorScheme;
  }
}
