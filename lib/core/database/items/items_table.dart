import 'package:drift/drift.dart';
import 'package:sprintf/sprintf.dart';

import '../app_database.dart';
import '../converter/command_description_converter.dart';
import '../converter/icon_data_converter.dart';
import '../converter/json_converter.dart';
import '../converter/state_description_converter.dart';
import '../converter/string_list_converter.dart';
import 'item_type.dart';
import 'oh_item_type.dart';

@DataClassName("Item")
class ItemsTable extends Table {
  TextColumn get type => textEnum<ItemType>()();

  TextColumn get ohType => textEnum<OhItemType>()();

  TextColumn get ohName => text()();

  TextColumn get ohLabel => text()();

  TextColumn get customLabel => text().nullable()();

  TextColumn get ohCategory => text().nullable()();

  TextColumn get ohTags => text().map(const StringListConverter()).nullable()();

  TextColumn get ohGroups =>
      text().map(const StringListConverter()).nullable()();

  IntColumn get roomId => integer()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  TextColumn get icon => text().map(const IconDataConverter()).nullable()();

  RealColumn get score => real().withDefault(const Constant(0))();

  RealColumn get newScore => real().withDefault(const Constant(0))();

  TextColumn get complexJson => text().map(const JsonConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {ohName};

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

class ItemWithState {
  final Item item;
  final ItemState state;

  ItemWithState(this.item, this.state);
}

extension ItemLabel on Item {
  String get label => customLabel ?? ohLabel;



  bool get isSensor =>
      type == ItemType.temperature ||
      type == ItemType.humidity ||
      type == ItemType.airPressure ||
      type == ItemType.airQuality ||
      type == ItemType.presence;
}


