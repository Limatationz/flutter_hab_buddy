import 'package:drift/drift.dart';

import '../../../view/main/automation/edit/automation_edit_viewmodel.dart';
import '../app_database.dart';
import '../converter/json_converter.dart';
import '../converter/rule_converters.dart';
import '../converter/string_list_converter.dart';
import 'rule_trigger.dart';

@DataClassName("Rule")
class RulesTable extends Table {
  TextColumn get uid => text()();

  TextColumn get name => text().nullable()();

  TextColumn get tags => text().map(const StringListConverter()).nullable()();

  TextColumn get status => text().map(const StatusDTOConverter()).nullable()();

  TextColumn get actions =>
      text().map(const ActionsDTOListConverter()).nullable()();

  TextColumn get conditions =>
      text().map(const ConditionDtoListConverter()).nullable()();

  TextColumn get configuration =>
      text().map(const JsonConverter()).nullable()();

  TextColumn get configDescriptions =>
      text().map(const ConfigurationDtoListConverter()).nullable()();

  TextColumn get triggers =>
      text().map(const RuleTriggerListConverter()).nullable()();

  BoolColumn get editable => boolean()();

  @override
  Set<Column> get primaryKey => {uid};
}

extension RuleDBExtension on Rule {
  bool get fromApp => tags?.contains(ruleAppTag) ?? false;

  bool get autoDelete => tags?.contains(autoDeleteTag) ?? false;

  RuleTriggerType? get triggerType {
    if (triggers?.isEmpty ?? true) {
      return null;
    } else {
      final firstType = triggers!.first.type;
      // check if other triggers have the same type
      if (triggers!
          .map((e) => e.type)
          .every((e) => e == firstType)) {
        return RuleTriggerType.fromString(firstType);
      } else {
        // complex
        return null;
      }
    }
  }

  RuleOptions get options {
    return RuleOptions(
        autoDelete: tags?.contains(autoDeleteTag) ?? false, name: name);
  }
}

const ruleAppTag = "openHabCompanionApp";
const autoDeleteTag = "openHabCompanionAppAutoDeleteAfterDone";
