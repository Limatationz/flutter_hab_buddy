// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleTrigger _$RuleTriggerFromJson(Map<String, dynamic> json) => RuleTrigger(
      type: json['type'] as String,
      id: json['id'] as String,
      label: json['label'] as String?,
      description: json['description'] as String?,
      rawConfiguration: json['configuration'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RuleTriggerToJson(RuleTrigger instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'configuration': instance.rawConfiguration,
    };

RuleTriggerItemConfiguration _$RuleTriggerItemConfigurationFromJson(
        Map<String, dynamic> json) =>
    RuleTriggerItemConfiguration(
      itemName: json['itemName'] as String?,
      state: json['state'],
      previousState: json['previousState'],
      type: $enumDecode(_$RuleTriggerItemTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$RuleTriggerItemConfigurationToJson(
        RuleTriggerItemConfiguration instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'state': instance.state,
      'previousState': instance.previousState,
      'type': _$RuleTriggerItemTypeEnumMap[instance.type]!,
    };

const _$RuleTriggerItemTypeEnumMap = {
  RuleTriggerItemType.stateChanged: 'core.ItemStateChangeTrigger',
  RuleTriggerItemType.stateUpdated: 'core.ItemStateUpdateTrigger',
  RuleTriggerItemType.receivedCommand: 'core.ItemCommandTrigger',
};

RuleTriggerSystemStartConfiguration
    _$RuleTriggerSystemStartConfigurationFromJson(Map<String, dynamic> json) =>
        RuleTriggerSystemStartConfiguration(
          startLevel: $enumDecode(
              _$RuleTriggerSystemStartConfigurationLevelEnumMap,
              json['startlevel']),
        );

Map<String, dynamic> _$RuleTriggerSystemStartConfigurationToJson(
        RuleTriggerSystemStartConfiguration instance) =>
    <String, dynamic>{
      'startlevel': _$RuleTriggerSystemStartConfigurationLevelEnumMap[
          instance.startLevel]!,
    };

const _$RuleTriggerSystemStartConfigurationLevelEnumMap = {
  RuleTriggerSystemStartConfigurationLevel.rulesLoaded: 40,
  RuleTriggerSystemStartConfigurationLevel.ruleEngineStarted: 50,
  RuleTriggerSystemStartConfigurationLevel.userInterfaceStarted: 70,
  RuleTriggerSystemStartConfigurationLevel.thingsInitialized: 80,
  RuleTriggerSystemStartConfigurationLevel.startupComplete: 100,
};

RuleTriggerCronConfiguration _$RuleTriggerCronConfigurationFromJson(
        Map<String, dynamic> json) =>
    RuleTriggerCronConfiguration(
      cronExpression: RuleTriggerCronConfiguration.cronExpressionFromJson(
          json['cronExpression'] as String),
    );

Map<String, dynamic> _$RuleTriggerCronConfigurationToJson(
        RuleTriggerCronConfiguration instance) =>
    <String, dynamic>{
      'cronExpression': RuleTriggerCronConfiguration.cronExpressionToJson(
          instance.cronExpression),
    };

RuleTriggerUnknownConfiguration _$RuleTriggerUnknownConfigurationFromJson(
        Map<String, dynamic> json) =>
    RuleTriggerUnknownConfiguration();

Map<String, dynamic> _$RuleTriggerUnknownConfigurationToJson(
        RuleTriggerUnknownConfiguration instance) =>
    <String, dynamic>{};
