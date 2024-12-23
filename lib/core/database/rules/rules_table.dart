import 'package:drift/drift.dart';

import '../app_database.dart';
import '../converter/json_converter.dart';
import '../converter/rule_comverters.dart';
import '../converter/string_list_converter.dart';

@DataClassName("Rule")
class RulesTable extends Table {
  TextColumn get uid => text()();

  TextColumn get name => text().nullable()();

  TextColumn get tags => text().map(const StringListConverter()).nullable()();

  TextColumn get status => text().map(const StatusDTOConverter()).nullable()();

  TextColumn get actions => text().map(const ActionsDTOListConverter()).nullable()();

  TextColumn get conditions => text().map(const ConditionDtoListConverter()).nullable()();

  TextColumn get configuration => text().map(const JsonConverter()).nullable()();

  TextColumn get configDescriptions => text().map(const ConfigurationDtoListConverter()).nullable()();

  TextColumn get triggers => text().map(const TriggerDtoListConverter()).nullable()();

  BoolColumn get editable => boolean()();

  @override
  Set<Column> get primaryKey => {uid};
}

extension RuleDBExtension on Rule {
  bool get fromApp => tags?.contains("app") ?? false;
}
