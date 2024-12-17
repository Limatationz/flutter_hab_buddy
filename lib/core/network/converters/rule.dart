import '../../database/app_database.dart';
import '../generated/openHAB.models.swagger.dart' hide Rule;

extension RuleDBExtension on EnrichedRuleDTO {
  Rule? asDatabaseModel() {
    if (uid == null || name == null || editable == null) {
      return null;
    }
    return Rule(
      uid: uid!,
      name: name!,
      tags: tags,
      status: status,
      actions: actions,
      conditions: conditions,
      configuration: configuration,
      configDescriptions: configDescriptions,
      triggers: triggers,
      editable: editable!,
    );
  }
}