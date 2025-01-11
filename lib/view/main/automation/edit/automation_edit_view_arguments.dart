import 'package:json_annotation/json_annotation.dart';

import '../../../../core/database/rules/rule_trigger.dart';

part 'automation_edit_view_arguments.g.dart';

@JsonSerializable()
class AutomationEditViewExtraArguments extends JsonSerializable {
  final List<RuleTrigger>? initialTriggers;

  const AutomationEditViewExtraArguments({this.initialTriggers});

  factory AutomationEditViewExtraArguments.fromJson(Map<String, dynamic> json) =>
      _$AutomationEditViewExtraArgumentsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AutomationEditViewExtraArgumentsToJson(this);
}