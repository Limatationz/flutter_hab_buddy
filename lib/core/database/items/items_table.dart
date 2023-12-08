import 'package:drift/drift.dart';

import '../app_database.dart';
import '../converter/string_list_converter.dart';
import '../inbox/inbox_table.dart';
import 'item_type.dart';

@DataClassName("Item")
class ItemsTable extends Table {
  TextColumn get itemType => textEnum<ItemType>()();

  TextColumn get type => textEnum<InboxEntryType>()();

  TextColumn get name => text()();

  TextColumn get label => text()();

  TextColumn get category => text().nullable()();

  TextColumn get tags => text().map(const StringListConverter()).nullable()();

  TextColumn get groups => text().map(const StringListConverter()).nullable()();

  IntColumn get roomId => integer()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  TextColumn get state => text()();

  @override
  Set<Column> get primaryKey => {name};

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY(room_id) REFERENCES rooms_table(id)',
      ];
}

class ItemWithRoom {
  final Item item;
  final Room room;

  ItemWithRoom(this.item, this.room);
}
