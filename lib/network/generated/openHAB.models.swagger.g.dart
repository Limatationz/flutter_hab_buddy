// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openHAB.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigDescriptionParameterDTO _$ConfigDescriptionParameterDTOFromJson(
        Map<String, dynamic> json) =>
    ConfigDescriptionParameterDTO(
      context: json['context'] as String?,
      defaultValue: json['defaultValue'] as String?,
      description: json['description'] as String?,
      label: json['label'] as String?,
      name: json['name'] as String?,
      required: json['required'] as bool?,
      type: configDescriptionParameterDTOTypeNullableFromJson(json['type']),
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      stepsize: (json['stepsize'] as num?)?.toDouble(),
      pattern: json['pattern'] as String?,
      readOnly: json['readOnly'] as bool?,
      multiple: json['multiple'] as bool?,
      multipleLimit: json['multipleLimit'] as int?,
      groupName: json['groupName'] as String?,
      advanced: json['advanced'] as bool?,
      verify: json['verify'] as bool?,
      limitToOptions: json['limitToOptions'] as bool?,
      unit: json['unit'] as String?,
      unitLabel: json['unitLabel'] as String?,
      options: (json['options'] as List<dynamic>?)
              ?.map(
                  (e) => ParameterOptionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filterCriteria: (json['filterCriteria'] as List<dynamic>?)
              ?.map(
                  (e) => FilterCriteriaDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ConfigDescriptionParameterDTOToJson(
        ConfigDescriptionParameterDTO instance) =>
    <String, dynamic>{
      'context': instance.context,
      'defaultValue': instance.defaultValue,
      'description': instance.description,
      'label': instance.label,
      'name': instance.name,
      'required': instance.required,
      'type': configDescriptionParameterDTOTypeNullableToJson(instance.type),
      'min': instance.min,
      'max': instance.max,
      'stepsize': instance.stepsize,
      'pattern': instance.pattern,
      'readOnly': instance.readOnly,
      'multiple': instance.multiple,
      'multipleLimit': instance.multipleLimit,
      'groupName': instance.groupName,
      'advanced': instance.advanced,
      'verify': instance.verify,
      'limitToOptions': instance.limitToOptions,
      'unit': instance.unit,
      'unitLabel': instance.unitLabel,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'filterCriteria':
          instance.filterCriteria?.map((e) => e.toJson()).toList(),
    };

FilterCriteriaDTO _$FilterCriteriaDTOFromJson(Map<String, dynamic> json) =>
    FilterCriteriaDTO(
      value: json['value'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$FilterCriteriaDTOToJson(FilterCriteriaDTO instance) =>
    <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
    };

ModuleTypeDTO _$ModuleTypeDTOFromJson(Map<String, dynamic> json) =>
    ModuleTypeDTO(
      uid: json['uid'] as String?,
      visibility: moduleTypeDTOVisibilityNullableFromJson(json['visibility']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      label: json['label'] as String?,
      description: json['description'] as String?,
      configDescriptions: (json['configDescriptions'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ModuleTypeDTOToJson(ModuleTypeDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'visibility': moduleTypeDTOVisibilityNullableToJson(instance.visibility),
      'tags': instance.tags,
      'label': instance.label,
      'description': instance.description,
      'configDescriptions':
          instance.configDescriptions?.map((e) => e.toJson()).toList(),
    };

ParameterOptionDTO _$ParameterOptionDTOFromJson(Map<String, dynamic> json) =>
    ParameterOptionDTO(
      label: json['label'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ParameterOptionDTOToJson(ParameterOptionDTO instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };

ActionDTO _$ActionDTOFromJson(Map<String, dynamic> json) => ActionDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      type: json['type'] as String?,
      inputs: json['inputs'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ActionDTOToJson(ActionDTO instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'configuration': instance.configuration,
      'type': instance.type,
      'inputs': instance.inputs,
    };

ConditionDTO _$ConditionDTOFromJson(Map<String, dynamic> json) => ConditionDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      type: json['type'] as String?,
      inputs: json['inputs'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ConditionDTOToJson(ConditionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'configuration': instance.configuration,
      'type': instance.type,
      'inputs': instance.inputs,
    };

RuleDTO _$RuleDTOFromJson(Map<String, dynamic> json) => RuleDTO(
      triggers: (json['triggers'] as List<dynamic>?)
              ?.map((e) => TriggerDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      conditions: (json['conditions'] as List<dynamic>?)
              ?.map((e) => ConditionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => ActionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      configuration: json['configuration'] as Map<String, dynamic>?,
      configDescriptions: (json['configDescriptions'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      templateUID: json['templateUID'] as String?,
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      visibility: ruleDTOVisibilityNullableFromJson(json['visibility']),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RuleDTOToJson(RuleDTO instance) => <String, dynamic>{
      'triggers': instance.triggers?.map((e) => e.toJson()).toList(),
      'conditions': instance.conditions?.map((e) => e.toJson()).toList(),
      'actions': instance.actions?.map((e) => e.toJson()).toList(),
      'configuration': instance.configuration,
      'configDescriptions':
          instance.configDescriptions?.map((e) => e.toJson()).toList(),
      'templateUID': instance.templateUID,
      'uid': instance.uid,
      'name': instance.name,
      'tags': instance.tags,
      'visibility': ruleDTOVisibilityNullableToJson(instance.visibility),
      'description': instance.description,
    };

TriggerDTO _$TriggerDTOFromJson(Map<String, dynamic> json) => TriggerDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$TriggerDTOToJson(TriggerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'configuration': instance.configuration,
      'type': instance.type,
    };

EnrichedRuleDTO _$EnrichedRuleDTOFromJson(Map<String, dynamic> json) =>
    EnrichedRuleDTO(
      triggers: (json['triggers'] as List<dynamic>?)
              ?.map((e) => TriggerDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      conditions: (json['conditions'] as List<dynamic>?)
              ?.map((e) => ConditionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => ActionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      configuration: json['configuration'] as Map<String, dynamic>?,
      configDescriptions: (json['configDescriptions'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      templateUID: json['templateUID'] as String?,
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      visibility: enrichedRuleDTOVisibilityNullableFromJson(json['visibility']),
      description: json['description'] as String?,
      status: json['status'] == null
          ? null
          : RuleStatusInfo.fromJson(json['status'] as Map<String, dynamic>),
      editable: json['editable'] as bool?,
    );

Map<String, dynamic> _$EnrichedRuleDTOToJson(EnrichedRuleDTO instance) =>
    <String, dynamic>{
      'triggers': instance.triggers?.map((e) => e.toJson()).toList(),
      'conditions': instance.conditions?.map((e) => e.toJson()).toList(),
      'actions': instance.actions?.map((e) => e.toJson()).toList(),
      'configuration': instance.configuration,
      'configDescriptions':
          instance.configDescriptions?.map((e) => e.toJson()).toList(),
      'templateUID': instance.templateUID,
      'uid': instance.uid,
      'name': instance.name,
      'tags': instance.tags,
      'visibility':
          enrichedRuleDTOVisibilityNullableToJson(instance.visibility),
      'description': instance.description,
      'status': instance.status?.toJson(),
      'editable': instance.editable,
    };

RuleStatusInfo _$RuleStatusInfoFromJson(Map<String, dynamic> json) =>
    RuleStatusInfo(
      status: ruleStatusInfoStatusNullableFromJson(json['status']),
      statusDetail:
          ruleStatusInfoStatusDetailNullableFromJson(json['statusDetail']),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RuleStatusInfoToJson(RuleStatusInfo instance) =>
    <String, dynamic>{
      'status': ruleStatusInfoStatusNullableToJson(instance.status),
      'statusDetail':
          ruleStatusInfoStatusDetailNullableToJson(instance.statusDetail),
      'description': instance.description,
    };

ModuleDTO _$ModuleDTOFromJson(Map<String, dynamic> json) => ModuleDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ModuleDTOToJson(ModuleDTO instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'configuration': instance.configuration,
      'type': instance.type,
    };

Action _$ActionFromJson(Map<String, dynamic> json) => Action(
      inputs: json['inputs'] as Map<String, dynamic>?,
      typeUID: json['typeUID'] as String?,
      description: json['description'] as String?,
      label: json['label'] as String?,
      id: json['id'] as String?,
      configuration: json['configuration'] == null
          ? null
          : Configuration.fromJson(
              json['configuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActionToJson(Action instance) => <String, dynamic>{
      'inputs': instance.inputs,
      'typeUID': instance.typeUID,
      'description': instance.description,
      'label': instance.label,
      'id': instance.id,
      'configuration': instance.configuration?.toJson(),
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
      inputs: json['inputs'] as Map<String, dynamic>?,
      typeUID: json['typeUID'] as String?,
      description: json['description'] as String?,
      label: json['label'] as String?,
      id: json['id'] as String?,
      configuration: json['configuration'] == null
          ? null
          : Configuration.fromJson(
              json['configuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'inputs': instance.inputs,
      'typeUID': instance.typeUID,
      'description': instance.description,
      'label': instance.label,
      'id': instance.id,
      'configuration': instance.configuration?.toJson(),
    };

ConfigDescriptionParameter _$ConfigDescriptionParameterFromJson(
        Map<String, dynamic> json) =>
    ConfigDescriptionParameter(
      name: json['name'] as String?,
      type: configDescriptionParameterTypeNullableFromJson(json['type']),
      groupName: json['groupName'] as String?,
      pattern: json['pattern'] as String?,
      required: json['required'] as bool?,
      readOnly: json['readOnly'] as bool?,
      multiple: json['multiple'] as bool?,
      multipleLimit: json['multipleLimit'] as int?,
      unit: json['unit'] as String?,
      unitLabel: json['unitLabel'] as String?,
      context: json['context'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => ParameterOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      filterCriteria: (json['filterCriteria'] as List<dynamic>?)
              ?.map((e) => FilterCriteria.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      limitToOptions: json['limitToOptions'] as bool?,
      advanced: json['advanced'] as bool?,
      stepSize: (json['stepSize'] as num?)?.toDouble(),
      verifyable: json['verifyable'] as bool?,
      minimum: (json['minimum'] as num?)?.toDouble(),
      maximum: (json['maximum'] as num?)?.toDouble(),
      $default: json['default'] as String?,
    );

Map<String, dynamic> _$ConfigDescriptionParameterToJson(
        ConfigDescriptionParameter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': configDescriptionParameterTypeNullableToJson(instance.type),
      'groupName': instance.groupName,
      'pattern': instance.pattern,
      'required': instance.required,
      'readOnly': instance.readOnly,
      'multiple': instance.multiple,
      'multipleLimit': instance.multipleLimit,
      'unit': instance.unit,
      'unitLabel': instance.unitLabel,
      'context': instance.context,
      'label': instance.label,
      'description': instance.description,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'filterCriteria':
          instance.filterCriteria?.map((e) => e.toJson()).toList(),
      'limitToOptions': instance.limitToOptions,
      'advanced': instance.advanced,
      'stepSize': instance.stepSize,
      'verifyable': instance.verifyable,
      'minimum': instance.minimum,
      'maximum': instance.maximum,
      'default': instance.$default,
    };

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration(
      properties: json['properties'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'properties': instance.properties,
    };

FilterCriteria _$FilterCriteriaFromJson(Map<String, dynamic> json) =>
    FilterCriteria(
      value: json['value'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$FilterCriteriaToJson(FilterCriteria instance) =>
    <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
    };

Module _$ModuleFromJson(Map<String, dynamic> json) => Module(
      typeUID: json['typeUID'] as String?,
      description: json['description'] as String?,
      label: json['label'] as String?,
      id: json['id'] as String?,
      configuration: json['configuration'] == null
          ? null
          : Configuration.fromJson(
              json['configuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'typeUID': instance.typeUID,
      'description': instance.description,
      'label': instance.label,
      'id': instance.id,
      'configuration': instance.configuration?.toJson(),
    };

ParameterOption _$ParameterOptionFromJson(Map<String, dynamic> json) =>
    ParameterOption(
      label: json['label'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ParameterOptionToJson(ParameterOption instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };

Rule _$RuleFromJson(Map<String, dynamic> json) => Rule(
      configurationDescriptions:
          (json['configurationDescriptions'] as List<dynamic>?)
                  ?.map((e) => ConfigDescriptionParameter.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
      templateUID: json['templateUID'] as String?,
      triggers: (json['triggers'] as List<dynamic>?)
              ?.map((e) => Trigger.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      visibility: ruleVisibilityNullableFromJson(json['visibility']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      uid: json['uid'] as String?,
      description: json['description'] as String?,
      name: json['name'] as String?,
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => Action.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      configuration: json['configuration'] == null
          ? null
          : Configuration.fromJson(
              json['configuration'] as Map<String, dynamic>),
      modules: (json['modules'] as List<dynamic>?)
              ?.map((e) => Module.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      conditions: (json['conditions'] as List<dynamic>?)
              ?.map((e) => Condition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RuleToJson(Rule instance) => <String, dynamic>{
      'configurationDescriptions':
          instance.configurationDescriptions?.map((e) => e.toJson()).toList(),
      'templateUID': instance.templateUID,
      'triggers': instance.triggers?.map((e) => e.toJson()).toList(),
      'visibility': ruleVisibilityNullableToJson(instance.visibility),
      'tags': instance.tags,
      'uid': instance.uid,
      'description': instance.description,
      'name': instance.name,
      'actions': instance.actions?.map((e) => e.toJson()).toList(),
      'configuration': instance.configuration?.toJson(),
      'modules': instance.modules?.map((e) => e.toJson()).toList(),
      'conditions': instance.conditions?.map((e) => e.toJson()).toList(),
    };

RuleExecution _$RuleExecutionFromJson(Map<String, dynamic> json) =>
    RuleExecution(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      rule: json['rule'] == null
          ? null
          : Rule.fromJson(json['rule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuleExecutionToJson(RuleExecution instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'rule': instance.rule?.toJson(),
    };

Trigger _$TriggerFromJson(Map<String, dynamic> json) => Trigger(
      typeUID: json['typeUID'] as String?,
      description: json['description'] as String?,
      label: json['label'] as String?,
      id: json['id'] as String?,
      configuration: json['configuration'] == null
          ? null
          : Configuration.fromJson(
              json['configuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TriggerToJson(Trigger instance) => <String, dynamic>{
      'typeUID': instance.typeUID,
      'description': instance.description,
      'label': instance.label,
      'id': instance.id,
      'configuration': instance.configuration?.toJson(),
    };

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      visibility: templateVisibilityNullableFromJson(json['visibility']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      uid: json['uid'] as String?,
      description: json['description'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      'visibility': templateVisibilityNullableToJson(instance.visibility),
      'tags': instance.tags,
      'uid': instance.uid,
      'description': instance.description,
      'label': instance.label,
    };

Input _$InputFromJson(Map<String, dynamic> json) => Input(
      name: json['name'] as String?,
      type: json['type'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      required: json['required'] as bool?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      reference: json['reference'] as String?,
      defaultValue: json['defaultValue'] as String?,
    );

Map<String, dynamic> _$InputToJson(Input instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'label': instance.label,
      'description': instance.description,
      'required': instance.required,
      'tags': instance.tags,
      'reference': instance.reference,
      'defaultValue': instance.defaultValue,
    };

Output _$OutputFromJson(Map<String, dynamic> json) => Output(
      name: json['name'] as String?,
      type: json['type'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      label: json['label'] as String?,
      description: json['description'] as String?,
      reference: json['reference'] as String?,
      defaultValue: json['defaultValue'] as String?,
    );

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'tags': instance.tags,
      'label': instance.label,
      'description': instance.description,
      'reference': instance.reference,
      'defaultValue': instance.defaultValue,
    };

ThingActionDTO _$ThingActionDTOFromJson(Map<String, dynamic> json) =>
    ThingActionDTO(
      actionUid: json['actionUid'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      inputs: (json['inputs'] as List<dynamic>?)
              ?.map((e) => Input.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      outputs: (json['outputs'] as List<dynamic>?)
              ?.map((e) => Output.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ThingActionDTOToJson(ThingActionDTO instance) =>
    <String, dynamic>{
      'actionUid': instance.actionUid,
      'label': instance.label,
      'description': instance.description,
      'inputs': instance.inputs?.map((e) => e.toJson()).toList(),
      'outputs': instance.outputs?.map((e) => e.toJson()).toList(),
    };

AudioSinkDTO _$AudioSinkDTOFromJson(Map<String, dynamic> json) => AudioSinkDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$AudioSinkDTOToJson(AudioSinkDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
    };

AudioSourceDTO _$AudioSourceDTOFromJson(Map<String, dynamic> json) =>
    AudioSourceDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$AudioSourceDTOToJson(AudioSourceDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
    };

UserApiTokenDTO _$UserApiTokenDTOFromJson(Map<String, dynamic> json) =>
    UserApiTokenDTO(
      name: json['name'] as String?,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      scope: json['scope'] as String?,
    );

Map<String, dynamic> _$UserApiTokenDTOToJson(UserApiTokenDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createdTime': instance.createdTime?.toIso8601String(),
      'scope': instance.scope,
    };

UserSessionDTO _$UserSessionDTOFromJson(Map<String, dynamic> json) =>
    UserSessionDTO(
      sessionId: json['sessionId'] as String?,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      lastRefreshTime: json['lastRefreshTime'] == null
          ? null
          : DateTime.parse(json['lastRefreshTime'] as String),
      clientId: json['clientId'] as String?,
      scope: json['scope'] as String?,
    );

Map<String, dynamic> _$UserSessionDTOToJson(UserSessionDTO instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'createdTime': instance.createdTime?.toIso8601String(),
      'lastRefreshTime': instance.lastRefreshTime?.toIso8601String(),
      'clientId': instance.clientId,
      'scope': instance.scope,
    };

TokenResponseDTO _$TokenResponseDTOFromJson(Map<String, dynamic> json) =>
    TokenResponseDTO(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresIn: json['expires_in'] as int?,
      refreshToken: json['refresh_token'] as String?,
      scope: json['scope'] as String?,
      user: json['user'] == null
          ? null
          : UserDTO.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenResponseDTOToJson(TokenResponseDTO instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
      'scope': instance.scope,
      'user': instance.user?.toJson(),
    };

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      name: json['name'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'name': instance.name,
      'roles': instance.roles,
    };

Addon _$AddonFromJson(Map<String, dynamic> json) => Addon(
      uid: json['uid'] as String?,
      id: json['id'] as String?,
      label: json['label'] as String?,
      version: json['version'] as String?,
      maturity: json['maturity'] as String?,
      compatible: json['compatible'] as bool?,
      contentType: json['contentType'] as String?,
      link: json['link'] as String?,
      author: json['author'] as String?,
      verifiedAuthor: json['verifiedAuthor'] as bool?,
      installed: json['installed'] as bool?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      detailedDescription: json['detailedDescription'] as String?,
      configDescriptionURI: json['configDescriptionURI'] as String?,
      keywords: json['keywords'] as String?,
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      license: json['license'] as String?,
      connection: json['connection'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      imageLink: json['imageLink'] as String?,
      properties: json['properties'] as Map<String, dynamic>?,
      loggerPackages: (json['loggerPackages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$AddonToJson(Addon instance) => <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'label': instance.label,
      'version': instance.version,
      'maturity': instance.maturity,
      'compatible': instance.compatible,
      'contentType': instance.contentType,
      'link': instance.link,
      'author': instance.author,
      'verifiedAuthor': instance.verifiedAuthor,
      'installed': instance.installed,
      'type': instance.type,
      'description': instance.description,
      'detailedDescription': instance.detailedDescription,
      'configDescriptionURI': instance.configDescriptionURI,
      'keywords': instance.keywords,
      'countries': instance.countries,
      'license': instance.license,
      'connection': instance.connection,
      'backgroundColor': instance.backgroundColor,
      'imageLink': instance.imageLink,
      'properties': instance.properties,
      'loggerPackages': instance.loggerPackages,
    };

AddonType _$AddonTypeFromJson(Map<String, dynamic> json) => AddonType(
      id: json['id'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$AddonTypeToJson(AddonType instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
    };

ChannelTypeDTO _$ChannelTypeDTOFromJson(Map<String, dynamic> json) =>
    ChannelTypeDTO(
      parameters: (json['parameters'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      parameterGroups: (json['parameterGroups'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterGroupDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['description'] as String?,
      label: json['label'] as String?,
      category: json['category'] as String?,
      itemType: json['itemType'] as String?,
      kind: json['kind'] as String?,
      stateDescription: json['stateDescription'] == null
          ? null
          : StateDescription.fromJson(
              json['stateDescription'] as Map<String, dynamic>),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      uid: json['UID'] as String?,
      advanced: json['advanced'] as bool?,
      commandDescription: json['commandDescription'] == null
          ? null
          : CommandDescription.fromJson(
              json['commandDescription'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChannelTypeDTOToJson(ChannelTypeDTO instance) =>
    <String, dynamic>{
      'parameters': instance.parameters?.map((e) => e.toJson()).toList(),
      'parameterGroups':
          instance.parameterGroups?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'label': instance.label,
      'category': instance.category,
      'itemType': instance.itemType,
      'kind': instance.kind,
      'stateDescription': instance.stateDescription?.toJson(),
      'tags': instance.tags,
      'UID': instance.uid,
      'advanced': instance.advanced,
      'commandDescription': instance.commandDescription?.toJson(),
    };

CommandDescription _$CommandDescriptionFromJson(Map<String, dynamic> json) =>
    CommandDescription(
      commandOptions: (json['commandOptions'] as List<dynamic>?)
              ?.map((e) => CommandOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CommandDescriptionToJson(CommandDescription instance) =>
    <String, dynamic>{
      'commandOptions':
          instance.commandOptions?.map((e) => e.toJson()).toList(),
    };

CommandOption _$CommandOptionFromJson(Map<String, dynamic> json) =>
    CommandOption(
      command: json['command'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$CommandOptionToJson(CommandOption instance) =>
    <String, dynamic>{
      'command': instance.command,
      'label': instance.label,
    };

ConfigDescriptionParameterGroupDTO _$ConfigDescriptionParameterGroupDTOFromJson(
        Map<String, dynamic> json) =>
    ConfigDescriptionParameterGroupDTO(
      name: json['name'] as String?,
      context: json['context'] as String?,
      advanced: json['advanced'] as bool?,
      label: json['label'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ConfigDescriptionParameterGroupDTOToJson(
        ConfigDescriptionParameterGroupDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'context': instance.context,
      'advanced': instance.advanced,
      'label': instance.label,
      'description': instance.description,
    };

StateDescription _$StateDescriptionFromJson(Map<String, dynamic> json) =>
    StateDescription(
      minimum: (json['minimum'] as num?)?.toDouble(),
      maximum: (json['maximum'] as num?)?.toDouble(),
      step: (json['step'] as num?)?.toDouble(),
      pattern: json['pattern'] as String?,
      readOnly: json['readOnly'] as bool?,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => StateOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$StateDescriptionToJson(StateDescription instance) =>
    <String, dynamic>{
      'minimum': instance.minimum,
      'maximum': instance.maximum,
      'step': instance.step,
      'pattern': instance.pattern,
      'readOnly': instance.readOnly,
      'options': instance.options?.map((e) => e.toJson()).toList(),
    };

StateOption _$StateOptionFromJson(Map<String, dynamic> json) => StateOption(
      value: json['value'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$StateOptionToJson(StateOption instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
    };

ConfigDescriptionDTO _$ConfigDescriptionDTOFromJson(
        Map<String, dynamic> json) =>
    ConfigDescriptionDTO(
      uri: json['uri'] as String?,
      parameters: (json['parameters'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      parameterGroups: (json['parameterGroups'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterGroupDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ConfigDescriptionDTOToJson(
        ConfigDescriptionDTO instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'parameters': instance.parameters?.map((e) => e.toJson()).toList(),
      'parameterGroups':
          instance.parameterGroups?.map((e) => e.toJson()).toList(),
    };

DiscoveryResultDTO _$DiscoveryResultDTOFromJson(Map<String, dynamic> json) =>
    DiscoveryResultDTO(
      bridgeUID: json['bridgeUID'] as String?,
      flag: discoveryResultDTOFlagNullableFromJson(json['flag']),
      label: json['label'] as String?,
      properties: json['properties'] as Map<String, dynamic>?,
      representationProperty: json['representationProperty'] as String?,
      thingUID: json['thingUID'] as String?,
      thingTypeUID: json['thingTypeUID'] as String?,
    );

Map<String, dynamic> _$DiscoveryResultDTOToJson(DiscoveryResultDTO instance) =>
    <String, dynamic>{
      'bridgeUID': instance.bridgeUID,
      'flag': discoveryResultDTOFlagNullableToJson(instance.flag),
      'label': instance.label,
      'properties': instance.properties,
      'representationProperty': instance.representationProperty,
      'thingUID': instance.thingUID,
      'thingTypeUID': instance.thingTypeUID,
    };

MetadataDTO _$MetadataDTOFromJson(Map<String, dynamic> json) => MetadataDTO(
      value: json['value'] as String?,
      config: json['config'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MetadataDTOToJson(MetadataDTO instance) =>
    <String, dynamic>{
      'value': instance.value,
      'config': instance.config,
    };

EnrichedItemDTO _$EnrichedItemDTOFromJson(Map<String, dynamic> json) =>
    EnrichedItemDTO(
      type: json['type'] as String?,
      name: json['name'] as String?,
      label: json['label'] as String?,
      category: json['category'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      groupNames: (json['groupNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      link: json['link'] as String?,
      state: json['state'] as String?,
      transformedState: json['transformedState'] as String?,
      stateDescription: json['stateDescription'] == null
          ? null
          : StateDescription.fromJson(
              json['stateDescription'] as Map<String, dynamic>),
      unitSymbol: json['unitSymbol'] as String?,
      commandDescription: json['commandDescription'] == null
          ? null
          : CommandDescription.fromJson(
              json['commandDescription'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
      editable: json['editable'] as bool?,
    );

Map<String, dynamic> _$EnrichedItemDTOToJson(EnrichedItemDTO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'label': instance.label,
      'category': instance.category,
      'tags': instance.tags,
      'groupNames': instance.groupNames,
      'link': instance.link,
      'state': instance.state,
      'transformedState': instance.transformedState,
      'stateDescription': instance.stateDescription?.toJson(),
      'unitSymbol': instance.unitSymbol,
      'commandDescription': instance.commandDescription?.toJson(),
      'metadata': instance.metadata,
      'editable': instance.editable,
    };

GroupFunctionDTO _$GroupFunctionDTOFromJson(Map<String, dynamic> json) =>
    GroupFunctionDTO(
      name: json['name'] as String?,
      params: (json['params'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$GroupFunctionDTOToJson(GroupFunctionDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'params': instance.params,
    };

GroupItemDTO _$GroupItemDTOFromJson(Map<String, dynamic> json) => GroupItemDTO(
      type: json['type'] as String?,
      name: json['name'] as String?,
      label: json['label'] as String?,
      category: json['category'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      groupNames: (json['groupNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      groupType: json['groupType'] as String?,
      function: json['function'] == null
          ? null
          : GroupFunctionDTO.fromJson(json['function'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupItemDTOToJson(GroupItemDTO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'label': instance.label,
      'category': instance.category,
      'tags': instance.tags,
      'groupNames': instance.groupNames,
      'groupType': instance.groupType,
      'function': instance.function?.toJson(),
    };

EnrichedItemChannelLinkDTO _$EnrichedItemChannelLinkDTOFromJson(
        Map<String, dynamic> json) =>
    EnrichedItemChannelLinkDTO(
      itemName: json['itemName'] as String?,
      channelUID: json['channelUID'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      editable: json['editable'] as bool?,
    );

Map<String, dynamic> _$EnrichedItemChannelLinkDTOToJson(
        EnrichedItemChannelLinkDTO instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'channelUID': instance.channelUID,
      'configuration': instance.configuration,
      'editable': instance.editable,
    };

ItemChannelLinkDTO _$ItemChannelLinkDTOFromJson(Map<String, dynamic> json) =>
    ItemChannelLinkDTO(
      itemName: json['itemName'] as String?,
      channelUID: json['channelUID'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ItemChannelLinkDTOToJson(ItemChannelLinkDTO instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'channelUID': instance.channelUID,
      'configuration': instance.configuration,
    };

HistoryDataBean _$HistoryDataBeanFromJson(Map<String, dynamic> json) =>
    HistoryDataBean(
      time: json['time'] as int?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$HistoryDataBeanToJson(HistoryDataBean instance) =>
    <String, dynamic>{
      'time': instance.time,
      'state': instance.state,
    };

ItemHistoryDTO _$ItemHistoryDTOFromJson(Map<String, dynamic> json) =>
    ItemHistoryDTO(
      name: json['name'] as String?,
      totalrecords: json['totalrecords'] as String?,
      datapoints: json['datapoints'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => HistoryDataBean.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ItemHistoryDTOToJson(ItemHistoryDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'totalrecords': instance.totalrecords,
      'datapoints': instance.datapoints,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

PersistenceCronStrategyDTO _$PersistenceCronStrategyDTOFromJson(
        Map<String, dynamic> json) =>
    PersistenceCronStrategyDTO(
      name: json['name'] as String?,
      cronExpression: json['cronExpression'] as String?,
    );

Map<String, dynamic> _$PersistenceCronStrategyDTOToJson(
        PersistenceCronStrategyDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cronExpression': instance.cronExpression,
    };

PersistenceFilterDTO _$PersistenceFilterDTOFromJson(
        Map<String, dynamic> json) =>
    PersistenceFilterDTO(
      name: json['name'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      relative: json['relative'] as bool?,
      unit: json['unit'] as String?,
      lower: (json['lower'] as num?)?.toDouble(),
      upper: (json['upper'] as num?)?.toDouble(),
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      inverted: json['inverted'] as bool?,
    );

Map<String, dynamic> _$PersistenceFilterDTOToJson(
        PersistenceFilterDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'relative': instance.relative,
      'unit': instance.unit,
      'lower': instance.lower,
      'upper': instance.upper,
      'values': instance.values,
      'inverted': instance.inverted,
    };

PersistenceItemConfigurationDTO _$PersistenceItemConfigurationDTOFromJson(
        Map<String, dynamic> json) =>
    PersistenceItemConfigurationDTO(
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      strategies: (json['strategies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      filters: (json['filters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      alias: json['alias'] as String?,
    );

Map<String, dynamic> _$PersistenceItemConfigurationDTOToJson(
        PersistenceItemConfigurationDTO instance) =>
    <String, dynamic>{
      'items': instance.items,
      'strategies': instance.strategies,
      'filters': instance.filters,
      'alias': instance.alias,
    };

PersistenceServiceConfigurationDTO _$PersistenceServiceConfigurationDTOFromJson(
        Map<String, dynamic> json) =>
    PersistenceServiceConfigurationDTO(
      serviceId: json['serviceId'] as String?,
      configs: (json['configs'] as List<dynamic>?)
              ?.map((e) => PersistenceItemConfigurationDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      defaults: (json['defaults'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      cronStrategies: (json['cronStrategies'] as List<dynamic>?)
              ?.map((e) => PersistenceCronStrategyDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      thresholdFilters: (json['thresholdFilters'] as List<dynamic>?)
              ?.map((e) =>
                  PersistenceFilterDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      timeFilters: (json['timeFilters'] as List<dynamic>?)
              ?.map((e) =>
                  PersistenceFilterDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      equalsFilters: (json['equalsFilters'] as List<dynamic>?)
              ?.map((e) =>
                  PersistenceFilterDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      includeFilters: (json['includeFilters'] as List<dynamic>?)
              ?.map((e) =>
                  PersistenceFilterDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      editable: json['editable'] as bool?,
    );

Map<String, dynamic> _$PersistenceServiceConfigurationDTOToJson(
        PersistenceServiceConfigurationDTO instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'configs': instance.configs?.map((e) => e.toJson()).toList(),
      'defaults': instance.defaults,
      'cronStrategies':
          instance.cronStrategies?.map((e) => e.toJson()).toList(),
      'thresholdFilters':
          instance.thresholdFilters?.map((e) => e.toJson()).toList(),
      'timeFilters': instance.timeFilters?.map((e) => e.toJson()).toList(),
      'equalsFilters': instance.equalsFilters?.map((e) => e.toJson()).toList(),
      'includeFilters':
          instance.includeFilters?.map((e) => e.toJson()).toList(),
      'editable': instance.editable,
    };

PersistenceItemInfo _$PersistenceItemInfoFromJson(Map<String, dynamic> json) =>
    PersistenceItemInfo(
      earliest: json['earliest'] == null
          ? null
          : DateTime.parse(json['earliest'] as String),
      latest: json['latest'] == null
          ? null
          : DateTime.parse(json['latest'] as String),
      count: json['count'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PersistenceItemInfoToJson(
        PersistenceItemInfo instance) =>
    <String, dynamic>{
      'earliest': instance.earliest?.toIso8601String(),
      'latest': instance.latest?.toIso8601String(),
      'count': instance.count,
      'name': instance.name,
    };

PersistenceServiceDTO _$PersistenceServiceDTOFromJson(
        Map<String, dynamic> json) =>
    PersistenceServiceDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PersistenceServiceDTOToJson(
        PersistenceServiceDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': instance.type,
    };

ProfileTypeDTO _$ProfileTypeDTOFromJson(Map<String, dynamic> json) =>
    ProfileTypeDTO(
      uid: json['uid'] as String?,
      label: json['label'] as String?,
      kind: json['kind'] as String?,
      supportedItemTypes: (json['supportedItemTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProfileTypeDTOToJson(ProfileTypeDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'label': instance.label,
      'kind': instance.kind,
      'supportedItemTypes': instance.supportedItemTypes,
    };

ConfigurableServiceDTO _$ConfigurableServiceDTOFromJson(
        Map<String, dynamic> json) =>
    ConfigurableServiceDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
      category: json['category'] as String?,
      configDescriptionURI: json['configDescriptionURI'] as String?,
      multiple: json['multiple'] as bool?,
    );

Map<String, dynamic> _$ConfigurableServiceDTOToJson(
        ConfigurableServiceDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'category': instance.category,
      'configDescriptionURI': instance.configDescriptionURI,
      'multiple': instance.multiple,
    };

EnrichedSemanticTagDTO _$EnrichedSemanticTagDTOFromJson(
        Map<String, dynamic> json) =>
    EnrichedSemanticTagDTO();

Map<String, dynamic> _$EnrichedSemanticTagDTOToJson(
        EnrichedSemanticTagDTO instance) =>
    <String, dynamic>{};

EnrichedChannelDTO _$EnrichedChannelDTOFromJson(Map<String, dynamic> json) =>
    EnrichedChannelDTO(
      uid: json['uid'] as String?,
      id: json['id'] as String?,
      channelTypeUID: json['channelTypeUID'] as String?,
      itemType: json['itemType'] as String?,
      kind: json['kind'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      defaultTags: (json['defaultTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      properties: json['properties'] as Map<String, dynamic>?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      autoUpdatePolicy: json['autoUpdatePolicy'] as String?,
      linkedItems: (json['linkedItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$EnrichedChannelDTOToJson(EnrichedChannelDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'channelTypeUID': instance.channelTypeUID,
      'itemType': instance.itemType,
      'kind': instance.kind,
      'label': instance.label,
      'description': instance.description,
      'defaultTags': instance.defaultTags,
      'properties': instance.properties,
      'configuration': instance.configuration,
      'autoUpdatePolicy': instance.autoUpdatePolicy,
      'linkedItems': instance.linkedItems,
    };

EnrichedThingDTO _$EnrichedThingDTOFromJson(Map<String, dynamic> json) =>
    EnrichedThingDTO(
      label: json['label'] as String?,
      bridgeUID: json['bridgeUID'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      properties: json['properties'] as Map<String, dynamic>?,
      uid: json['UID'] as String?,
      thingTypeUID: json['thingTypeUID'] as String?,
      location: json['location'] as String?,
      channels: (json['channels'] as List<dynamic>?)
              ?.map(
                  (e) => EnrichedChannelDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      statusInfo: json['statusInfo'] == null
          ? null
          : ThingStatusInfo.fromJson(
              json['statusInfo'] as Map<String, dynamic>),
      firmwareStatus: json['firmwareStatus'] == null
          ? null
          : FirmwareStatusDTO.fromJson(
              json['firmwareStatus'] as Map<String, dynamic>),
      editable: json['editable'] as bool?,
    );

Map<String, dynamic> _$EnrichedThingDTOToJson(EnrichedThingDTO instance) =>
    <String, dynamic>{
      'label': instance.label,
      'bridgeUID': instance.bridgeUID,
      'configuration': instance.configuration,
      'properties': instance.properties,
      'UID': instance.uid,
      'thingTypeUID': instance.thingTypeUID,
      'location': instance.location,
      'channels': instance.channels?.map((e) => e.toJson()).toList(),
      'statusInfo': instance.statusInfo?.toJson(),
      'firmwareStatus': instance.firmwareStatus?.toJson(),
      'editable': instance.editable,
    };

FirmwareStatusDTO _$FirmwareStatusDTOFromJson(Map<String, dynamic> json) =>
    FirmwareStatusDTO(
      status: json['status'] as String?,
      updatableVersion: json['updatableVersion'] as String?,
    );

Map<String, dynamic> _$FirmwareStatusDTOToJson(FirmwareStatusDTO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'updatableVersion': instance.updatableVersion,
    };

ThingStatusInfo _$ThingStatusInfoFromJson(Map<String, dynamic> json) =>
    ThingStatusInfo(
      status: thingStatusInfoStatusNullableFromJson(json['status']),
      statusDetail:
          thingStatusInfoStatusDetailNullableFromJson(json['statusDetail']),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ThingStatusInfoToJson(ThingStatusInfo instance) =>
    <String, dynamic>{
      'status': thingStatusInfoStatusNullableToJson(instance.status),
      'statusDetail':
          thingStatusInfoStatusDetailNullableToJson(instance.statusDetail),
      'description': instance.description,
    };

ChannelDTO _$ChannelDTOFromJson(Map<String, dynamic> json) => ChannelDTO(
      uid: json['uid'] as String?,
      id: json['id'] as String?,
      channelTypeUID: json['channelTypeUID'] as String?,
      itemType: json['itemType'] as String?,
      kind: json['kind'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      defaultTags: (json['defaultTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      properties: json['properties'] as Map<String, dynamic>?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      autoUpdatePolicy: json['autoUpdatePolicy'] as String?,
    );

Map<String, dynamic> _$ChannelDTOToJson(ChannelDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'channelTypeUID': instance.channelTypeUID,
      'itemType': instance.itemType,
      'kind': instance.kind,
      'label': instance.label,
      'description': instance.description,
      'defaultTags': instance.defaultTags,
      'properties': instance.properties,
      'configuration': instance.configuration,
      'autoUpdatePolicy': instance.autoUpdatePolicy,
    };

ThingDTO _$ThingDTOFromJson(Map<String, dynamic> json) => ThingDTO(
      label: json['label'] as String?,
      bridgeUID: json['bridgeUID'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      properties: json['properties'] as Map<String, dynamic>?,
      uid: json['UID'] as String?,
      thingTypeUID: json['thingTypeUID'] as String?,
      location: json['location'] as String?,
      channels: (json['channels'] as List<dynamic>?)
              ?.map((e) => ChannelDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ThingDTOToJson(ThingDTO instance) => <String, dynamic>{
      'label': instance.label,
      'bridgeUID': instance.bridgeUID,
      'configuration': instance.configuration,
      'properties': instance.properties,
      'UID': instance.uid,
      'thingTypeUID': instance.thingTypeUID,
      'location': instance.location,
      'channels': instance.channels?.map((e) => e.toJson()).toList(),
    };

ConfigStatusMessage _$ConfigStatusMessageFromJson(Map<String, dynamic> json) =>
    ConfigStatusMessage(
      parameterName: json['parameterName'] as String?,
      type: configStatusMessageTypeNullableFromJson(json['type']),
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$ConfigStatusMessageToJson(
        ConfigStatusMessage instance) =>
    <String, dynamic>{
      'parameterName': instance.parameterName,
      'type': configStatusMessageTypeNullableToJson(instance.type),
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

FirmwareDTO _$FirmwareDTOFromJson(Map<String, dynamic> json) => FirmwareDTO(
      thingTypeUID: json['thingTypeUID'] as String?,
      vendor: json['vendor'] as String?,
      model: json['model'] as String?,
      modelRestricted: json['modelRestricted'] as bool?,
      description: json['description'] as String?,
      version: json['version'] as String?,
      changelog: json['changelog'] as String?,
      prerequisiteVersion: json['prerequisiteVersion'] as String?,
    );

Map<String, dynamic> _$FirmwareDTOToJson(FirmwareDTO instance) =>
    <String, dynamic>{
      'thingTypeUID': instance.thingTypeUID,
      'vendor': instance.vendor,
      'model': instance.model,
      'modelRestricted': instance.modelRestricted,
      'description': instance.description,
      'version': instance.version,
      'changelog': instance.changelog,
      'prerequisiteVersion': instance.prerequisiteVersion,
    };

StrippedThingTypeDTO _$StrippedThingTypeDTOFromJson(
        Map<String, dynamic> json) =>
    StrippedThingTypeDTO(
      uid: json['UID'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      listed: json['listed'] as bool?,
      supportedBridgeTypeUIDs:
          (json['supportedBridgeTypeUIDs'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      bridge: json['bridge'] as bool?,
    );

Map<String, dynamic> _$StrippedThingTypeDTOToJson(
        StrippedThingTypeDTO instance) =>
    <String, dynamic>{
      'UID': instance.uid,
      'label': instance.label,
      'description': instance.description,
      'category': instance.category,
      'listed': instance.listed,
      'supportedBridgeTypeUIDs': instance.supportedBridgeTypeUIDs,
      'bridge': instance.bridge,
    };

ChannelDefinitionDTO _$ChannelDefinitionDTOFromJson(
        Map<String, dynamic> json) =>
    ChannelDefinitionDTO(
      description: json['description'] as String?,
      id: json['id'] as String?,
      label: json['label'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      properties: json['properties'] as Map<String, dynamic>?,
      category: json['category'] as String?,
      stateDescription: json['stateDescription'] == null
          ? null
          : StateDescription.fromJson(
              json['stateDescription'] as Map<String, dynamic>),
      advanced: json['advanced'] as bool?,
      typeUID: json['typeUID'] as String?,
    );

Map<String, dynamic> _$ChannelDefinitionDTOToJson(
        ChannelDefinitionDTO instance) =>
    <String, dynamic>{
      'description': instance.description,
      'id': instance.id,
      'label': instance.label,
      'tags': instance.tags,
      'properties': instance.properties,
      'category': instance.category,
      'stateDescription': instance.stateDescription?.toJson(),
      'advanced': instance.advanced,
      'typeUID': instance.typeUID,
    };

ChannelGroupDefinitionDTO _$ChannelGroupDefinitionDTOFromJson(
        Map<String, dynamic> json) =>
    ChannelGroupDefinitionDTO(
      id: json['id'] as String?,
      description: json['description'] as String?,
      label: json['label'] as String?,
      channels: (json['channels'] as List<dynamic>?)
              ?.map((e) =>
                  ChannelDefinitionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ChannelGroupDefinitionDTOToJson(
        ChannelGroupDefinitionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'label': instance.label,
      'channels': instance.channels?.map((e) => e.toJson()).toList(),
    };

ThingTypeDTO _$ThingTypeDTOFromJson(Map<String, dynamic> json) => ThingTypeDTO(
      uid: json['UID'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      listed: json['listed'] as bool?,
      supportedBridgeTypeUIDs:
          (json['supportedBridgeTypeUIDs'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      bridge: json['bridge'] as bool?,
      channels: (json['channels'] as List<dynamic>?)
              ?.map((e) =>
                  ChannelDefinitionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      channelGroups: (json['channelGroups'] as List<dynamic>?)
              ?.map((e) =>
                  ChannelGroupDefinitionDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      configParameters: (json['configParameters'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      parameterGroups: (json['parameterGroups'] as List<dynamic>?)
              ?.map((e) => ConfigDescriptionParameterGroupDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      properties: json['properties'] as Map<String, dynamic>?,
      extensibleChannelTypeIds:
          (json['extensibleChannelTypeIds'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
    );

Map<String, dynamic> _$ThingTypeDTOToJson(ThingTypeDTO instance) =>
    <String, dynamic>{
      'UID': instance.uid,
      'label': instance.label,
      'description': instance.description,
      'category': instance.category,
      'listed': instance.listed,
      'supportedBridgeTypeUIDs': instance.supportedBridgeTypeUIDs,
      'bridge': instance.bridge,
      'channels': instance.channels?.map((e) => e.toJson()).toList(),
      'channelGroups': instance.channelGroups?.map((e) => e.toJson()).toList(),
      'configParameters':
          instance.configParameters?.map((e) => e.toJson()).toList(),
      'parameterGroups':
          instance.parameterGroups?.map((e) => e.toJson()).toList(),
      'properties': instance.properties,
      'extensibleChannelTypeIds': instance.extensibleChannelTypeIds,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
    };

RootBean _$RootBeanFromJson(Map<String, dynamic> json) => RootBean(
      version: json['version'] as String?,
      locale: json['locale'] as String?,
      measurementSystem: json['measurementSystem'] as String?,
      runtimeInfo: json['runtimeInfo'] == null
          ? null
          : RuntimeInfo.fromJson(json['runtimeInfo'] as Map<String, dynamic>),
      links: (json['links'] as List<dynamic>?)
              ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RootBeanToJson(RootBean instance) => <String, dynamic>{
      'version': instance.version,
      'locale': instance.locale,
      'measurementSystem': instance.measurementSystem,
      'runtimeInfo': instance.runtimeInfo?.toJson(),
      'links': instance.links?.map((e) => e.toJson()).toList(),
    };

RuntimeInfo _$RuntimeInfoFromJson(Map<String, dynamic> json) => RuntimeInfo(
      version: json['version'] as String?,
      buildString: json['buildString'] as String?,
    );

Map<String, dynamic> _$RuntimeInfoToJson(RuntimeInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
      'buildString': instance.buildString,
    };

SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) => SystemInfo(
      configFolder: json['configFolder'] as String?,
      userdataFolder: json['userdataFolder'] as String?,
      logFolder: json['logFolder'] as String?,
      javaVersion: json['javaVersion'] as String?,
      javaVendor: json['javaVendor'] as String?,
      javaVendorVersion: json['javaVendorVersion'] as String?,
      osName: json['osName'] as String?,
      osVersion: json['osVersion'] as String?,
      osArchitecture: json['osArchitecture'] as String?,
      availableProcessors: json['availableProcessors'] as int?,
      freeMemory: json['freeMemory'] as int?,
      totalMemory: json['totalMemory'] as int?,
      startLevel: json['startLevel'] as int?,
    );

Map<String, dynamic> _$SystemInfoToJson(SystemInfo instance) =>
    <String, dynamic>{
      'configFolder': instance.configFolder,
      'userdataFolder': instance.userdataFolder,
      'logFolder': instance.logFolder,
      'javaVersion': instance.javaVersion,
      'javaVendor': instance.javaVendor,
      'javaVendorVersion': instance.javaVendorVersion,
      'osName': instance.osName,
      'osVersion': instance.osVersion,
      'osArchitecture': instance.osArchitecture,
      'availableProcessors': instance.availableProcessors,
      'freeMemory': instance.freeMemory,
      'totalMemory': instance.totalMemory,
      'startLevel': instance.startLevel,
    };

SystemInfoBean _$SystemInfoBeanFromJson(Map<String, dynamic> json) =>
    SystemInfoBean(
      systemInfo: json['systemInfo'] == null
          ? null
          : SystemInfo.fromJson(json['systemInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SystemInfoBeanToJson(SystemInfoBean instance) =>
    <String, dynamic>{
      'systemInfo': instance.systemInfo?.toJson(),
    };

DimensionInfo _$DimensionInfoFromJson(Map<String, dynamic> json) =>
    DimensionInfo(
      dimension: json['dimension'] as String?,
      systemUnit: json['systemUnit'] as String?,
    );

Map<String, dynamic> _$DimensionInfoToJson(DimensionInfo instance) =>
    <String, dynamic>{
      'dimension': instance.dimension,
      'systemUnit': instance.systemUnit,
    };

UoMInfo _$UoMInfoFromJson(Map<String, dynamic> json) => UoMInfo(
      dimensions: (json['dimensions'] as List<dynamic>?)
              ?.map((e) => DimensionInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UoMInfoToJson(UoMInfo instance) => <String, dynamic>{
      'dimensions': instance.dimensions?.map((e) => e.toJson()).toList(),
    };

UoMInfoBean _$UoMInfoBeanFromJson(Map<String, dynamic> json) => UoMInfoBean(
      uomInfo: json['uomInfo'] == null
          ? null
          : UoMInfo.fromJson(json['uomInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UoMInfoBeanToJson(UoMInfoBean instance) =>
    <String, dynamic>{
      'uomInfo': instance.uomInfo?.toJson(),
    };

MappingDTO _$MappingDTOFromJson(Map<String, dynamic> json) => MappingDTO(
      command: json['command'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$MappingDTOToJson(MappingDTO instance) =>
    <String, dynamic>{
      'command': instance.command,
      'label': instance.label,
    };

PageDTO _$PageDTOFromJson(Map<String, dynamic> json) => PageDTO(
      id: json['id'] as String?,
      title: json['title'] as String?,
      icon: json['icon'] as String?,
      link: json['link'] as String?,
      parent: json['parent'] == null
          ? null
          : PageDTO.fromJson(json['parent'] as Map<String, dynamic>),
      leaf: json['leaf'] as bool?,
      timeout: json['timeout'] as bool?,
      widgets: (json['widgets'] as List<dynamic>?)
              ?.map((e) => WidgetDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PageDTOToJson(PageDTO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'link': instance.link,
      'parent': instance.parent?.toJson(),
      'leaf': instance.leaf,
      'timeout': instance.timeout,
      'widgets': instance.widgets?.map((e) => e.toJson()).toList(),
    };

WidgetDTO _$WidgetDTOFromJson(Map<String, dynamic> json) => WidgetDTO(
      widgetId: json['widgetId'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      visibility: json['visibility'] as bool?,
      label: json['label'] as String?,
      icon: json['icon'] as String?,
      labelcolor: json['labelcolor'] as String?,
      valuecolor: json['valuecolor'] as String?,
      iconcolor: json['iconcolor'] as String?,
      pattern: json['pattern'] as String?,
      unit: json['unit'] as String?,
      mappings: (json['mappings'] as List<dynamic>?)
              ?.map((e) => MappingDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      switchSupport: json['switchSupport'] as bool?,
      sendFrequency: json['sendFrequency'] as int?,
      refresh: json['refresh'] as int?,
      height: json['height'] as int?,
      minValue: (json['minValue'] as num?)?.toDouble(),
      maxValue: (json['maxValue'] as num?)?.toDouble(),
      step: (json['step'] as num?)?.toDouble(),
      inputHint: json['inputHint'] as String?,
      url: json['url'] as String?,
      encoding: json['encoding'] as String?,
      service: json['service'] as String?,
      period: json['period'] as String?,
      yAxisDecimalPattern: json['yAxisDecimalPattern'] as String?,
      legend: json['legend'] as bool?,
      forceAsItem: json['forceAsItem'] as bool?,
      state: json['state'] as String?,
      item: json['item'] == null
          ? null
          : EnrichedItemDTO.fromJson(json['item'] as Map<String, dynamic>),
      linkedPage: json['linkedPage'] == null
          ? null
          : PageDTO.fromJson(json['linkedPage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WidgetDTOToJson(WidgetDTO instance) => <String, dynamic>{
      'widgetId': instance.widgetId,
      'type': instance.type,
      'name': instance.name,
      'visibility': instance.visibility,
      'label': instance.label,
      'icon': instance.icon,
      'labelcolor': instance.labelcolor,
      'valuecolor': instance.valuecolor,
      'iconcolor': instance.iconcolor,
      'pattern': instance.pattern,
      'unit': instance.unit,
      'mappings': instance.mappings?.map((e) => e.toJson()).toList(),
      'switchSupport': instance.switchSupport,
      'sendFrequency': instance.sendFrequency,
      'refresh': instance.refresh,
      'height': instance.height,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'step': instance.step,
      'inputHint': instance.inputHint,
      'url': instance.url,
      'encoding': instance.encoding,
      'service': instance.service,
      'period': instance.period,
      'yAxisDecimalPattern': instance.yAxisDecimalPattern,
      'legend': instance.legend,
      'forceAsItem': instance.forceAsItem,
      'state': instance.state,
      'item': instance.item?.toJson(),
      'linkedPage': instance.linkedPage?.toJson(),
    };

SitemapDTO _$SitemapDTOFromJson(Map<String, dynamic> json) => SitemapDTO(
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      label: json['label'] as String?,
      link: json['link'] as String?,
      homepage: json['homepage'] == null
          ? null
          : PageDTO.fromJson(json['homepage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SitemapDTOToJson(SitemapDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'icon': instance.icon,
      'label': instance.label,
      'link': instance.link,
      'homepage': instance.homepage?.toJson(),
    };

Transformation _$TransformationFromJson(Map<String, dynamic> json) =>
    Transformation(
      uid: json['uid'] as String?,
      label: json['label'] as String?,
      type: json['type'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$TransformationToJson(Transformation instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'label': instance.label,
      'type': instance.type,
      'configuration': instance.configuration,
    };

TransformationDTO _$TransformationDTOFromJson(Map<String, dynamic> json) =>
    TransformationDTO(
      uid: json['uid'] as String?,
      label: json['label'] as String?,
      type: json['type'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>?,
      editable: json['editable'] as bool?,
    );

Map<String, dynamic> _$TransformationDTOToJson(TransformationDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'label': instance.label,
      'type': instance.type,
      'configuration': instance.configuration,
      'editable': instance.editable,
    };

RootUIComponent _$RootUIComponentFromJson(Map<String, dynamic> json) =>
    RootUIComponent(
      component: json['component'] as String?,
      config: json['config'] as Map<String, dynamic>?,
      slots: json['slots'] as Map<String, dynamic>?,
      uid: json['uid'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      props: json['props'] == null
          ? null
          : ConfigDescriptionDTO.fromJson(
              json['props'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$RootUIComponentToJson(RootUIComponent instance) =>
    <String, dynamic>{
      'component': instance.component,
      'config': instance.config,
      'slots': instance.slots,
      'uid': instance.uid,
      'tags': instance.tags,
      'props': instance.props?.toJson(),
      'timestamp': instance.timestamp?.toIso8601String(),
      'type': instance.type,
    };

UIComponent _$UIComponentFromJson(Map<String, dynamic> json) => UIComponent(
      component: json['component'] as String?,
      config: json['config'] as Map<String, dynamic>?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UIComponentToJson(UIComponent instance) =>
    <String, dynamic>{
      'component': instance.component,
      'config': instance.config,
      'type': instance.type,
    };

TileDTO _$TileDTOFromJson(Map<String, dynamic> json) => TileDTO(
      name: json['name'] as String?,
      url: json['url'] as String?,
      overlay: json['overlay'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$TileDTOToJson(TileDTO instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'overlay': instance.overlay,
      'imageUrl': instance.imageUrl,
    };

VoiceDTO _$VoiceDTOFromJson(Map<String, dynamic> json) => VoiceDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$VoiceDTOToJson(VoiceDTO instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'locale': instance.locale,
    };

HumanLanguageInterpreterDTO _$HumanLanguageInterpreterDTOFromJson(
        Map<String, dynamic> json) =>
    HumanLanguageInterpreterDTO(
      id: json['id'] as String?,
      label: json['label'] as String?,
      locales: (json['locales'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$HumanLanguageInterpreterDTOToJson(
        HumanLanguageInterpreterDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'locales': instance.locales,
    };

LoggerInfo _$LoggerInfoFromJson(Map<String, dynamic> json) => LoggerInfo(
      loggerName: json['loggerName'] as String?,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$LoggerInfoToJson(LoggerInfo instance) =>
    <String, dynamic>{
      'loggerName': instance.loggerName,
      'level': instance.level,
    };

LoggerBean _$LoggerBeanFromJson(Map<String, dynamic> json) => LoggerBean(
      loggers: (json['loggers'] as List<dynamic>?)
              ?.map((e) => LoggerInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LoggerBeanToJson(LoggerBean instance) =>
    <String, dynamic>{
      'loggers': instance.loggers?.map((e) => e.toJson()).toList(),
    };

IconSet _$IconSetFromJson(Map<String, dynamic> json) => IconSet(
      id: json['id'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      formats: iconSetFormatsListFromJson(json['formats'] as List?),
    );

Map<String, dynamic> _$IconSetToJson(IconSet instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'formats': iconSetFormatsListToJson(instance.formats),
    };

GalleryWidgetsListItem _$GalleryWidgetsListItemFromJson(
        Map<String, dynamic> json) =>
    GalleryWidgetsListItem(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      likes: json['likes'] as int?,
      views: json['views'] as int?,
      posts: json['posts'] as int?,
      imageUrl: json['imageUrl'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$GalleryWidgetsListItemToJson(
        GalleryWidgetsListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'likes': instance.likes,
      'views': instance.views,
      'posts': instance.posts,
      'imageUrl': instance.imageUrl,
      'createdDate': instance.createdDate?.toIso8601String(),
    };

GalleryItem _$GalleryItemFromJson(Map<String, dynamic> json) => GalleryItem(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      likes: json['likes'] as int?,
      views: json['views'] as int?,
      posts: json['posts'] as int?,
      imageUrl: json['imageUrl'] as String?,
      author: json['author'] as String?,
      authorName: json['authorName'] as String?,
      authorAvatarUrl: json['authorAvatarUrl'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      readme: json['readme'] as String?,
    );

Map<String, dynamic> _$GalleryItemToJson(GalleryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'likes': instance.likes,
      'views': instance.views,
      'posts': instance.posts,
      'imageUrl': instance.imageUrl,
      'author': instance.author,
      'authorName': instance.authorName,
      'authorAvatarUrl': instance.authorAvatarUrl,
      'createdDate': instance.createdDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'readme': instance.readme,
    };

AuthLogoutPost$RequestBody _$AuthLogoutPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    AuthLogoutPost$RequestBody(
      refreshToken: json['refresh_token'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AuthLogoutPost$RequestBodyToJson(
        AuthLogoutPost$RequestBody instance) =>
    <String, dynamic>{
      'refresh_token': instance.refreshToken,
      'id': instance.id,
    };

AuthTokenPost$RequestBody _$AuthTokenPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    AuthTokenPost$RequestBody(
      grantType: json['grant_type'] as String?,
      code: json['code'] as String?,
      redirectUri: json['redirect_uri'] as String?,
      clientId: json['client_id'] as String?,
      refreshToken: json['refresh_token'] as String?,
      codeVerifier: json['code_verifier'] as String?,
    );

Map<String, dynamic> _$AuthTokenPost$RequestBodyToJson(
        AuthTokenPost$RequestBody instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'code': instance.code,
      'redirect_uri': instance.redirectUri,
      'client_id': instance.clientId,
      'refresh_token': instance.refreshToken,
      'code_verifier': instance.codeVerifier,
    };
