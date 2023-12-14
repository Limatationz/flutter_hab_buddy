import 'package:drift/drift.dart';

import '../app_database.dart';
import '../converter/command_description_converter.dart';
import '../converter/icon_data_converter.dart';
import '../converter/state_description_converter.dart';
import '../converter/string_list_converter.dart';
import '../inbox/inbox_table.dart';
import 'item_type.dart';

@DataClassName("Item")
class ItemsTable extends Table {
  TextColumn get type => textEnum<ItemType>()();

  TextColumn get ohType => textEnum<InboxEntryType>()();

  TextColumn get ohName => text()();

  TextColumn get ohLabel => text()();

  TextColumn get customLabel => text().nullable()();

  TextColumn get ohCategory => text().nullable()();

  TextColumn get ohTags => text().map(const StringListConverter()).nullable()();

  TextColumn get ohGroups =>
      text().map(const StringListConverter()).nullable()();

  TextColumn get ohUnitSymbol => text().nullable()();

  IntColumn get roomId => integer()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  TextColumn get icon => text().map(const IconDataConverter()).nullable()();

  TextColumn get state => text()();

  TextColumn get transformedState => text().nullable()();

  TextColumn get stateDescription =>
      text().map(const StateDescriptionConverter()).nullable()();

  TextColumn get commandDescription =>
      text().map(const CommandDescriptionConverter()).nullable()();

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

extension ItemLabel on Item {
  String get label => customLabel ?? ohLabel;
  String get itemState => transformedState ?? (ohUnitSymbol != null ? '$state $ohUnitSymbol' : state);

  bool get isReadOnly => stateDescription?.readOnly ?? false;
}
