// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation_edit_view_arguments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutomationEditViewExtraArguments _$AutomationEditViewExtraArgumentsFromJson(
        Map<String, dynamic> json) =>
    AutomationEditViewExtraArguments(
      initialTriggers: (json['initialTriggers'] as List<dynamic>?)
          ?.map((e) => RuleTrigger.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AutomationEditViewExtraArgumentsToJson(
        AutomationEditViewExtraArguments instance) =>
    <String, dynamic>{
      'initialTriggers': instance.initialTriggers,
    };
