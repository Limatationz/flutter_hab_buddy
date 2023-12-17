import 'package:drift/drift.dart';

import '../converter/command_description_converter.dart';
import '../converter/state_description_converter.dart';
import '../converter/string_list_converter.dart';
import '../items/oh_item_type.dart';

@DataClassName("InboxEntry")
class InboxTable extends Table {
  TextColumn get type => textEnum<OhItemType>()();

  TextColumn get name => text()();

  TextColumn get label => text()();

  TextColumn get category => text().nullable()();

  TextColumn get tags => text().map(const StringListConverter()).nullable()();

  TextColumn get groups => text().map(const StringListConverter()).nullable()();

  TextColumn get state => text()();

  TextColumn get unitSymbol => text().nullable()();

  TextColumn get transformedState => text().nullable()();

  TextColumn get stateDescription =>
      text().map(const StateDescriptionConverter()).nullable()();

  TextColumn get commandDescription =>
      text().map(const CommandDescriptionConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {name};
}