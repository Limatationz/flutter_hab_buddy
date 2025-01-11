import '../../database/app_database.dart';
import '../../database/rules/rule_trigger.dart';
import '../generated/openHAB.models.swagger.dart' hide Rule;

extension RuleDBExtension on EnrichedRuleDTO {
  Rule? asDatabaseModel() {
    if (uid == null || editable == null) {
      return null;
    }
    return Rule(
      uid: uid!,
      name: name,
      tags: tags,
      status: status,
      actions: actions,
      conditions: conditions,
      configuration: configuration,
      configDescriptions: configDescriptions,
      triggers: triggers?.map((e) => RuleTrigger.fromTriggerDto(e)).toList(),
      editable: editable!,
    );
  }
}
