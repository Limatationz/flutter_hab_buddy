import 'package:drift/drift.dart';

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
