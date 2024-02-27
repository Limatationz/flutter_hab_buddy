// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'openHAB.enums.swagger.dart' as enums;

part 'openHAB.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfigDescriptionParameterDTO {
  const ConfigDescriptionParameterDTO({
    this.context,
    this.defaultValue,
    this.description,
    this.label,
    this.name,
    this.required,
    this.type,
    this.min,
    this.max,
    this.stepsize,
    this.pattern,
    this.readOnly,
    this.multiple,
    this.multipleLimit,
    this.groupName,
    this.advanced,
    this.verify,
    this.limitToOptions,
    this.unit,
    this.unitLabel,
    this.options,
    this.filterCriteria,
  });

  factory ConfigDescriptionParameterDTO.fromJson(Map<String, dynamic> json) =>
      _$ConfigDescriptionParameterDTOFromJson(json);

  static const toJsonFactory = _$ConfigDescriptionParameterDTOToJson;
  Map<String, dynamic> toJson() => _$ConfigDescriptionParameterDTOToJson(this);

  @JsonKey(name: 'context')
  final String? context;
  @JsonKey(name: 'defaultValue')
  final String? defaultValue;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'required')
  final bool? required;
  @JsonKey(
    name: 'type',
    toJson: configDescriptionParameterDTOTypeNullableToJson,
    fromJson: configDescriptionParameterDTOTypeNullableFromJson,
  )
  final enums.ConfigDescriptionParameterDTOType? type;
  @JsonKey(name: 'min')
  final double? min;
  @JsonKey(name: 'max')
  final double? max;
  @JsonKey(name: 'stepsize')
  final double? stepsize;
  @JsonKey(name: 'pattern')
  final String? pattern;
  @JsonKey(name: 'readOnly')
  final bool? readOnly;
  @JsonKey(name: 'multiple')
  final bool? multiple;
  @JsonKey(name: 'multipleLimit')
  final int? multipleLimit;
  @JsonKey(name: 'groupName')
  final String? groupName;
  @JsonKey(name: 'advanced')
  final bool? advanced;
  @JsonKey(name: 'verify')
  final bool? verify;
  @JsonKey(name: 'limitToOptions')
  final bool? limitToOptions;
  @JsonKey(name: 'unit')
  final String? unit;
  @JsonKey(name: 'unitLabel')
  final String? unitLabel;
  @JsonKey(name: 'options', defaultValue: <ParameterOptionDTO>[])
  final List<ParameterOptionDTO>? options;
  @JsonKey(name: 'filterCriteria', defaultValue: <FilterCriteriaDTO>[])
  final List<FilterCriteriaDTO>? filterCriteria;
  static const fromJsonFactory = _$ConfigDescriptionParameterDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ConfigDescriptionParameterDTO &&
            (identical(other.context, context) ||
                const DeepCollectionEquality()
                    .equals(other.context, context)) &&
            (identical(other.defaultValue, defaultValue) ||
                const DeepCollectionEquality()
                    .equals(other.defaultValue, defaultValue)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.required, required) ||
                const DeepCollectionEquality()
                    .equals(other.required, required)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.min, min) ||
                const DeepCollectionEquality().equals(other.min, min)) &&
            (identical(other.max, max) ||
                const DeepCollectionEquality().equals(other.max, max)) &&
            (identical(other.stepsize, stepsize) ||
                const DeepCollectionEquality()
                    .equals(other.stepsize, stepsize)) &&
            (identical(other.pattern, pattern) ||
                const DeepCollectionEquality()
                    .equals(other.pattern, pattern)) &&
            (identical(other.readOnly, readOnly) ||
                const DeepCollectionEquality()
                    .equals(other.readOnly, readOnly)) &&
            (identical(other.multiple, multiple) ||
                const DeepCollectionEquality()
                    .equals(other.multiple, multiple)) &&
            (identical(other.multipleLimit, multipleLimit) ||
                const DeepCollectionEquality()
                    .equals(other.multipleLimit, multipleLimit)) &&
            (identical(other.groupName, groupName) ||
                const DeepCollectionEquality()
                    .equals(other.groupName, groupName)) &&
            (identical(other.advanced, advanced) ||
                const DeepCollectionEquality()
                    .equals(other.advanced, advanced)) &&
            (identical(other.verify, verify) ||
                const DeepCollectionEquality().equals(other.verify, verify)) &&
            (identical(other.limitToOptions, limitToOptions) ||
                const DeepCollectionEquality()
                    .equals(other.limitToOptions, limitToOptions)) &&
            (identical(other.unit, unit) ||
                const DeepCollectionEquality().equals(other.unit, unit)) &&
            (identical(other.unitLabel, unitLabel) ||
                const DeepCollectionEquality()
                    .equals(other.unitLabel, unitLabel)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality()
                    .equals(other.options, options)) &&
            (identical(other.filterCriteria, filterCriteria) ||
                const DeepCollectionEquality()
                    .equals(other.filterCriteria, filterCriteria)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(context) ^
      const DeepCollectionEquality().hash(defaultValue) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(required) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(min) ^
      const DeepCollectionEquality().hash(max) ^
      const DeepCollectionEquality().hash(stepsize) ^
      const DeepCollectionEquality().hash(pattern) ^
      const DeepCollectionEquality().hash(readOnly) ^
      const DeepCollectionEquality().hash(multiple) ^
      const DeepCollectionEquality().hash(multipleLimit) ^
      const DeepCollectionEquality().hash(groupName) ^
      const DeepCollectionEquality().hash(advanced) ^
      const DeepCollectionEquality().hash(verify) ^
      const DeepCollectionEquality().hash(limitToOptions) ^
      const DeepCollectionEquality().hash(unit) ^
      const DeepCollectionEquality().hash(unitLabel) ^
      const DeepCollectionEquality().hash(options) ^
      const DeepCollectionEquality().hash(filterCriteria) ^
      runtimeType.hashCode;
}

extension $ConfigDescriptionParameterDTOExtension
    on ConfigDescriptionParameterDTO {
  ConfigDescriptionParameterDTO copyWith(
      {String? context,
      String? defaultValue,
      String? description,
      String? label,
      String? name,
      bool? required,
      enums.ConfigDescriptionParameterDTOType? type,
      double? min,
      double? max,
      double? stepsize,
      String? pattern,
      bool? readOnly,
      bool? multiple,
      int? multipleLimit,
      String? groupName,
      bool? advanced,
      bool? verify,
      bool? limitToOptions,
      String? unit,
      String? unitLabel,
      List<ParameterOptionDTO>? options,
      List<FilterCriteriaDTO>? filterCriteria}) {
    return ConfigDescriptionParameterDTO(
        context: context ?? this.context,
        defaultValue: defaultValue ?? this.defaultValue,
        description: description ?? this.description,
        label: label ?? this.label,
        name: name ?? this.name,
        required: required ?? this.required,
        type: type ?? this.type,
        min: min ?? this.min,
        max: max ?? this.max,
        stepsize: stepsize ?? this.stepsize,
        pattern: pattern ?? this.pattern,
        readOnly: readOnly ?? this.readOnly,
        multiple: multiple ?? this.multiple,
        multipleLimit: multipleLimit ?? this.multipleLimit,
        groupName: groupName ?? this.groupName,
        advanced: advanced ?? this.advanced,
        verify: verify ?? this.verify,
        limitToOptions: limitToOptions ?? this.limitToOptions,
        unit: unit ?? this.unit,
        unitLabel: unitLabel ?? this.unitLabel,
        options: options ?? this.options,
        filterCriteria: filterCriteria ?? this.filterCriteria);
  }

  ConfigDescriptionParameterDTO copyWithWrapped(
      {Wrapped<String?>? context,
      Wrapped<String?>? defaultValue,
      Wrapped<String?>? description,
      Wrapped<String?>? label,
      Wrapped<String?>? name,
      Wrapped<bool?>? required,
      Wrapped<enums.ConfigDescriptionParameterDTOType?>? type,
      Wrapped<double?>? min,
      Wrapped<double?>? max,
      Wrapped<double?>? stepsize,
      Wrapped<String?>? pattern,
      Wrapped<bool?>? readOnly,
      Wrapped<bool?>? multiple,
      Wrapped<int?>? multipleLimit,
      Wrapped<String?>? groupName,
      Wrapped<bool?>? advanced,
      Wrapped<bool?>? verify,
      Wrapped<bool?>? limitToOptions,
      Wrapped<String?>? unit,
      Wrapped<String?>? unitLabel,
      Wrapped<List<ParameterOptionDTO>?>? options,
      Wrapped<List<FilterCriteriaDTO>?>? filterCriteria}) {
    return ConfigDescriptionParameterDTO(
        context: (context != null ? context.value : this.context),
        defaultValue:
            (defaultValue != null ? defaultValue.value : this.defaultValue),
        description:
            (description != null ? description.value : this.description),
        label: (label != null ? label.value : this.label),
        name: (name != null ? name.value : this.name),
        required: (required != null ? required.value : this.required),
        type: (type != null ? type.value : this.type),
        min: (min != null ? min.value : this.min),
        max: (max != null ? max.value : this.max),
        stepsize: (stepsize != null ? stepsize.value : this.stepsize),
        pattern: (pattern != null ? pattern.value : this.pattern),
        readOnly: (readOnly != null ? readOnly.value : this.readOnly),
        multiple: (multiple != null ? multiple.value : this.multiple),
        multipleLimit:
            (multipleLimit != null ? multipleLimit.value : this.multipleLimit),
        groupName: (groupName != null ? groupName.value : this.groupName),
        advanced: (advanced != null ? advanced.value : this.advanced),
        verify: (verify != null ? verify.value : this.verify),
        limitToOptions: (limitToOptions != null
            ? limitToOptions.value
            : this.limitToOptions),
        unit: (unit != null ? unit.value : this.unit),
        unitLabel: (unitLabel != null ? unitLabel.value : this.unitLabel),
        options: (options != null ? options.value : this.options),
        filterCriteria: (filterCriteria != null
            ? filterCriteria.value
            : this.filterCriteria));
  }
}

@JsonSerializable(explicitToJson: true)
class FilterCriteriaDTO {
  const FilterCriteriaDTO({
    this.$value,
    this.name,
  });

  factory FilterCriteriaDTO.fromJson(Map<String, dynamic> json) =>
      _$FilterCriteriaDTOFromJson(json);

  static const toJsonFactory = _$FilterCriteriaDTOToJson;
  Map<String, dynamic> toJson() => _$FilterCriteriaDTOToJson(this);

  @JsonKey(name: 'value')
  final String? $value;
  @JsonKey(name: 'name')
  final String? name;
  static const fromJsonFactory = _$FilterCriteriaDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilterCriteriaDTO &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $FilterCriteriaDTOExtension on FilterCriteriaDTO {
  FilterCriteriaDTO copyWith({String? $value, String? name}) {
    return FilterCriteriaDTO(
        $value: $value ?? this.$value, name: name ?? this.name);
  }

  FilterCriteriaDTO copyWithWrapped(
      {Wrapped<String?>? $value, Wrapped<String?>? name}) {
    return FilterCriteriaDTO(
        $value: ($value != null ? $value.value : this.$value),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class ModuleTypeDTO {
  const ModuleTypeDTO({
    this.uid,
    this.visibility,
    this.tags,
    this.label,
    this.description,
    this.configDescriptions,
  });

  factory ModuleTypeDTO.fromJson(Map<String, dynamic> json) =>
      _$ModuleTypeDTOFromJson(json);

  static const toJsonFactory = _$ModuleTypeDTOToJson;
  Map<String, dynamic> toJson() => _$ModuleTypeDTOToJson(this);

  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(
    name: 'visibility',
    toJson: moduleTypeDTOVisibilityNullableToJson,
    fromJson: moduleTypeDTOVisibilityNullableFromJson,
  )
  final enums.ModuleTypeDTOVisibility? visibility;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(
      name: 'configDescriptions',
      defaultValue: <ConfigDescriptionParameterDTO>[])
  final List<ConfigDescriptionParameterDTO>? configDescriptions;
  static const fromJsonFactory = _$ModuleTypeDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ModuleTypeDTO &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.visibility, visibility) ||
                const DeepCollectionEquality()
                    .equals(other.visibility, visibility)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.configDescriptions, configDescriptions) ||
                const DeepCollectionEquality()
                    .equals(other.configDescriptions, configDescriptions)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(visibility) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(configDescriptions) ^
      runtimeType.hashCode;
}

extension $ModuleTypeDTOExtension on ModuleTypeDTO {
  ModuleTypeDTO copyWith(
      {String? uid,
      enums.ModuleTypeDTOVisibility? visibility,
      List<String>? tags,
      String? label,
      String? description,
      List<ConfigDescriptionParameterDTO>? configDescriptions}) {
    return ModuleTypeDTO(
        uid: uid ?? this.uid,
        visibility: visibility ?? this.visibility,
        tags: tags ?? this.tags,
        label: label ?? this.label,
        description: description ?? this.description,
        configDescriptions: configDescriptions ?? this.configDescriptions);
  }

  ModuleTypeDTO copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<enums.ModuleTypeDTOVisibility?>? visibility,
      Wrapped<List<String>?>? tags,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<List<ConfigDescriptionParameterDTO>?>? configDescriptions}) {
    return ModuleTypeDTO(
        uid: (uid != null ? uid.value : this.uid),
        visibility: (visibility != null ? visibility.value : this.visibility),
        tags: (tags != null ? tags.value : this.tags),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        configDescriptions: (configDescriptions != null
            ? configDescriptions.value
            : this.configDescriptions));
  }
}

@JsonSerializable(explicitToJson: true)
class ParameterOptionDTO {
  const ParameterOptionDTO({
    this.label,
    this.$value,
  });

  factory ParameterOptionDTO.fromJson(Map<String, dynamic> json) =>
      _$ParameterOptionDTOFromJson(json);

  static const toJsonFactory = _$ParameterOptionDTOToJson;
  Map<String, dynamic> toJson() => _$ParameterOptionDTOToJson(this);

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'value')
  final String? $value;
  static const fromJsonFactory = _$ParameterOptionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParameterOptionDTO &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash($value) ^
      runtimeType.hashCode;
}

extension $ParameterOptionDTOExtension on ParameterOptionDTO {
  ParameterOptionDTO copyWith({String? label, String? $value}) {
    return ParameterOptionDTO(
        label: label ?? this.label, $value: $value ?? this.$value);
  }

  ParameterOptionDTO copyWithWrapped(
      {Wrapped<String?>? label, Wrapped<String?>? $value}) {
    return ParameterOptionDTO(
        label: (label != null ? label.value : this.label),
        $value: ($value != null ? $value.value : this.$value));
  }
}

@JsonSerializable(explicitToJson: true)
class ActionDTO {
  const ActionDTO({
    this.id,
    this.label,
    this.description,
    this.configuration,
    this.type,
    this.inputs,
  });

  factory ActionDTO.fromJson(Map<String, dynamic> json) =>
      _$ActionDTOFromJson(json);

  static const toJsonFactory = _$ActionDTOToJson;
  Map<String, dynamic> toJson() => _$ActionDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'inputs')
  final Map<String, dynamic>? inputs;
  static const fromJsonFactory = _$ActionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ActionDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.inputs, inputs) ||
                const DeepCollectionEquality().equals(other.inputs, inputs)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(inputs) ^
      runtimeType.hashCode;
}

extension $ActionDTOExtension on ActionDTO {
  ActionDTO copyWith(
      {String? id,
      String? label,
      String? description,
      Map<String, dynamic>? configuration,
      String? type,
      Map<String, dynamic>? inputs}) {
    return ActionDTO(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        configuration: configuration ?? this.configuration,
        type: type ?? this.type,
        inputs: inputs ?? this.inputs);
  }

  ActionDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<String?>? type,
      Wrapped<Map<String, dynamic>?>? inputs}) {
    return ActionDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        type: (type != null ? type.value : this.type),
        inputs: (inputs != null ? inputs.value : this.inputs));
  }
}

@JsonSerializable(explicitToJson: true)
class ConditionDTO {
  const ConditionDTO({
    this.id,
    this.label,
    this.description,
    this.configuration,
    this.type,
    this.inputs,
  });

  factory ConditionDTO.fromJson(Map<String, dynamic> json) =>
      _$ConditionDTOFromJson(json);

  static const toJsonFactory = _$ConditionDTOToJson;
  Map<String, dynamic> toJson() => _$ConditionDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'inputs')
  final Map<String, dynamic>? inputs;
  static const fromJsonFactory = _$ConditionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ConditionDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.inputs, inputs) ||
                const DeepCollectionEquality().equals(other.inputs, inputs)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(inputs) ^
      runtimeType.hashCode;
}

extension $ConditionDTOExtension on ConditionDTO {
  ConditionDTO copyWith(
      {String? id,
      String? label,
      String? description,
      Map<String, dynamic>? configuration,
      String? type,
      Map<String, dynamic>? inputs}) {
    return ConditionDTO(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        configuration: configuration ?? this.configuration,
        type: type ?? this.type,
        inputs: inputs ?? this.inputs);
  }

  ConditionDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<String?>? type,
      Wrapped<Map<String, dynamic>?>? inputs}) {
    return ConditionDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        type: (type != null ? type.value : this.type),
        inputs: (inputs != null ? inputs.value : this.inputs));
  }
}

@JsonSerializable(explicitToJson: true)
class RuleDTO {
  const RuleDTO({
    this.triggers,
    this.conditions,
    this.actions,
    this.configuration,
    this.configDescriptions,
    this.templateUID,
    this.uid,
    this.name,
    this.tags,
    this.visibility,
    this.description,
  });

  factory RuleDTO.fromJson(Map<String, dynamic> json) =>
      _$RuleDTOFromJson(json);

  static const toJsonFactory = _$RuleDTOToJson;
  Map<String, dynamic> toJson() => _$RuleDTOToJson(this);

  @JsonKey(name: 'triggers', defaultValue: <TriggerDTO>[])
  final List<TriggerDTO>? triggers;
  @JsonKey(name: 'conditions', defaultValue: <ConditionDTO>[])
  final List<ConditionDTO>? conditions;
  @JsonKey(name: 'actions', defaultValue: <ActionDTO>[])
  final List<ActionDTO>? actions;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(
      name: 'configDescriptions',
      defaultValue: <ConfigDescriptionParameterDTO>[])
  final List<ConfigDescriptionParameterDTO>? configDescriptions;
  @JsonKey(name: 'templateUID')
  final String? templateUID;
  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(
    name: 'visibility',
    toJson: ruleDTOVisibilityNullableToJson,
    fromJson: ruleDTOVisibilityNullableFromJson,
  )
  final enums.RuleDTOVisibility? visibility;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$RuleDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RuleDTO &&
            (identical(other.triggers, triggers) ||
                const DeepCollectionEquality()
                    .equals(other.triggers, triggers)) &&
            (identical(other.conditions, conditions) ||
                const DeepCollectionEquality()
                    .equals(other.conditions, conditions)) &&
            (identical(other.actions, actions) ||
                const DeepCollectionEquality()
                    .equals(other.actions, actions)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.configDescriptions, configDescriptions) ||
                const DeepCollectionEquality()
                    .equals(other.configDescriptions, configDescriptions)) &&
            (identical(other.templateUID, templateUID) ||
                const DeepCollectionEquality()
                    .equals(other.templateUID, templateUID)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.visibility, visibility) ||
                const DeepCollectionEquality()
                    .equals(other.visibility, visibility)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(triggers) ^
      const DeepCollectionEquality().hash(conditions) ^
      const DeepCollectionEquality().hash(actions) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(configDescriptions) ^
      const DeepCollectionEquality().hash(templateUID) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(visibility) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $RuleDTOExtension on RuleDTO {
  RuleDTO copyWith(
      {List<TriggerDTO>? triggers,
      List<ConditionDTO>? conditions,
      List<ActionDTO>? actions,
      Map<String, dynamic>? configuration,
      List<ConfigDescriptionParameterDTO>? configDescriptions,
      String? templateUID,
      String? uid,
      String? name,
      List<String>? tags,
      enums.RuleDTOVisibility? visibility,
      String? description}) {
    return RuleDTO(
        triggers: triggers ?? this.triggers,
        conditions: conditions ?? this.conditions,
        actions: actions ?? this.actions,
        configuration: configuration ?? this.configuration,
        configDescriptions: configDescriptions ?? this.configDescriptions,
        templateUID: templateUID ?? this.templateUID,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        tags: tags ?? this.tags,
        visibility: visibility ?? this.visibility,
        description: description ?? this.description);
  }

  RuleDTO copyWithWrapped(
      {Wrapped<List<TriggerDTO>?>? triggers,
      Wrapped<List<ConditionDTO>?>? conditions,
      Wrapped<List<ActionDTO>?>? actions,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<List<ConfigDescriptionParameterDTO>?>? configDescriptions,
      Wrapped<String?>? templateUID,
      Wrapped<String?>? uid,
      Wrapped<String?>? name,
      Wrapped<List<String>?>? tags,
      Wrapped<enums.RuleDTOVisibility?>? visibility,
      Wrapped<String?>? description}) {
    return RuleDTO(
        triggers: (triggers != null ? triggers.value : this.triggers),
        conditions: (conditions != null ? conditions.value : this.conditions),
        actions: (actions != null ? actions.value : this.actions),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        configDescriptions: (configDescriptions != null
            ? configDescriptions.value
            : this.configDescriptions),
        templateUID:
            (templateUID != null ? templateUID.value : this.templateUID),
        uid: (uid != null ? uid.value : this.uid),
        name: (name != null ? name.value : this.name),
        tags: (tags != null ? tags.value : this.tags),
        visibility: (visibility != null ? visibility.value : this.visibility),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class TriggerDTO {
  const TriggerDTO({
    this.id,
    this.label,
    this.description,
    this.configuration,
    this.type,
  });

  factory TriggerDTO.fromJson(Map<String, dynamic> json) =>
      _$TriggerDTOFromJson(json);

  static const toJsonFactory = _$TriggerDTOToJson;
  Map<String, dynamic> toJson() => _$TriggerDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'type')
  final String? type;
  static const fromJsonFactory = _$TriggerDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TriggerDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $TriggerDTOExtension on TriggerDTO {
  TriggerDTO copyWith(
      {String? id,
      String? label,
      String? description,
      Map<String, dynamic>? configuration,
      String? type}) {
    return TriggerDTO(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        configuration: configuration ?? this.configuration,
        type: type ?? this.type);
  }

  TriggerDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<String?>? type}) {
    return TriggerDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        type: (type != null ? type.value : this.type));
  }
}

@JsonSerializable(explicitToJson: true)
class EnrichedRuleDTO {
  const EnrichedRuleDTO({
    this.triggers,
    this.conditions,
    this.actions,
    this.configuration,
    this.configDescriptions,
    this.templateUID,
    this.uid,
    this.name,
    this.tags,
    this.visibility,
    this.description,
    this.status,
    this.editable,
  });

  factory EnrichedRuleDTO.fromJson(Map<String, dynamic> json) =>
      _$EnrichedRuleDTOFromJson(json);

  static const toJsonFactory = _$EnrichedRuleDTOToJson;
  Map<String, dynamic> toJson() => _$EnrichedRuleDTOToJson(this);

  @JsonKey(name: 'triggers', defaultValue: <TriggerDTO>[])
  final List<TriggerDTO>? triggers;
  @JsonKey(name: 'conditions', defaultValue: <ConditionDTO>[])
  final List<ConditionDTO>? conditions;
  @JsonKey(name: 'actions', defaultValue: <ActionDTO>[])
  final List<ActionDTO>? actions;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(
      name: 'configDescriptions',
      defaultValue: <ConfigDescriptionParameterDTO>[])
  final List<ConfigDescriptionParameterDTO>? configDescriptions;
  @JsonKey(name: 'templateUID')
  final String? templateUID;
  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(
    name: 'visibility',
    toJson: enrichedRuleDTOVisibilityNullableToJson,
    fromJson: enrichedRuleDTOVisibilityNullableFromJson,
  )
  final enums.EnrichedRuleDTOVisibility? visibility;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'status')
  final RuleStatusInfo? status;
  @JsonKey(name: 'editable')
  final bool? editable;
  static const fromJsonFactory = _$EnrichedRuleDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EnrichedRuleDTO &&
            (identical(other.triggers, triggers) ||
                const DeepCollectionEquality()
                    .equals(other.triggers, triggers)) &&
            (identical(other.conditions, conditions) ||
                const DeepCollectionEquality()
                    .equals(other.conditions, conditions)) &&
            (identical(other.actions, actions) ||
                const DeepCollectionEquality()
                    .equals(other.actions, actions)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.configDescriptions, configDescriptions) ||
                const DeepCollectionEquality()
                    .equals(other.configDescriptions, configDescriptions)) &&
            (identical(other.templateUID, templateUID) ||
                const DeepCollectionEquality()
                    .equals(other.templateUID, templateUID)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.visibility, visibility) ||
                const DeepCollectionEquality()
                    .equals(other.visibility, visibility)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.editable, editable) ||
                const DeepCollectionEquality()
                    .equals(other.editable, editable)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(triggers) ^
      const DeepCollectionEquality().hash(conditions) ^
      const DeepCollectionEquality().hash(actions) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(configDescriptions) ^
      const DeepCollectionEquality().hash(templateUID) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(visibility) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(editable) ^
      runtimeType.hashCode;
}

extension $EnrichedRuleDTOExtension on EnrichedRuleDTO {
  EnrichedRuleDTO copyWith(
      {List<TriggerDTO>? triggers,
      List<ConditionDTO>? conditions,
      List<ActionDTO>? actions,
      Map<String, dynamic>? configuration,
      List<ConfigDescriptionParameterDTO>? configDescriptions,
      String? templateUID,
      String? uid,
      String? name,
      List<String>? tags,
      enums.EnrichedRuleDTOVisibility? visibility,
      String? description,
      RuleStatusInfo? status,
      bool? editable}) {
    return EnrichedRuleDTO(
        triggers: triggers ?? this.triggers,
        conditions: conditions ?? this.conditions,
        actions: actions ?? this.actions,
        configuration: configuration ?? this.configuration,
        configDescriptions: configDescriptions ?? this.configDescriptions,
        templateUID: templateUID ?? this.templateUID,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        tags: tags ?? this.tags,
        visibility: visibility ?? this.visibility,
        description: description ?? this.description,
        status: status ?? this.status,
        editable: editable ?? this.editable);
  }

  EnrichedRuleDTO copyWithWrapped(
      {Wrapped<List<TriggerDTO>?>? triggers,
      Wrapped<List<ConditionDTO>?>? conditions,
      Wrapped<List<ActionDTO>?>? actions,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<List<ConfigDescriptionParameterDTO>?>? configDescriptions,
      Wrapped<String?>? templateUID,
      Wrapped<String?>? uid,
      Wrapped<String?>? name,
      Wrapped<List<String>?>? tags,
      Wrapped<enums.EnrichedRuleDTOVisibility?>? visibility,
      Wrapped<String?>? description,
      Wrapped<RuleStatusInfo?>? status,
      Wrapped<bool?>? editable}) {
    return EnrichedRuleDTO(
        triggers: (triggers != null ? triggers.value : this.triggers),
        conditions: (conditions != null ? conditions.value : this.conditions),
        actions: (actions != null ? actions.value : this.actions),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        configDescriptions: (configDescriptions != null
            ? configDescriptions.value
            : this.configDescriptions),
        templateUID:
            (templateUID != null ? templateUID.value : this.templateUID),
        uid: (uid != null ? uid.value : this.uid),
        name: (name != null ? name.value : this.name),
        tags: (tags != null ? tags.value : this.tags),
        visibility: (visibility != null ? visibility.value : this.visibility),
        description:
            (description != null ? description.value : this.description),
        status: (status != null ? status.value : this.status),
        editable: (editable != null ? editable.value : this.editable));
  }
}

@JsonSerializable(explicitToJson: true)
class RuleStatusInfo {
  const RuleStatusInfo({
    this.status,
    this.statusDetail,
    this.description,
  });

  factory RuleStatusInfo.fromJson(Map<String, dynamic> json) =>
      _$RuleStatusInfoFromJson(json);

  static const toJsonFactory = _$RuleStatusInfoToJson;
  Map<String, dynamic> toJson() => _$RuleStatusInfoToJson(this);

  @JsonKey(
    name: 'status',
    toJson: ruleStatusInfoStatusNullableToJson,
    fromJson: ruleStatusInfoStatusNullableFromJson,
  )
  final enums.RuleStatusInfoStatus? status;
  @JsonKey(
    name: 'statusDetail',
    toJson: ruleStatusInfoStatusDetailNullableToJson,
    fromJson: ruleStatusInfoStatusDetailNullableFromJson,
  )
  final enums.RuleStatusInfoStatusDetail? statusDetail;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$RuleStatusInfoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RuleStatusInfo &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.statusDetail, statusDetail) ||
                const DeepCollectionEquality()
                    .equals(other.statusDetail, statusDetail)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(statusDetail) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $RuleStatusInfoExtension on RuleStatusInfo {
  RuleStatusInfo copyWith(
      {enums.RuleStatusInfoStatus? status,
      enums.RuleStatusInfoStatusDetail? statusDetail,
      String? description}) {
    return RuleStatusInfo(
        status: status ?? this.status,
        statusDetail: statusDetail ?? this.statusDetail,
        description: description ?? this.description);
  }

  RuleStatusInfo copyWithWrapped(
      {Wrapped<enums.RuleStatusInfoStatus?>? status,
      Wrapped<enums.RuleStatusInfoStatusDetail?>? statusDetail,
      Wrapped<String?>? description}) {
    return RuleStatusInfo(
        status: (status != null ? status.value : this.status),
        statusDetail:
            (statusDetail != null ? statusDetail.value : this.statusDetail),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class ModuleDTO {
  const ModuleDTO({
    this.id,
    this.label,
    this.description,
    this.configuration,
    this.type,
  });

  factory ModuleDTO.fromJson(Map<String, dynamic> json) =>
      _$ModuleDTOFromJson(json);

  static const toJsonFactory = _$ModuleDTOToJson;
  Map<String, dynamic> toJson() => _$ModuleDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'type')
  final String? type;
  static const fromJsonFactory = _$ModuleDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ModuleDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $ModuleDTOExtension on ModuleDTO {
  ModuleDTO copyWith(
      {String? id,
      String? label,
      String? description,
      Map<String, dynamic>? configuration,
      String? type}) {
    return ModuleDTO(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        configuration: configuration ?? this.configuration,
        type: type ?? this.type);
  }

  ModuleDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<String?>? type}) {
    return ModuleDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        type: (type != null ? type.value : this.type));
  }
}

@JsonSerializable(explicitToJson: true)
class Action {
  const Action({
    this.inputs,
    this.typeUID,
    this.description,
    this.label,
    this.id,
    this.configuration,
  });

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

  static const toJsonFactory = _$ActionToJson;
  Map<String, dynamic> toJson() => _$ActionToJson(this);

  @JsonKey(name: 'inputs')
  final Map<String, dynamic>? inputs;
  @JsonKey(name: 'typeUID')
  final String? typeUID;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'configuration')
  final Configuration? configuration;
  static const fromJsonFactory = _$ActionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Action &&
            (identical(other.inputs, inputs) ||
                const DeepCollectionEquality().equals(other.inputs, inputs)) &&
            (identical(other.typeUID, typeUID) ||
                const DeepCollectionEquality()
                    .equals(other.typeUID, typeUID)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(inputs) ^
      const DeepCollectionEquality().hash(typeUID) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(configuration) ^
      runtimeType.hashCode;
}

extension $ActionExtension on Action {
  Action copyWith(
      {Map<String, dynamic>? inputs,
      String? typeUID,
      String? description,
      String? label,
      String? id,
      Configuration? configuration}) {
    return Action(
        inputs: inputs ?? this.inputs,
        typeUID: typeUID ?? this.typeUID,
        description: description ?? this.description,
        label: label ?? this.label,
        id: id ?? this.id,
        configuration: configuration ?? this.configuration);
  }

  Action copyWithWrapped(
      {Wrapped<Map<String, dynamic>?>? inputs,
      Wrapped<String?>? typeUID,
      Wrapped<String?>? description,
      Wrapped<String?>? label,
      Wrapped<String?>? id,
      Wrapped<Configuration?>? configuration}) {
    return Action(
        inputs: (inputs != null ? inputs.value : this.inputs),
        typeUID: (typeUID != null ? typeUID.value : this.typeUID),
        description:
            (description != null ? description.value : this.description),
        label: (label != null ? label.value : this.label),
        id: (id != null ? id.value : this.id),
        configuration:
            (configuration != null ? configuration.value : this.configuration));
  }
}

@JsonSerializable(explicitToJson: true)
class Condition {
  const Condition({
    this.inputs,
    this.typeUID,
    this.description,
    this.label,
    this.id,
    this.configuration,
  });

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);

  static const toJsonFactory = _$ConditionToJson;
  Map<String, dynamic> toJson() => _$ConditionToJson(this);

  @JsonKey(name: 'inputs')
  final Map<String, dynamic>? inputs;
  @JsonKey(name: 'typeUID')
  final String? typeUID;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'configuration')
  final Configuration? configuration;
  static const fromJsonFactory = _$ConditionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Condition &&
            (identical(other.inputs, inputs) ||
                const DeepCollectionEquality().equals(other.inputs, inputs)) &&
            (identical(other.typeUID, typeUID) ||
                const DeepCollectionEquality()
                    .equals(other.typeUID, typeUID)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(inputs) ^
      const DeepCollectionEquality().hash(typeUID) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(configuration) ^
      runtimeType.hashCode;
}

extension $ConditionExtension on Condition {
  Condition copyWith(
      {Map<String, dynamic>? inputs,
      String? typeUID,
      String? description,
      String? label,
      String? id,
      Configuration? configuration}) {
    return Condition(
        inputs: inputs ?? this.inputs,
        typeUID: typeUID ?? this.typeUID,
        description: description ?? this.description,
        label: label ?? this.label,
        id: id ?? this.id,
        configuration: configuration ?? this.configuration);
  }

  Condition copyWithWrapped(
      {Wrapped<Map<String, dynamic>?>? inputs,
      Wrapped<String?>? typeUID,
      Wrapped<String?>? description,
      Wrapped<String?>? label,
      Wrapped<String?>? id,
      Wrapped<Configuration?>? configuration}) {
    return Condition(
        inputs: (inputs != null ? inputs.value : this.inputs),
        typeUID: (typeUID != null ? typeUID.value : this.typeUID),
        description:
            (description != null ? description.value : this.description),
        label: (label != null ? label.value : this.label),
        id: (id != null ? id.value : this.id),
        configuration:
            (configuration != null ? configuration.value : this.configuration));
  }
}

@JsonSerializable(explicitToJson: true)
class ConfigDescriptionParameter {
  const ConfigDescriptionParameter({
    this.name,
    this.type,
    this.groupName,
    this.pattern,
    this.required,
    this.readOnly,
    this.multiple,
    this.multipleLimit,
    this.unit,
    this.unitLabel,
    this.context,
    this.label,
    this.description,
    this.options,
    this.filterCriteria,
    this.limitToOptions,
    this.advanced,
    this.stepSize,
    this.verifyable,
    this.minimum,
    this.maximum,
    this.$default,
  });

  factory ConfigDescriptionParameter.fromJson(Map<String, dynamic> json) =>
      _$ConfigDescriptionParameterFromJson(json);

  static const toJsonFactory = _$ConfigDescriptionParameterToJson;
  Map<String, dynamic> toJson() => _$ConfigDescriptionParameterToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(
    name: 'type',
    toJson: configDescriptionParameterTypeNullableToJson,
    fromJson: configDescriptionParameterTypeNullableFromJson,
  )
  final enums.ConfigDescriptionParameterType? type;
  @JsonKey(name: 'groupName')
  final String? groupName;
  @JsonKey(name: 'pattern')
  final String? pattern;
  @JsonKey(name: 'required')
  final bool? required;
  @JsonKey(name: 'readOnly')
  final bool? readOnly;
  @JsonKey(name: 'multiple')
  final bool? multiple;
  @JsonKey(name: 'multipleLimit')
  final int? multipleLimit;
  @JsonKey(name: 'unit')
  final String? unit;
  @JsonKey(name: 'unitLabel')
  final String? unitLabel;
  @JsonKey(name: 'context')
  final String? context;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'options', defaultValue: <ParameterOption>[])
  final List<ParameterOption>? options;
  @JsonKey(name: 'filterCriteria', defaultValue: <FilterCriteria>[])
  final List<FilterCriteria>? filterCriteria;
  @JsonKey(name: 'limitToOptions')
  final bool? limitToOptions;
  @JsonKey(name: 'advanced')
  final bool? advanced;
  @JsonKey(name: 'stepSize')
  final double? stepSize;
  @JsonKey(name: 'verifyable')
  final bool? verifyable;
  @JsonKey(name: 'minimum')
  final double? minimum;
  @JsonKey(name: 'maximum')
  final double? maximum;
  @JsonKey(name: 'default')
  final String? $default;
  static const fromJsonFactory = _$ConfigDescriptionParameterFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ConfigDescriptionParameter &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.groupName, groupName) ||
                const DeepCollectionEquality()
                    .equals(other.groupName, groupName)) &&
            (identical(other.pattern, pattern) ||
                const DeepCollectionEquality()
                    .equals(other.pattern, pattern)) &&
            (identical(other.required, required) ||
                const DeepCollectionEquality()
                    .equals(other.required, required)) &&
            (identical(other.readOnly, readOnly) ||
                const DeepCollectionEquality()
                    .equals(other.readOnly, readOnly)) &&
            (identical(other.multiple, multiple) ||
                const DeepCollectionEquality()
                    .equals(other.multiple, multiple)) &&
            (identical(other.multipleLimit, multipleLimit) ||
                const DeepCollectionEquality()
                    .equals(other.multipleLimit, multipleLimit)) &&
            (identical(other.unit, unit) ||
                const DeepCollectionEquality().equals(other.unit, unit)) &&
            (identical(other.unitLabel, unitLabel) ||
                const DeepCollectionEquality()
                    .equals(other.unitLabel, unitLabel)) &&
            (identical(other.context, context) ||
                const DeepCollectionEquality()
                    .equals(other.context, context)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality()
                    .equals(other.options, options)) &&
            (identical(other.filterCriteria, filterCriteria) ||
                const DeepCollectionEquality()
                    .equals(other.filterCriteria, filterCriteria)) &&
            (identical(other.limitToOptions, limitToOptions) ||
                const DeepCollectionEquality()
                    .equals(other.limitToOptions, limitToOptions)) &&
            (identical(other.advanced, advanced) ||
                const DeepCollectionEquality()
                    .equals(other.advanced, advanced)) &&
            (identical(other.stepSize, stepSize) ||
                const DeepCollectionEquality()
                    .equals(other.stepSize, stepSize)) &&
            (identical(other.verifyable, verifyable) ||
                const DeepCollectionEquality()
                    .equals(other.verifyable, verifyable)) &&
            (identical(other.minimum, minimum) ||
                const DeepCollectionEquality()
                    .equals(other.minimum, minimum)) &&
            (identical(other.maximum, maximum) ||
                const DeepCollectionEquality()
                    .equals(other.maximum, maximum)) &&
            (identical(other.$default, $default) ||
                const DeepCollectionEquality()
                    .equals(other.$default, $default)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(groupName) ^
      const DeepCollectionEquality().hash(pattern) ^
      const DeepCollectionEquality().hash(required) ^
      const DeepCollectionEquality().hash(readOnly) ^
      const DeepCollectionEquality().hash(multiple) ^
      const DeepCollectionEquality().hash(multipleLimit) ^
      const DeepCollectionEquality().hash(unit) ^
      const DeepCollectionEquality().hash(unitLabel) ^
      const DeepCollectionEquality().hash(context) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(options) ^
      const DeepCollectionEquality().hash(filterCriteria) ^
      const DeepCollectionEquality().hash(limitToOptions) ^
      const DeepCollectionEquality().hash(advanced) ^
      const DeepCollectionEquality().hash(stepSize) ^
      const DeepCollectionEquality().hash(verifyable) ^
      const DeepCollectionEquality().hash(minimum) ^
      const DeepCollectionEquality().hash(maximum) ^
      const DeepCollectionEquality().hash($default) ^
      runtimeType.hashCode;
}

extension $ConfigDescriptionParameterExtension on ConfigDescriptionParameter {
  ConfigDescriptionParameter copyWith(
      {String? name,
      enums.ConfigDescriptionParameterType? type,
      String? groupName,
      String? pattern,
      bool? required,
      bool? readOnly,
      bool? multiple,
      int? multipleLimit,
      String? unit,
      String? unitLabel,
      String? context,
      String? label,
      String? description,
      List<ParameterOption>? options,
      List<FilterCriteria>? filterCriteria,
      bool? limitToOptions,
      bool? advanced,
      double? stepSize,
      bool? verifyable,
      double? minimum,
      double? maximum,
      String? $default}) {
    return ConfigDescriptionParameter(
        name: name ?? this.name,
        type: type ?? this.type,
        groupName: groupName ?? this.groupName,
        pattern: pattern ?? this.pattern,
        required: required ?? this.required,
        readOnly: readOnly ?? this.readOnly,
        multiple: multiple ?? this.multiple,
        multipleLimit: multipleLimit ?? this.multipleLimit,
        unit: unit ?? this.unit,
        unitLabel: unitLabel ?? this.unitLabel,
        context: context ?? this.context,
        label: label ?? this.label,
        description: description ?? this.description,
        options: options ?? this.options,
        filterCriteria: filterCriteria ?? this.filterCriteria,
        limitToOptions: limitToOptions ?? this.limitToOptions,
        advanced: advanced ?? this.advanced,
        stepSize: stepSize ?? this.stepSize,
        verifyable: verifyable ?? this.verifyable,
        minimum: minimum ?? this.minimum,
        maximum: maximum ?? this.maximum,
        $default: $default ?? this.$default);
  }

  ConfigDescriptionParameter copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<enums.ConfigDescriptionParameterType?>? type,
      Wrapped<String?>? groupName,
      Wrapped<String?>? pattern,
      Wrapped<bool?>? required,
      Wrapped<bool?>? readOnly,
      Wrapped<bool?>? multiple,
      Wrapped<int?>? multipleLimit,
      Wrapped<String?>? unit,
      Wrapped<String?>? unitLabel,
      Wrapped<String?>? context,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<List<ParameterOption>?>? options,
      Wrapped<List<FilterCriteria>?>? filterCriteria,
      Wrapped<bool?>? limitToOptions,
      Wrapped<bool?>? advanced,
      Wrapped<double?>? stepSize,
      Wrapped<bool?>? verifyable,
      Wrapped<double?>? minimum,
      Wrapped<double?>? maximum,
      Wrapped<String?>? $default}) {
    return ConfigDescriptionParameter(
        name: (name != null ? name.value : this.name),
        type: (type != null ? type.value : this.type),
        groupName: (groupName != null ? groupName.value : this.groupName),
        pattern: (pattern != null ? pattern.value : this.pattern),
        required: (required != null ? required.value : this.required),
        readOnly: (readOnly != null ? readOnly.value : this.readOnly),
        multiple: (multiple != null ? multiple.value : this.multiple),
        multipleLimit:
            (multipleLimit != null ? multipleLimit.value : this.multipleLimit),
        unit: (unit != null ? unit.value : this.unit),
        unitLabel: (unitLabel != null ? unitLabel.value : this.unitLabel),
        context: (context != null ? context.value : this.context),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        options: (options != null ? options.value : this.options),
        filterCriteria: (filterCriteria != null
            ? filterCriteria.value
            : this.filterCriteria),
        limitToOptions: (limitToOptions != null
            ? limitToOptions.value
            : this.limitToOptions),
        advanced: (advanced != null ? advanced.value : this.advanced),
        stepSize: (stepSize != null ? stepSize.value : this.stepSize),
        verifyable: (verifyable != null ? verifyable.value : this.verifyable),
        minimum: (minimum != null ? minimum.value : this.minimum),
        maximum: (maximum != null ? maximum.value : this.maximum),
        $default: ($default != null ? $default.value : this.$default));
  }
}

@JsonSerializable(explicitToJson: true)
class Configuration {
  const Configuration({
    this.properties,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  static const toJsonFactory = _$ConfigurationToJson;
  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  static const fromJsonFactory = _$ConfigurationFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Configuration &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(properties) ^ runtimeType.hashCode;
}

extension $ConfigurationExtension on Configuration {
  Configuration copyWith({Map<String, dynamic>? properties}) {
    return Configuration(properties: properties ?? this.properties);
  }

  Configuration copyWithWrapped({Wrapped<Map<String, dynamic>?>? properties}) {
    return Configuration(
        properties: (properties != null ? properties.value : this.properties));
  }
}

@JsonSerializable(explicitToJson: true)
class FilterCriteria {
  const FilterCriteria({
    this.$value,
    this.name,
  });

  factory FilterCriteria.fromJson(Map<String, dynamic> json) =>
      _$FilterCriteriaFromJson(json);

  static const toJsonFactory = _$FilterCriteriaToJson;
  Map<String, dynamic> toJson() => _$FilterCriteriaToJson(this);

  @JsonKey(name: 'value')
  final String? $value;
  @JsonKey(name: 'name')
  final String? name;
  static const fromJsonFactory = _$FilterCriteriaFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FilterCriteria &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $FilterCriteriaExtension on FilterCriteria {
  FilterCriteria copyWith({String? $value, String? name}) {
    return FilterCriteria(
        $value: $value ?? this.$value, name: name ?? this.name);
  }

  FilterCriteria copyWithWrapped(
      {Wrapped<String?>? $value, Wrapped<String?>? name}) {
    return FilterCriteria(
        $value: ($value != null ? $value.value : this.$value),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class Module {
  const Module({
    this.typeUID,
    this.description,
    this.label,
    this.id,
    this.configuration,
  });

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  static const toJsonFactory = _$ModuleToJson;
  Map<String, dynamic> toJson() => _$ModuleToJson(this);

  @JsonKey(name: 'typeUID')
  final String? typeUID;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'configuration')
  final Configuration? configuration;
  static const fromJsonFactory = _$ModuleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Module &&
            (identical(other.typeUID, typeUID) ||
                const DeepCollectionEquality()
                    .equals(other.typeUID, typeUID)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(typeUID) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(configuration) ^
      runtimeType.hashCode;
}

extension $ModuleExtension on Module {
  Module copyWith(
      {String? typeUID,
      String? description,
      String? label,
      String? id,
      Configuration? configuration}) {
    return Module(
        typeUID: typeUID ?? this.typeUID,
        description: description ?? this.description,
        label: label ?? this.label,
        id: id ?? this.id,
        configuration: configuration ?? this.configuration);
  }

  Module copyWithWrapped(
      {Wrapped<String?>? typeUID,
      Wrapped<String?>? description,
      Wrapped<String?>? label,
      Wrapped<String?>? id,
      Wrapped<Configuration?>? configuration}) {
    return Module(
        typeUID: (typeUID != null ? typeUID.value : this.typeUID),
        description:
            (description != null ? description.value : this.description),
        label: (label != null ? label.value : this.label),
        id: (id != null ? id.value : this.id),
        configuration:
            (configuration != null ? configuration.value : this.configuration));
  }
}

@JsonSerializable(explicitToJson: true)
class ParameterOption {
  const ParameterOption({
    this.label,
    this.$value,
  });

  factory ParameterOption.fromJson(Map<String, dynamic> json) =>
      _$ParameterOptionFromJson(json);

  static const toJsonFactory = _$ParameterOptionToJson;
  Map<String, dynamic> toJson() => _$ParameterOptionToJson(this);

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'value')
  final String? $value;
  static const fromJsonFactory = _$ParameterOptionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParameterOption &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash($value) ^
      runtimeType.hashCode;
}

extension $ParameterOptionExtension on ParameterOption {
  ParameterOption copyWith({String? label, String? $value}) {
    return ParameterOption(
        label: label ?? this.label, $value: $value ?? this.$value);
  }

  ParameterOption copyWithWrapped(
      {Wrapped<String?>? label, Wrapped<String?>? $value}) {
    return ParameterOption(
        label: (label != null ? label.value : this.label),
        $value: ($value != null ? $value.value : this.$value));
  }
}

@JsonSerializable(explicitToJson: true)
class Rule {
  const Rule({
    this.configurationDescriptions,
    this.templateUID,
    this.triggers,
    this.visibility,
    this.tags,
    this.uid,
    this.description,
    this.name,
    this.actions,
    this.configuration,
    this.modules,
    this.conditions,
  });

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);

  static const toJsonFactory = _$RuleToJson;
  Map<String, dynamic> toJson() => _$RuleToJson(this);

  @JsonKey(
      name: 'configurationDescriptions',
      defaultValue: <ConfigDescriptionParameter>[])
  final List<ConfigDescriptionParameter>? configurationDescriptions;
  @JsonKey(name: 'templateUID')
  final String? templateUID;
  @JsonKey(name: 'triggers', defaultValue: <Trigger>[])
  final List<Trigger>? triggers;
  @JsonKey(
    name: 'visibility',
    toJson: ruleVisibilityNullableToJson,
    fromJson: ruleVisibilityNullableFromJson,
  )
  final enums.RuleVisibility? visibility;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'actions', defaultValue: <Action>[])
  final List<Action>? actions;
  @JsonKey(name: 'configuration')
  final Configuration? configuration;
  @JsonKey(name: 'modules', defaultValue: <Module>[])
  final List<Module>? modules;
  @JsonKey(name: 'conditions', defaultValue: <Condition>[])
  final List<Condition>? conditions;
  static const fromJsonFactory = _$RuleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Rule &&
            (identical(other.configurationDescriptions,
                    configurationDescriptions) ||
                const DeepCollectionEquality().equals(
                    other.configurationDescriptions,
                    configurationDescriptions)) &&
            (identical(other.templateUID, templateUID) ||
                const DeepCollectionEquality()
                    .equals(other.templateUID, templateUID)) &&
            (identical(other.triggers, triggers) ||
                const DeepCollectionEquality()
                    .equals(other.triggers, triggers)) &&
            (identical(other.visibility, visibility) ||
                const DeepCollectionEquality()
                    .equals(other.visibility, visibility)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.actions, actions) ||
                const DeepCollectionEquality()
                    .equals(other.actions, actions)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.modules, modules) ||
                const DeepCollectionEquality()
                    .equals(other.modules, modules)) &&
            (identical(other.conditions, conditions) ||
                const DeepCollectionEquality()
                    .equals(other.conditions, conditions)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(configurationDescriptions) ^
      const DeepCollectionEquality().hash(templateUID) ^
      const DeepCollectionEquality().hash(triggers) ^
      const DeepCollectionEquality().hash(visibility) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(actions) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(modules) ^
      const DeepCollectionEquality().hash(conditions) ^
      runtimeType.hashCode;
}

extension $RuleExtension on Rule {
  Rule copyWith(
      {List<ConfigDescriptionParameter>? configurationDescriptions,
      String? templateUID,
      List<Trigger>? triggers,
      enums.RuleVisibility? visibility,
      List<String>? tags,
      String? uid,
      String? description,
      String? name,
      List<Action>? actions,
      Configuration? configuration,
      List<Module>? modules,
      List<Condition>? conditions}) {
    return Rule(
        configurationDescriptions:
            configurationDescriptions ?? this.configurationDescriptions,
        templateUID: templateUID ?? this.templateUID,
        triggers: triggers ?? this.triggers,
        visibility: visibility ?? this.visibility,
        tags: tags ?? this.tags,
        uid: uid ?? this.uid,
        description: description ?? this.description,
        name: name ?? this.name,
        actions: actions ?? this.actions,
        configuration: configuration ?? this.configuration,
        modules: modules ?? this.modules,
        conditions: conditions ?? this.conditions);
  }

  Rule copyWithWrapped(
      {Wrapped<List<ConfigDescriptionParameter>?>? configurationDescriptions,
      Wrapped<String?>? templateUID,
      Wrapped<List<Trigger>?>? triggers,
      Wrapped<enums.RuleVisibility?>? visibility,
      Wrapped<List<String>?>? tags,
      Wrapped<String?>? uid,
      Wrapped<String?>? description,
      Wrapped<String?>? name,
      Wrapped<List<Action>?>? actions,
      Wrapped<Configuration?>? configuration,
      Wrapped<List<Module>?>? modules,
      Wrapped<List<Condition>?>? conditions}) {
    return Rule(
        configurationDescriptions: (configurationDescriptions != null
            ? configurationDescriptions.value
            : this.configurationDescriptions),
        templateUID:
            (templateUID != null ? templateUID.value : this.templateUID),
        triggers: (triggers != null ? triggers.value : this.triggers),
        visibility: (visibility != null ? visibility.value : this.visibility),
        tags: (tags != null ? tags.value : this.tags),
        uid: (uid != null ? uid.value : this.uid),
        description:
            (description != null ? description.value : this.description),
        name: (name != null ? name.value : this.name),
        actions: (actions != null ? actions.value : this.actions),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        modules: (modules != null ? modules.value : this.modules),
        conditions: (conditions != null ? conditions.value : this.conditions));
  }
}

@JsonSerializable(explicitToJson: true)
class RuleExecution {
  const RuleExecution({
    this.date,
    this.rule,
  });

  factory RuleExecution.fromJson(Map<String, dynamic> json) =>
      _$RuleExecutionFromJson(json);

  static const toJsonFactory = _$RuleExecutionToJson;
  Map<String, dynamic> toJson() => _$RuleExecutionToJson(this);

  @JsonKey(name: 'date')
  final DateTime? date;
  @JsonKey(name: 'rule')
  final Rule? rule;
  static const fromJsonFactory = _$RuleExecutionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RuleExecution &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.rule, rule) ||
                const DeepCollectionEquality().equals(other.rule, rule)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(rule) ^
      runtimeType.hashCode;
}

extension $RuleExecutionExtension on RuleExecution {
  RuleExecution copyWith({DateTime? date, Rule? rule}) {
    return RuleExecution(date: date ?? this.date, rule: rule ?? this.rule);
  }

  RuleExecution copyWithWrapped(
      {Wrapped<DateTime?>? date, Wrapped<Rule?>? rule}) {
    return RuleExecution(
        date: (date != null ? date.value : this.date),
        rule: (rule != null ? rule.value : this.rule));
  }
}

@JsonSerializable(explicitToJson: true)
class Trigger {
  const Trigger({
    this.typeUID,
    this.description,
    this.label,
    this.id,
    this.configuration,
  });

  factory Trigger.fromJson(Map<String, dynamic> json) =>
      _$TriggerFromJson(json);

  static const toJsonFactory = _$TriggerToJson;
  Map<String, dynamic> toJson() => _$TriggerToJson(this);

  @JsonKey(name: 'typeUID')
  final String? typeUID;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'configuration')
  final Configuration? configuration;
  static const fromJsonFactory = _$TriggerFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Trigger &&
            (identical(other.typeUID, typeUID) ||
                const DeepCollectionEquality()
                    .equals(other.typeUID, typeUID)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(typeUID) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(configuration) ^
      runtimeType.hashCode;
}

extension $TriggerExtension on Trigger {
  Trigger copyWith(
      {String? typeUID,
      String? description,
      String? label,
      String? id,
      Configuration? configuration}) {
    return Trigger(
        typeUID: typeUID ?? this.typeUID,
        description: description ?? this.description,
        label: label ?? this.label,
        id: id ?? this.id,
        configuration: configuration ?? this.configuration);
  }

  Trigger copyWithWrapped(
      {Wrapped<String?>? typeUID,
      Wrapped<String?>? description,
      Wrapped<String?>? label,
      Wrapped<String?>? id,
      Wrapped<Configuration?>? configuration}) {
    return Trigger(
        typeUID: (typeUID != null ? typeUID.value : this.typeUID),
        description:
            (description != null ? description.value : this.description),
        label: (label != null ? label.value : this.label),
        id: (id != null ? id.value : this.id),
        configuration:
            (configuration != null ? configuration.value : this.configuration));
  }
}

@JsonSerializable(explicitToJson: true)
class Template {
  const Template({
    this.visibility,
    this.tags,
    this.uid,
    this.description,
    this.label,
  });

  factory Template.fromJson(Map<String, dynamic> json) =>
      _$TemplateFromJson(json);

  static const toJsonFactory = _$TemplateToJson;
  Map<String, dynamic> toJson() => _$TemplateToJson(this);

  @JsonKey(
    name: 'visibility',
    toJson: templateVisibilityNullableToJson,
    fromJson: templateVisibilityNullableFromJson,
  )
  final enums.TemplateVisibility? visibility;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'label')
  final String? label;
  static const fromJsonFactory = _$TemplateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Template &&
            (identical(other.visibility, visibility) ||
                const DeepCollectionEquality()
                    .equals(other.visibility, visibility)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(visibility) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(label) ^
      runtimeType.hashCode;
}

extension $TemplateExtension on Template {
  Template copyWith(
      {enums.TemplateVisibility? visibility,
      List<String>? tags,
      String? uid,
      String? description,
      String? label}) {
    return Template(
        visibility: visibility ?? this.visibility,
        tags: tags ?? this.tags,
        uid: uid ?? this.uid,
        description: description ?? this.description,
        label: label ?? this.label);
  }

  Template copyWithWrapped(
      {Wrapped<enums.TemplateVisibility?>? visibility,
      Wrapped<List<String>?>? tags,
      Wrapped<String?>? uid,
      Wrapped<String?>? description,
      Wrapped<String?>? label}) {
    return Template(
        visibility: (visibility != null ? visibility.value : this.visibility),
        tags: (tags != null ? tags.value : this.tags),
        uid: (uid != null ? uid.value : this.uid),
        description:
            (description != null ? description.value : this.description),
        label: (label != null ? label.value : this.label));
  }
}

@JsonSerializable(explicitToJson: true)
class Input {
  const Input({
    this.name,
    this.type,
    this.label,
    this.description,
    this.required,
    this.tags,
    this.reference,
    this.defaultValue,
  });

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  static const toJsonFactory = _$InputToJson;
  Map<String, dynamic> toJson() => _$InputToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'required')
  final bool? required;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'reference')
  final String? reference;
  @JsonKey(name: 'defaultValue')
  final String? defaultValue;
  static const fromJsonFactory = _$InputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Input &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.required, required) ||
                const DeepCollectionEquality()
                    .equals(other.required, required)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality()
                    .equals(other.reference, reference)) &&
            (identical(other.defaultValue, defaultValue) ||
                const DeepCollectionEquality()
                    .equals(other.defaultValue, defaultValue)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(required) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(reference) ^
      const DeepCollectionEquality().hash(defaultValue) ^
      runtimeType.hashCode;
}

extension $InputExtension on Input {
  Input copyWith(
      {String? name,
      String? type,
      String? label,
      String? description,
      bool? required,
      List<String>? tags,
      String? reference,
      String? defaultValue}) {
    return Input(
        name: name ?? this.name,
        type: type ?? this.type,
        label: label ?? this.label,
        description: description ?? this.description,
        required: required ?? this.required,
        tags: tags ?? this.tags,
        reference: reference ?? this.reference,
        defaultValue: defaultValue ?? this.defaultValue);
  }

  Input copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? type,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<bool?>? required,
      Wrapped<List<String>?>? tags,
      Wrapped<String?>? reference,
      Wrapped<String?>? defaultValue}) {
    return Input(
        name: (name != null ? name.value : this.name),
        type: (type != null ? type.value : this.type),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        required: (required != null ? required.value : this.required),
        tags: (tags != null ? tags.value : this.tags),
        reference: (reference != null ? reference.value : this.reference),
        defaultValue:
            (defaultValue != null ? defaultValue.value : this.defaultValue));
  }
}

@JsonSerializable(explicitToJson: true)
class Output {
  const Output({
    this.name,
    this.type,
    this.tags,
    this.label,
    this.description,
    this.reference,
    this.defaultValue,
  });

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  static const toJsonFactory = _$OutputToJson;
  Map<String, dynamic> toJson() => _$OutputToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'reference')
  final String? reference;
  @JsonKey(name: 'defaultValue')
  final String? defaultValue;
  static const fromJsonFactory = _$OutputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Output &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality()
                    .equals(other.reference, reference)) &&
            (identical(other.defaultValue, defaultValue) ||
                const DeepCollectionEquality()
                    .equals(other.defaultValue, defaultValue)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(reference) ^
      const DeepCollectionEquality().hash(defaultValue) ^
      runtimeType.hashCode;
}

extension $OutputExtension on Output {
  Output copyWith(
      {String? name,
      String? type,
      List<String>? tags,
      String? label,
      String? description,
      String? reference,
      String? defaultValue}) {
    return Output(
        name: name ?? this.name,
        type: type ?? this.type,
        tags: tags ?? this.tags,
        label: label ?? this.label,
        description: description ?? this.description,
        reference: reference ?? this.reference,
        defaultValue: defaultValue ?? this.defaultValue);
  }

  Output copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? type,
      Wrapped<List<String>?>? tags,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<String?>? reference,
      Wrapped<String?>? defaultValue}) {
    return Output(
        name: (name != null ? name.value : this.name),
        type: (type != null ? type.value : this.type),
        tags: (tags != null ? tags.value : this.tags),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        reference: (reference != null ? reference.value : this.reference),
        defaultValue:
            (defaultValue != null ? defaultValue.value : this.defaultValue));
  }
}

@JsonSerializable(explicitToJson: true)
class ThingActionDTO {
  const ThingActionDTO({
    this.actionUid,
    this.label,
    this.description,
    this.inputs,
    this.outputs,
  });

  factory ThingActionDTO.fromJson(Map<String, dynamic> json) =>
      _$ThingActionDTOFromJson(json);

  static const toJsonFactory = _$ThingActionDTOToJson;
  Map<String, dynamic> toJson() => _$ThingActionDTOToJson(this);

  @JsonKey(name: 'actionUid')
  final String? actionUid;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'inputs', defaultValue: <Input>[])
  final List<Input>? inputs;
  @JsonKey(name: 'outputs', defaultValue: <Output>[])
  final List<Output>? outputs;
  static const fromJsonFactory = _$ThingActionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ThingActionDTO &&
            (identical(other.actionUid, actionUid) ||
                const DeepCollectionEquality()
                    .equals(other.actionUid, actionUid)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.inputs, inputs) ||
                const DeepCollectionEquality().equals(other.inputs, inputs)) &&
            (identical(other.outputs, outputs) ||
                const DeepCollectionEquality().equals(other.outputs, outputs)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(actionUid) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(inputs) ^
      const DeepCollectionEquality().hash(outputs) ^
      runtimeType.hashCode;
}

extension $ThingActionDTOExtension on ThingActionDTO {
  ThingActionDTO copyWith(
      {String? actionUid,
      String? label,
      String? description,
      List<Input>? inputs,
      List<Output>? outputs}) {
    return ThingActionDTO(
        actionUid: actionUid ?? this.actionUid,
        label: label ?? this.label,
        description: description ?? this.description,
        inputs: inputs ?? this.inputs,
        outputs: outputs ?? this.outputs);
  }

  ThingActionDTO copyWithWrapped(
      {Wrapped<String?>? actionUid,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<List<Input>?>? inputs,
      Wrapped<List<Output>?>? outputs}) {
    return ThingActionDTO(
        actionUid: (actionUid != null ? actionUid.value : this.actionUid),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        inputs: (inputs != null ? inputs.value : this.inputs),
        outputs: (outputs != null ? outputs.value : this.outputs));
  }
}

@JsonSerializable(explicitToJson: true)
class AudioSinkDTO {
  const AudioSinkDTO({
    this.id,
    this.label,
  });

  factory AudioSinkDTO.fromJson(Map<String, dynamic> json) =>
      _$AudioSinkDTOFromJson(json);

  static const toJsonFactory = _$AudioSinkDTOToJson;
  Map<String, dynamic> toJson() => _$AudioSinkDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  static const fromJsonFactory = _$AudioSinkDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AudioSinkDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      runtimeType.hashCode;
}

extension $AudioSinkDTOExtension on AudioSinkDTO {
  AudioSinkDTO copyWith({String? id, String? label}) {
    return AudioSinkDTO(id: id ?? this.id, label: label ?? this.label);
  }

  AudioSinkDTO copyWithWrapped(
      {Wrapped<String?>? id, Wrapped<String?>? label}) {
    return AudioSinkDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label));
  }
}

@JsonSerializable(explicitToJson: true)
class AudioSourceDTO {
  const AudioSourceDTO({
    this.id,
    this.label,
  });

  factory AudioSourceDTO.fromJson(Map<String, dynamic> json) =>
      _$AudioSourceDTOFromJson(json);

  static const toJsonFactory = _$AudioSourceDTOToJson;
  Map<String, dynamic> toJson() => _$AudioSourceDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  static const fromJsonFactory = _$AudioSourceDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AudioSourceDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      runtimeType.hashCode;
}

extension $AudioSourceDTOExtension on AudioSourceDTO {
  AudioSourceDTO copyWith({String? id, String? label}) {
    return AudioSourceDTO(id: id ?? this.id, label: label ?? this.label);
  }

  AudioSourceDTO copyWithWrapped(
      {Wrapped<String?>? id, Wrapped<String?>? label}) {
    return AudioSourceDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label));
  }
}

@JsonSerializable(explicitToJson: true)
class UserApiTokenDTO {
  const UserApiTokenDTO({
    this.name,
    this.createdTime,
    this.scope,
  });

  factory UserApiTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$UserApiTokenDTOFromJson(json);

  static const toJsonFactory = _$UserApiTokenDTOToJson;
  Map<String, dynamic> toJson() => _$UserApiTokenDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'createdTime')
  final DateTime? createdTime;
  @JsonKey(name: 'scope')
  final String? scope;
  static const fromJsonFactory = _$UserApiTokenDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserApiTokenDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.createdTime, createdTime) ||
                const DeepCollectionEquality()
                    .equals(other.createdTime, createdTime)) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(createdTime) ^
      const DeepCollectionEquality().hash(scope) ^
      runtimeType.hashCode;
}

extension $UserApiTokenDTOExtension on UserApiTokenDTO {
  UserApiTokenDTO copyWith(
      {String? name, DateTime? createdTime, String? scope}) {
    return UserApiTokenDTO(
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
        scope: scope ?? this.scope);
  }

  UserApiTokenDTO copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<DateTime?>? createdTime,
      Wrapped<String?>? scope}) {
    return UserApiTokenDTO(
        name: (name != null ? name.value : this.name),
        createdTime:
            (createdTime != null ? createdTime.value : this.createdTime),
        scope: (scope != null ? scope.value : this.scope));
  }
}

@JsonSerializable(explicitToJson: true)
class UserSessionDTO {
  const UserSessionDTO({
    this.sessionId,
    this.createdTime,
    this.lastRefreshTime,
    this.clientId,
    this.scope,
  });

  factory UserSessionDTO.fromJson(Map<String, dynamic> json) =>
      _$UserSessionDTOFromJson(json);

  static const toJsonFactory = _$UserSessionDTOToJson;
  Map<String, dynamic> toJson() => _$UserSessionDTOToJson(this);

  @JsonKey(name: 'sessionId')
  final String? sessionId;
  @JsonKey(name: 'createdTime')
  final DateTime? createdTime;
  @JsonKey(name: 'lastRefreshTime')
  final DateTime? lastRefreshTime;
  @JsonKey(name: 'clientId')
  final String? clientId;
  @JsonKey(name: 'scope')
  final String? scope;
  static const fromJsonFactory = _$UserSessionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSessionDTO &&
            (identical(other.sessionId, sessionId) ||
                const DeepCollectionEquality()
                    .equals(other.sessionId, sessionId)) &&
            (identical(other.createdTime, createdTime) ||
                const DeepCollectionEquality()
                    .equals(other.createdTime, createdTime)) &&
            (identical(other.lastRefreshTime, lastRefreshTime) ||
                const DeepCollectionEquality()
                    .equals(other.lastRefreshTime, lastRefreshTime)) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sessionId) ^
      const DeepCollectionEquality().hash(createdTime) ^
      const DeepCollectionEquality().hash(lastRefreshTime) ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(scope) ^
      runtimeType.hashCode;
}

extension $UserSessionDTOExtension on UserSessionDTO {
  UserSessionDTO copyWith(
      {String? sessionId,
      DateTime? createdTime,
      DateTime? lastRefreshTime,
      String? clientId,
      String? scope}) {
    return UserSessionDTO(
        sessionId: sessionId ?? this.sessionId,
        createdTime: createdTime ?? this.createdTime,
        lastRefreshTime: lastRefreshTime ?? this.lastRefreshTime,
        clientId: clientId ?? this.clientId,
        scope: scope ?? this.scope);
  }

  UserSessionDTO copyWithWrapped(
      {Wrapped<String?>? sessionId,
      Wrapped<DateTime?>? createdTime,
      Wrapped<DateTime?>? lastRefreshTime,
      Wrapped<String?>? clientId,
      Wrapped<String?>? scope}) {
    return UserSessionDTO(
        sessionId: (sessionId != null ? sessionId.value : this.sessionId),
        createdTime:
            (createdTime != null ? createdTime.value : this.createdTime),
        lastRefreshTime: (lastRefreshTime != null
            ? lastRefreshTime.value
            : this.lastRefreshTime),
        clientId: (clientId != null ? clientId.value : this.clientId),
        scope: (scope != null ? scope.value : this.scope));
  }
}

@JsonSerializable(explicitToJson: true)
class TokenResponseDTO {
  const TokenResponseDTO({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.scope,
    this.user,
  });

  factory TokenResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseDTOFromJson(json);

  static const toJsonFactory = _$TokenResponseDTOToJson;
  Map<String, dynamic> toJson() => _$TokenResponseDTOToJson(this);

  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'scope')
  final String? scope;
  @JsonKey(name: 'user')
  final UserDTO? user;
  static const fromJsonFactory = _$TokenResponseDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenResponseDTO &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.tokenType, tokenType) ||
                const DeepCollectionEquality()
                    .equals(other.tokenType, tokenType)) &&
            (identical(other.expiresIn, expiresIn) ||
                const DeepCollectionEquality()
                    .equals(other.expiresIn, expiresIn)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(tokenType) ^
      const DeepCollectionEquality().hash(expiresIn) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(scope) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $TokenResponseDTOExtension on TokenResponseDTO {
  TokenResponseDTO copyWith(
      {String? accessToken,
      String? tokenType,
      int? expiresIn,
      String? refreshToken,
      String? scope,
      UserDTO? user}) {
    return TokenResponseDTO(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        refreshToken: refreshToken ?? this.refreshToken,
        scope: scope ?? this.scope,
        user: user ?? this.user);
  }

  TokenResponseDTO copyWithWrapped(
      {Wrapped<String?>? accessToken,
      Wrapped<String?>? tokenType,
      Wrapped<int?>? expiresIn,
      Wrapped<String?>? refreshToken,
      Wrapped<String?>? scope,
      Wrapped<UserDTO?>? user}) {
    return TokenResponseDTO(
        accessToken:
            (accessToken != null ? accessToken.value : this.accessToken),
        tokenType: (tokenType != null ? tokenType.value : this.tokenType),
        expiresIn: (expiresIn != null ? expiresIn.value : this.expiresIn),
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken),
        scope: (scope != null ? scope.value : this.scope),
        user: (user != null ? user.value : this.user));
  }
}

@JsonSerializable(explicitToJson: true)
class UserDTO {
  const UserDTO({
    this.name,
    this.roles,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  static const toJsonFactory = _$UserDTOToJson;
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'roles', defaultValue: <String>[])
  final List<String>? roles;
  static const fromJsonFactory = _$UserDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.roles, roles) ||
                const DeepCollectionEquality().equals(other.roles, roles)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(roles) ^
      runtimeType.hashCode;
}

extension $UserDTOExtension on UserDTO {
  UserDTO copyWith({String? name, List<String>? roles}) {
    return UserDTO(name: name ?? this.name, roles: roles ?? this.roles);
  }

  UserDTO copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<List<String>?>? roles}) {
    return UserDTO(
        name: (name != null ? name.value : this.name),
        roles: (roles != null ? roles.value : this.roles));
  }
}

@JsonSerializable(explicitToJson: true)
class Addon {
  const Addon({
    this.uid,
    this.id,
    this.label,
    this.version,
    this.maturity,
    this.compatible,
    this.contentType,
    this.link,
    this.author,
    this.verifiedAuthor,
    this.installed,
    this.type,
    this.description,
    this.detailedDescription,
    this.configDescriptionURI,
    this.keywords,
    this.countries,
    this.license,
    this.connection,
    this.backgroundColor,
    this.imageLink,
    this.properties,
    this.loggerPackages,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => _$AddonFromJson(json);

  static const toJsonFactory = _$AddonToJson;
  Map<String, dynamic> toJson() => _$AddonToJson(this);

  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'maturity')
  final String? maturity;
  @JsonKey(name: 'compatible')
  final bool? compatible;
  @JsonKey(name: 'contentType')
  final String? contentType;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'author')
  final String? author;
  @JsonKey(name: 'verifiedAuthor')
  final bool? verifiedAuthor;
  @JsonKey(name: 'installed')
  final bool? installed;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'detailedDescription')
  final String? detailedDescription;
  @JsonKey(name: 'configDescriptionURI')
  final String? configDescriptionURI;
  @JsonKey(name: 'keywords')
  final String? keywords;
  @JsonKey(name: 'countries', defaultValue: <String>[])
  final List<String>? countries;
  @JsonKey(name: 'license')
  final String? license;
  @JsonKey(name: 'connection')
  final String? connection;
  @JsonKey(name: 'backgroundColor')
  final String? backgroundColor;
  @JsonKey(name: 'imageLink')
  final String? imageLink;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  @JsonKey(name: 'loggerPackages', defaultValue: <String>[])
  final List<String>? loggerPackages;
  static const fromJsonFactory = _$AddonFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Addon &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.maturity, maturity) ||
                const DeepCollectionEquality()
                    .equals(other.maturity, maturity)) &&
            (identical(other.compatible, compatible) ||
                const DeepCollectionEquality()
                    .equals(other.compatible, compatible)) &&
            (identical(other.contentType, contentType) ||
                const DeepCollectionEquality()
                    .equals(other.contentType, contentType)) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.verifiedAuthor, verifiedAuthor) ||
                const DeepCollectionEquality()
                    .equals(other.verifiedAuthor, verifiedAuthor)) &&
            (identical(other.installed, installed) ||
                const DeepCollectionEquality()
                    .equals(other.installed, installed)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.detailedDescription, detailedDescription) ||
                const DeepCollectionEquality()
                    .equals(other.detailedDescription, detailedDescription)) &&
            (identical(other.configDescriptionURI, configDescriptionURI) ||
                const DeepCollectionEquality().equals(
                    other.configDescriptionURI, configDescriptionURI)) &&
            (identical(other.keywords, keywords) ||
                const DeepCollectionEquality()
                    .equals(other.keywords, keywords)) &&
            (identical(other.countries, countries) ||
                const DeepCollectionEquality()
                    .equals(other.countries, countries)) &&
            (identical(other.license, license) ||
                const DeepCollectionEquality()
                    .equals(other.license, license)) &&
            (identical(other.connection, connection) ||
                const DeepCollectionEquality()
                    .equals(other.connection, connection)) &&
            (identical(other.backgroundColor, backgroundColor) ||
                const DeepCollectionEquality()
                    .equals(other.backgroundColor, backgroundColor)) &&
            (identical(other.imageLink, imageLink) ||
                const DeepCollectionEquality()
                    .equals(other.imageLink, imageLink)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(other.loggerPackages, loggerPackages) ||
                const DeepCollectionEquality()
                    .equals(other.loggerPackages, loggerPackages)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(maturity) ^
      const DeepCollectionEquality().hash(compatible) ^
      const DeepCollectionEquality().hash(contentType) ^
      const DeepCollectionEquality().hash(link) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(verifiedAuthor) ^
      const DeepCollectionEquality().hash(installed) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(detailedDescription) ^
      const DeepCollectionEquality().hash(configDescriptionURI) ^
      const DeepCollectionEquality().hash(keywords) ^
      const DeepCollectionEquality().hash(countries) ^
      const DeepCollectionEquality().hash(license) ^
      const DeepCollectionEquality().hash(connection) ^
      const DeepCollectionEquality().hash(backgroundColor) ^
      const DeepCollectionEquality().hash(imageLink) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(loggerPackages) ^
      runtimeType.hashCode;
}

extension $AddonExtension on Addon {
  Addon copyWith(
      {String? uid,
      String? id,
      String? label,
      String? version,
      String? maturity,
      bool? compatible,
      String? contentType,
      String? link,
      String? author,
      bool? verifiedAuthor,
      bool? installed,
      String? type,
      String? description,
      String? detailedDescription,
      String? configDescriptionURI,
      String? keywords,
      List<String>? countries,
      String? license,
      String? connection,
      String? backgroundColor,
      String? imageLink,
      Map<String, dynamic>? properties,
      List<String>? loggerPackages}) {
    return Addon(
        uid: uid ?? this.uid,
        id: id ?? this.id,
        label: label ?? this.label,
        version: version ?? this.version,
        maturity: maturity ?? this.maturity,
        compatible: compatible ?? this.compatible,
        contentType: contentType ?? this.contentType,
        link: link ?? this.link,
        author: author ?? this.author,
        verifiedAuthor: verifiedAuthor ?? this.verifiedAuthor,
        installed: installed ?? this.installed,
        type: type ?? this.type,
        description: description ?? this.description,
        detailedDescription: detailedDescription ?? this.detailedDescription,
        configDescriptionURI: configDescriptionURI ?? this.configDescriptionURI,
        keywords: keywords ?? this.keywords,
        countries: countries ?? this.countries,
        license: license ?? this.license,
        connection: connection ?? this.connection,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        imageLink: imageLink ?? this.imageLink,
        properties: properties ?? this.properties,
        loggerPackages: loggerPackages ?? this.loggerPackages);
  }

  Addon copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<String?>? version,
      Wrapped<String?>? maturity,
      Wrapped<bool?>? compatible,
      Wrapped<String?>? contentType,
      Wrapped<String?>? link,
      Wrapped<String?>? author,
      Wrapped<bool?>? verifiedAuthor,
      Wrapped<bool?>? installed,
      Wrapped<String?>? type,
      Wrapped<String?>? description,
      Wrapped<String?>? detailedDescription,
      Wrapped<String?>? configDescriptionURI,
      Wrapped<String?>? keywords,
      Wrapped<List<String>?>? countries,
      Wrapped<String?>? license,
      Wrapped<String?>? connection,
      Wrapped<String?>? backgroundColor,
      Wrapped<String?>? imageLink,
      Wrapped<Map<String, dynamic>?>? properties,
      Wrapped<List<String>?>? loggerPackages}) {
    return Addon(
        uid: (uid != null ? uid.value : this.uid),
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        version: (version != null ? version.value : this.version),
        maturity: (maturity != null ? maturity.value : this.maturity),
        compatible: (compatible != null ? compatible.value : this.compatible),
        contentType:
            (contentType != null ? contentType.value : this.contentType),
        link: (link != null ? link.value : this.link),
        author: (author != null ? author.value : this.author),
        verifiedAuthor: (verifiedAuthor != null
            ? verifiedAuthor.value
            : this.verifiedAuthor),
        installed: (installed != null ? installed.value : this.installed),
        type: (type != null ? type.value : this.type),
        description:
            (description != null ? description.value : this.description),
        detailedDescription: (detailedDescription != null
            ? detailedDescription.value
            : this.detailedDescription),
        configDescriptionURI: (configDescriptionURI != null
            ? configDescriptionURI.value
            : this.configDescriptionURI),
        keywords: (keywords != null ? keywords.value : this.keywords),
        countries: (countries != null ? countries.value : this.countries),
        license: (license != null ? license.value : this.license),
        connection: (connection != null ? connection.value : this.connection),
        backgroundColor: (backgroundColor != null
            ? backgroundColor.value
            : this.backgroundColor),
        imageLink: (imageLink != null ? imageLink.value : this.imageLink),
        properties: (properties != null ? properties.value : this.properties),
        loggerPackages: (loggerPackages != null
            ? loggerPackages.value
            : this.loggerPackages));
  }
}

@JsonSerializable(explicitToJson: true)
class AddonType {
  const AddonType({
    this.id,
    this.label,
  });

  factory AddonType.fromJson(Map<String, dynamic> json) =>
      _$AddonTypeFromJson(json);

  static const toJsonFactory = _$AddonTypeToJson;
  Map<String, dynamic> toJson() => _$AddonTypeToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  static const fromJsonFactory = _$AddonTypeFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AddonType &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      runtimeType.hashCode;
}

extension $AddonTypeExtension on AddonType {
  AddonType copyWith({String? id, String? label}) {
    return AddonType(id: id ?? this.id, label: label ?? this.label);
  }

  AddonType copyWithWrapped({Wrapped<String?>? id, Wrapped<String?>? label}) {
    return AddonType(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label));
  }
}

@JsonSerializable(explicitToJson: true)
class ChannelTypeDTO {
  const ChannelTypeDTO({
    this.parameters,
    this.parameterGroups,
    this.description,
    this.label,
    this.category,
    this.itemType,
    this.kind,
    this.stateDescription,
    this.tags,
    this.uid,
    this.advanced,
    this.commandDescription,
  });

  factory ChannelTypeDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelTypeDTOFromJson(json);

  static const toJsonFactory = _$ChannelTypeDTOToJson;
  Map<String, dynamic> toJson() => _$ChannelTypeDTOToJson(this);

  @JsonKey(name: 'parameters', defaultValue: <ConfigDescriptionParameterDTO>[])
  final List<ConfigDescriptionParameterDTO>? parameters;
  @JsonKey(
      name: 'parameterGroups',
      defaultValue: <ConfigDescriptionParameterGroupDTO>[])
  final List<ConfigDescriptionParameterGroupDTO>? parameterGroups;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'itemType')
  final String? itemType;
  @JsonKey(name: 'kind')
  final String? kind;
  @JsonKey(name: 'stateDescription')
  final StateDescription? stateDescription;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'UID')
  final String? uid;
  @JsonKey(name: 'advanced')
  final bool? advanced;
  @JsonKey(name: 'commandDescription')
  final CommandDescription? commandDescription;
  static const fromJsonFactory = _$ChannelTypeDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChannelTypeDTO &&
            (identical(other.parameters, parameters) ||
                const DeepCollectionEquality()
                    .equals(other.parameters, parameters)) &&
            (identical(other.parameterGroups, parameterGroups) ||
                const DeepCollectionEquality()
                    .equals(other.parameterGroups, parameterGroups)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.itemType, itemType) ||
                const DeepCollectionEquality()
                    .equals(other.itemType, itemType)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.stateDescription, stateDescription) ||
                const DeepCollectionEquality()
                    .equals(other.stateDescription, stateDescription)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.advanced, advanced) ||
                const DeepCollectionEquality()
                    .equals(other.advanced, advanced)) &&
            (identical(other.commandDescription, commandDescription) ||
                const DeepCollectionEquality()
                    .equals(other.commandDescription, commandDescription)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(parameters) ^
      const DeepCollectionEquality().hash(parameterGroups) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(itemType) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(stateDescription) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(advanced) ^
      const DeepCollectionEquality().hash(commandDescription) ^
      runtimeType.hashCode;
}

extension $ChannelTypeDTOExtension on ChannelTypeDTO {
  ChannelTypeDTO copyWith(
      {List<ConfigDescriptionParameterDTO>? parameters,
      List<ConfigDescriptionParameterGroupDTO>? parameterGroups,
      String? description,
      String? label,
      String? category,
      String? itemType,
      String? kind,
      StateDescription? stateDescription,
      List<String>? tags,
      String? uid,
      bool? advanced,
      CommandDescription? commandDescription}) {
    return ChannelTypeDTO(
        parameters: parameters ?? this.parameters,
        parameterGroups: parameterGroups ?? this.parameterGroups,
        description: description ?? this.description,
        label: label ?? this.label,
        category: category ?? this.category,
        itemType: itemType ?? this.itemType,
        kind: kind ?? this.kind,
        stateDescription: stateDescription ?? this.stateDescription,
        tags: tags ?? this.tags,
        uid: uid ?? this.uid,
        advanced: advanced ?? this.advanced,
        commandDescription: commandDescription ?? this.commandDescription);
  }

  ChannelTypeDTO copyWithWrapped(
      {Wrapped<List<ConfigDescriptionParameterDTO>?>? parameters,
      Wrapped<List<ConfigDescriptionParameterGroupDTO>?>? parameterGroups,
      Wrapped<String?>? description,
      Wrapped<String?>? label,
      Wrapped<String?>? category,
      Wrapped<String?>? itemType,
      Wrapped<String?>? kind,
      Wrapped<StateDescription?>? stateDescription,
      Wrapped<List<String>?>? tags,
      Wrapped<String?>? uid,
      Wrapped<bool?>? advanced,
      Wrapped<CommandDescription?>? commandDescription}) {
    return ChannelTypeDTO(
        parameters: (parameters != null ? parameters.value : this.parameters),
        parameterGroups: (parameterGroups != null
            ? parameterGroups.value
            : this.parameterGroups),
        description:
            (description != null ? description.value : this.description),
        label: (label != null ? label.value : this.label),
        category: (category != null ? category.value : this.category),
        itemType: (itemType != null ? itemType.value : this.itemType),
        kind: (kind != null ? kind.value : this.kind),
        stateDescription: (stateDescription != null
            ? stateDescription.value
            : this.stateDescription),
        tags: (tags != null ? tags.value : this.tags),
        uid: (uid != null ? uid.value : this.uid),
        advanced: (advanced != null ? advanced.value : this.advanced),
        commandDescription: (commandDescription != null
            ? commandDescription.value
            : this.commandDescription));
  }
}

@JsonSerializable(explicitToJson: true)
class CommandDescription {
  const CommandDescription({
    this.commandOptions,
  });

  factory CommandDescription.fromJson(Map<String, dynamic> json) =>
      _$CommandDescriptionFromJson(json);

  static const toJsonFactory = _$CommandDescriptionToJson;
  Map<String, dynamic> toJson() => _$CommandDescriptionToJson(this);

  @JsonKey(name: 'commandOptions', defaultValue: <CommandOption>[])
  final List<CommandOption>? commandOptions;
  static const fromJsonFactory = _$CommandDescriptionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CommandDescription &&
            (identical(other.commandOptions, commandOptions) ||
                const DeepCollectionEquality()
                    .equals(other.commandOptions, commandOptions)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(commandOptions) ^
      runtimeType.hashCode;
}

extension $CommandDescriptionExtension on CommandDescription {
  CommandDescription copyWith({List<CommandOption>? commandOptions}) {
    return CommandDescription(
        commandOptions: commandOptions ?? this.commandOptions);
  }

  CommandDescription copyWithWrapped(
      {Wrapped<List<CommandOption>?>? commandOptions}) {
    return CommandDescription(
        commandOptions: (commandOptions != null
            ? commandOptions.value
            : this.commandOptions));
  }
}

@JsonSerializable(explicitToJson: true)
class CommandOption {
  const CommandOption({
    this.command,
    this.label,
  });

  factory CommandOption.fromJson(Map<String, dynamic> json) =>
      _$CommandOptionFromJson(json);

  static const toJsonFactory = _$CommandOptionToJson;
  Map<String, dynamic> toJson() => _$CommandOptionToJson(this);

  @JsonKey(name: 'command')
  final String? command;
  @JsonKey(name: 'label')
  final String? label;
  static const fromJsonFactory = _$CommandOptionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CommandOption &&
            (identical(other.command, command) ||
                const DeepCollectionEquality()
                    .equals(other.command, command)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(command) ^
      const DeepCollectionEquality().hash(label) ^
      runtimeType.hashCode;
}

extension $CommandOptionExtension on CommandOption {
  CommandOption copyWith({String? command, String? label}) {
    return CommandOption(
        command: command ?? this.command, label: label ?? this.label);
  }

  CommandOption copyWithWrapped(
      {Wrapped<String?>? command, Wrapped<String?>? label}) {
    return CommandOption(
        command: (command != null ? command.value : this.command),
        label: (label != null ? label.value : this.label));
  }
}

@JsonSerializable(explicitToJson: true)
class ConfigDescriptionParameterGroupDTO {
  const ConfigDescriptionParameterGroupDTO({
    this.name,
    this.context,
    this.advanced,
    this.label,
    this.description,
  });

  factory ConfigDescriptionParameterGroupDTO.fromJson(
          Map<String, dynamic> json) =>
      _$ConfigDescriptionParameterGroupDTOFromJson(json);

  static const toJsonFactory = _$ConfigDescriptionParameterGroupDTOToJson;
  Map<String, dynamic> toJson() =>
      _$ConfigDescriptionParameterGroupDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'context')
  final String? context;
  @JsonKey(name: 'advanced')
  final bool? advanced;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$ConfigDescriptionParameterGroupDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ConfigDescriptionParameterGroupDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.context, context) ||
                const DeepCollectionEquality()
                    .equals(other.context, context)) &&
            (identical(other.advanced, advanced) ||
                const DeepCollectionEquality()
                    .equals(other.advanced, advanced)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(context) ^
      const DeepCollectionEquality().hash(advanced) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $ConfigDescriptionParameterGroupDTOExtension
    on ConfigDescriptionParameterGroupDTO {
  ConfigDescriptionParameterGroupDTO copyWith(
      {String? name,
      String? context,
      bool? advanced,
      String? label,
      String? description}) {
    return ConfigDescriptionParameterGroupDTO(
        name: name ?? this.name,
        context: context ?? this.context,
        advanced: advanced ?? this.advanced,
        label: label ?? this.label,
        description: description ?? this.description);
  }

  ConfigDescriptionParameterGroupDTO copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? context,
      Wrapped<bool?>? advanced,
      Wrapped<String?>? label,
      Wrapped<String?>? description}) {
    return ConfigDescriptionParameterGroupDTO(
        name: (name != null ? name.value : this.name),
        context: (context != null ? context.value : this.context),
        advanced: (advanced != null ? advanced.value : this.advanced),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class StateDescription {
  const StateDescription({
    this.minimum,
    this.maximum,
    this.step,
    this.pattern,
    this.readOnly,
    this.options,
  });

  factory StateDescription.fromJson(Map<String, dynamic> json) =>
      _$StateDescriptionFromJson(json);

  static const toJsonFactory = _$StateDescriptionToJson;
  Map<String, dynamic> toJson() => _$StateDescriptionToJson(this);

  @JsonKey(name: 'minimum')
  final double? minimum;
  @JsonKey(name: 'maximum')
  final double? maximum;
  @JsonKey(name: 'step')
  final double? step;
  @JsonKey(name: 'pattern')
  final String? pattern;
  @JsonKey(name: 'readOnly')
  final bool? readOnly;
  @JsonKey(name: 'options', defaultValue: <StateOption>[])
  final List<StateOption>? options;
  static const fromJsonFactory = _$StateDescriptionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StateDescription &&
            (identical(other.minimum, minimum) ||
                const DeepCollectionEquality()
                    .equals(other.minimum, minimum)) &&
            (identical(other.maximum, maximum) ||
                const DeepCollectionEquality()
                    .equals(other.maximum, maximum)) &&
            (identical(other.step, step) ||
                const DeepCollectionEquality().equals(other.step, step)) &&
            (identical(other.pattern, pattern) ||
                const DeepCollectionEquality()
                    .equals(other.pattern, pattern)) &&
            (identical(other.readOnly, readOnly) ||
                const DeepCollectionEquality()
                    .equals(other.readOnly, readOnly)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(minimum) ^
      const DeepCollectionEquality().hash(maximum) ^
      const DeepCollectionEquality().hash(step) ^
      const DeepCollectionEquality().hash(pattern) ^
      const DeepCollectionEquality().hash(readOnly) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $StateDescriptionExtension on StateDescription {
  StateDescription copyWith(
      {double? minimum,
      double? maximum,
      double? step,
      String? pattern,
      bool? readOnly,
      List<StateOption>? options}) {
    return StateDescription(
        minimum: minimum ?? this.minimum,
        maximum: maximum ?? this.maximum,
        step: step ?? this.step,
        pattern: pattern ?? this.pattern,
        readOnly: readOnly ?? this.readOnly,
        options: options ?? this.options);
  }

  StateDescription copyWithWrapped(
      {Wrapped<double?>? minimum,
      Wrapped<double?>? maximum,
      Wrapped<double?>? step,
      Wrapped<String?>? pattern,
      Wrapped<bool?>? readOnly,
      Wrapped<List<StateOption>?>? options}) {
    return StateDescription(
        minimum: (minimum != null ? minimum.value : this.minimum),
        maximum: (maximum != null ? maximum.value : this.maximum),
        step: (step != null ? step.value : this.step),
        pattern: (pattern != null ? pattern.value : this.pattern),
        readOnly: (readOnly != null ? readOnly.value : this.readOnly),
        options: (options != null ? options.value : this.options));
  }
}

@JsonSerializable(explicitToJson: true)
class StateOption {
  const StateOption({
    this.$value,
    this.label,
  });

  factory StateOption.fromJson(Map<String, dynamic> json) =>
      _$StateOptionFromJson(json);

  static const toJsonFactory = _$StateOptionToJson;
  Map<String, dynamic> toJson() => _$StateOptionToJson(this);

  @JsonKey(name: 'value')
  final String? $value;
  @JsonKey(name: 'label')
  final String? label;
  static const fromJsonFactory = _$StateOptionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StateOption &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^
      const DeepCollectionEquality().hash(label) ^
      runtimeType.hashCode;
}

extension $StateOptionExtension on StateOption {
  StateOption copyWith({String? $value, String? label}) {
    return StateOption(
        $value: $value ?? this.$value, label: label ?? this.label);
  }

  StateOption copyWithWrapped(
      {Wrapped<String?>? $value, Wrapped<String?>? label}) {
    return StateOption(
        $value: ($value != null ? $value.value : this.$value),
        label: (label != null ? label.value : this.label));
  }
}

@JsonSerializable(explicitToJson: true)
class ConfigDescriptionDTO {
  const ConfigDescriptionDTO({
    this.uri,
    this.parameters,
    this.parameterGroups,
  });

  factory ConfigDescriptionDTO.fromJson(Map<String, dynamic> json) =>
      _$ConfigDescriptionDTOFromJson(json);

  static const toJsonFactory = _$ConfigDescriptionDTOToJson;
  Map<String, dynamic> toJson() => _$ConfigDescriptionDTOToJson(this);

  @JsonKey(name: 'uri')
  final String? uri;
  @JsonKey(name: 'parameters', defaultValue: <ConfigDescriptionParameterDTO>[])
  final List<ConfigDescriptionParameterDTO>? parameters;
  @JsonKey(
      name: 'parameterGroups',
      defaultValue: <ConfigDescriptionParameterGroupDTO>[])
  final List<ConfigDescriptionParameterGroupDTO>? parameterGroups;
  static const fromJsonFactory = _$ConfigDescriptionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ConfigDescriptionDTO &&
            (identical(other.uri, uri) ||
                const DeepCollectionEquality().equals(other.uri, uri)) &&
            (identical(other.parameters, parameters) ||
                const DeepCollectionEquality()
                    .equals(other.parameters, parameters)) &&
            (identical(other.parameterGroups, parameterGroups) ||
                const DeepCollectionEquality()
                    .equals(other.parameterGroups, parameterGroups)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uri) ^
      const DeepCollectionEquality().hash(parameters) ^
      const DeepCollectionEquality().hash(parameterGroups) ^
      runtimeType.hashCode;
}

extension $ConfigDescriptionDTOExtension on ConfigDescriptionDTO {
  ConfigDescriptionDTO copyWith(
      {String? uri,
      List<ConfigDescriptionParameterDTO>? parameters,
      List<ConfigDescriptionParameterGroupDTO>? parameterGroups}) {
    return ConfigDescriptionDTO(
        uri: uri ?? this.uri,
        parameters: parameters ?? this.parameters,
        parameterGroups: parameterGroups ?? this.parameterGroups);
  }

  ConfigDescriptionDTO copyWithWrapped(
      {Wrapped<String?>? uri,
      Wrapped<List<ConfigDescriptionParameterDTO>?>? parameters,
      Wrapped<List<ConfigDescriptionParameterGroupDTO>?>? parameterGroups}) {
    return ConfigDescriptionDTO(
        uri: (uri != null ? uri.value : this.uri),
        parameters: (parameters != null ? parameters.value : this.parameters),
        parameterGroups: (parameterGroups != null
            ? parameterGroups.value
            : this.parameterGroups));
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoveryResultDTO {
  const DiscoveryResultDTO({
    this.bridgeUID,
    this.flag,
    this.label,
    this.properties,
    this.representationProperty,
    this.thingUID,
    this.thingTypeUID,
  });

  factory DiscoveryResultDTO.fromJson(Map<String, dynamic> json) =>
      _$DiscoveryResultDTOFromJson(json);

  static const toJsonFactory = _$DiscoveryResultDTOToJson;
  Map<String, dynamic> toJson() => _$DiscoveryResultDTOToJson(this);

  @JsonKey(name: 'bridgeUID')
  final String? bridgeUID;
  @JsonKey(
    name: 'flag',
    toJson: discoveryResultDTOFlagNullableToJson,
    fromJson: discoveryResultDTOFlagNullableFromJson,
  )
  final enums.DiscoveryResultDTOFlag? flag;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  @JsonKey(name: 'representationProperty')
  final String? representationProperty;
  @JsonKey(name: 'thingUID')
  final String? thingUID;
  @JsonKey(name: 'thingTypeUID')
  final String? thingTypeUID;
  static const fromJsonFactory = _$DiscoveryResultDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DiscoveryResultDTO &&
            (identical(other.bridgeUID, bridgeUID) ||
                const DeepCollectionEquality()
                    .equals(other.bridgeUID, bridgeUID)) &&
            (identical(other.flag, flag) ||
                const DeepCollectionEquality().equals(other.flag, flag)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(other.representationProperty, representationProperty) ||
                const DeepCollectionEquality().equals(
                    other.representationProperty, representationProperty)) &&
            (identical(other.thingUID, thingUID) ||
                const DeepCollectionEquality()
                    .equals(other.thingUID, thingUID)) &&
            (identical(other.thingTypeUID, thingTypeUID) ||
                const DeepCollectionEquality()
                    .equals(other.thingTypeUID, thingTypeUID)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bridgeUID) ^
      const DeepCollectionEquality().hash(flag) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(representationProperty) ^
      const DeepCollectionEquality().hash(thingUID) ^
      const DeepCollectionEquality().hash(thingTypeUID) ^
      runtimeType.hashCode;
}

extension $DiscoveryResultDTOExtension on DiscoveryResultDTO {
  DiscoveryResultDTO copyWith(
      {String? bridgeUID,
      enums.DiscoveryResultDTOFlag? flag,
      String? label,
      Map<String, dynamic>? properties,
      String? representationProperty,
      String? thingUID,
      String? thingTypeUID}) {
    return DiscoveryResultDTO(
        bridgeUID: bridgeUID ?? this.bridgeUID,
        flag: flag ?? this.flag,
        label: label ?? this.label,
        properties: properties ?? this.properties,
        representationProperty:
            representationProperty ?? this.representationProperty,
        thingUID: thingUID ?? this.thingUID,
        thingTypeUID: thingTypeUID ?? this.thingTypeUID);
  }

  DiscoveryResultDTO copyWithWrapped(
      {Wrapped<String?>? bridgeUID,
      Wrapped<enums.DiscoveryResultDTOFlag?>? flag,
      Wrapped<String?>? label,
      Wrapped<Map<String, dynamic>?>? properties,
      Wrapped<String?>? representationProperty,
      Wrapped<String?>? thingUID,
      Wrapped<String?>? thingTypeUID}) {
    return DiscoveryResultDTO(
        bridgeUID: (bridgeUID != null ? bridgeUID.value : this.bridgeUID),
        flag: (flag != null ? flag.value : this.flag),
        label: (label != null ? label.value : this.label),
        properties: (properties != null ? properties.value : this.properties),
        representationProperty: (representationProperty != null
            ? representationProperty.value
            : this.representationProperty),
        thingUID: (thingUID != null ? thingUID.value : this.thingUID),
        thingTypeUID:
            (thingTypeUID != null ? thingTypeUID.value : this.thingTypeUID));
  }
}

@JsonSerializable(explicitToJson: true)
class MetadataDTO {
  const MetadataDTO({
    this.$value,
    this.config,
  });

  factory MetadataDTO.fromJson(Map<String, dynamic> json) =>
      _$MetadataDTOFromJson(json);

  static const toJsonFactory = _$MetadataDTOToJson;
  Map<String, dynamic> toJson() => _$MetadataDTOToJson(this);

  @JsonKey(name: 'value')
  final String? $value;
  @JsonKey(name: 'config')
  final Map<String, dynamic>? config;
  static const fromJsonFactory = _$MetadataDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MetadataDTO &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)) &&
            (identical(other.config, config) ||
                const DeepCollectionEquality().equals(other.config, config)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^
      const DeepCollectionEquality().hash(config) ^
      runtimeType.hashCode;
}

extension $MetadataDTOExtension on MetadataDTO {
  MetadataDTO copyWith({String? $value, Map<String, dynamic>? config}) {
    return MetadataDTO(
        $value: $value ?? this.$value, config: config ?? this.config);
  }

  MetadataDTO copyWithWrapped(
      {Wrapped<String?>? $value, Wrapped<Map<String, dynamic>?>? config}) {
    return MetadataDTO(
        $value: ($value != null ? $value.value : this.$value),
        config: (config != null ? config.value : this.config));
  }
}

@JsonSerializable(explicitToJson: true)
class EnrichedItemDTO {
  const EnrichedItemDTO({
    this.type,
    this.name,
    this.label,
    this.category,
    this.tags,
    this.groupNames,
    this.link,
    this.state,
    this.transformedState,
    this.stateDescription,
    this.unitSymbol,
    this.commandDescription,
    this.metadata,
    this.editable,
  });

  factory EnrichedItemDTO.fromJson(Map<String, dynamic> json) =>
      _$EnrichedItemDTOFromJson(json);

  static const toJsonFactory = _$EnrichedItemDTOToJson;
  Map<String, dynamic> toJson() => _$EnrichedItemDTOToJson(this);

  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'groupNames', defaultValue: <String>[])
  final List<String>? groupNames;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'transformedState')
  final String? transformedState;
  @JsonKey(name: 'stateDescription')
  final StateDescription? stateDescription;
  @JsonKey(name: 'unitSymbol')
  final String? unitSymbol;
  @JsonKey(name: 'commandDescription')
  final CommandDescription? commandDescription;
  @JsonKey(name: 'metadata')
  final Map<String, dynamic>? metadata;
  @JsonKey(name: 'editable')
  final bool? editable;
  static const fromJsonFactory = _$EnrichedItemDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EnrichedItemDTO &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.groupNames, groupNames) ||
                const DeepCollectionEquality()
                    .equals(other.groupNames, groupNames)) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.transformedState, transformedState) ||
                const DeepCollectionEquality()
                    .equals(other.transformedState, transformedState)) &&
            (identical(other.stateDescription, stateDescription) ||
                const DeepCollectionEquality()
                    .equals(other.stateDescription, stateDescription)) &&
            (identical(other.unitSymbol, unitSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.unitSymbol, unitSymbol)) &&
            (identical(other.commandDescription, commandDescription) ||
                const DeepCollectionEquality()
                    .equals(other.commandDescription, commandDescription)) &&
            (identical(other.metadata, metadata) ||
                const DeepCollectionEquality()
                    .equals(other.metadata, metadata)) &&
            (identical(other.editable, editable) ||
                const DeepCollectionEquality()
                    .equals(other.editable, editable)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(groupNames) ^
      const DeepCollectionEquality().hash(link) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(transformedState) ^
      const DeepCollectionEquality().hash(stateDescription) ^
      const DeepCollectionEquality().hash(unitSymbol) ^
      const DeepCollectionEquality().hash(commandDescription) ^
      const DeepCollectionEquality().hash(metadata) ^
      const DeepCollectionEquality().hash(editable) ^
      runtimeType.hashCode;
}

extension $EnrichedItemDTOExtension on EnrichedItemDTO {
  EnrichedItemDTO copyWith(
      {String? type,
      String? name,
      String? label,
      String? category,
      List<String>? tags,
      List<String>? groupNames,
      String? link,
      String? state,
      String? transformedState,
      StateDescription? stateDescription,
      String? unitSymbol,
      CommandDescription? commandDescription,
      Map<String, dynamic>? metadata,
      bool? editable}) {
    return EnrichedItemDTO(
        type: type ?? this.type,
        name: name ?? this.name,
        label: label ?? this.label,
        category: category ?? this.category,
        tags: tags ?? this.tags,
        groupNames: groupNames ?? this.groupNames,
        link: link ?? this.link,
        state: state ?? this.state,
        transformedState: transformedState ?? this.transformedState,
        stateDescription: stateDescription ?? this.stateDescription,
        unitSymbol: unitSymbol ?? this.unitSymbol,
        commandDescription: commandDescription ?? this.commandDescription,
        metadata: metadata ?? this.metadata,
        editable: editable ?? this.editable);
  }

  EnrichedItemDTO copyWithWrapped(
      {Wrapped<String?>? type,
      Wrapped<String?>? name,
      Wrapped<String?>? label,
      Wrapped<String?>? category,
      Wrapped<List<String>?>? tags,
      Wrapped<List<String>?>? groupNames,
      Wrapped<String?>? link,
      Wrapped<String?>? state,
      Wrapped<String?>? transformedState,
      Wrapped<StateDescription?>? stateDescription,
      Wrapped<String?>? unitSymbol,
      Wrapped<CommandDescription?>? commandDescription,
      Wrapped<Map<String, dynamic>?>? metadata,
      Wrapped<bool?>? editable}) {
    return EnrichedItemDTO(
        type: (type != null ? type.value : this.type),
        name: (name != null ? name.value : this.name),
        label: (label != null ? label.value : this.label),
        category: (category != null ? category.value : this.category),
        tags: (tags != null ? tags.value : this.tags),
        groupNames: (groupNames != null ? groupNames.value : this.groupNames),
        link: (link != null ? link.value : this.link),
        state: (state != null ? state.value : this.state),
        transformedState: (transformedState != null
            ? transformedState.value
            : this.transformedState),
        stateDescription: (stateDescription != null
            ? stateDescription.value
            : this.stateDescription),
        unitSymbol: (unitSymbol != null ? unitSymbol.value : this.unitSymbol),
        commandDescription: (commandDescription != null
            ? commandDescription.value
            : this.commandDescription),
        metadata: (metadata != null ? metadata.value : this.metadata),
        editable: (editable != null ? editable.value : this.editable));
  }
}

@JsonSerializable(explicitToJson: true)
class GroupFunctionDTO {
  const GroupFunctionDTO({
    this.name,
    this.params,
  });

  factory GroupFunctionDTO.fromJson(Map<String, dynamic> json) =>
      _$GroupFunctionDTOFromJson(json);

  static const toJsonFactory = _$GroupFunctionDTOToJson;
  Map<String, dynamic> toJson() => _$GroupFunctionDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'params', defaultValue: <String>[])
  final List<String>? params;
  static const fromJsonFactory = _$GroupFunctionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GroupFunctionDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.params, params) ||
                const DeepCollectionEquality().equals(other.params, params)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(params) ^
      runtimeType.hashCode;
}

extension $GroupFunctionDTOExtension on GroupFunctionDTO {
  GroupFunctionDTO copyWith({String? name, List<String>? params}) {
    return GroupFunctionDTO(
        name: name ?? this.name, params: params ?? this.params);
  }

  GroupFunctionDTO copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<List<String>?>? params}) {
    return GroupFunctionDTO(
        name: (name != null ? name.value : this.name),
        params: (params != null ? params.value : this.params));
  }
}

@JsonSerializable(explicitToJson: true)
class GroupItemDTO {
  const GroupItemDTO({
    this.type,
    this.name,
    this.label,
    this.category,
    this.tags,
    this.groupNames,
    this.groupType,
    this.function,
  });

  factory GroupItemDTO.fromJson(Map<String, dynamic> json) =>
      _$GroupItemDTOFromJson(json);

  static const toJsonFactory = _$GroupItemDTOToJson;
  Map<String, dynamic> toJson() => _$GroupItemDTOToJson(this);

  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'groupNames', defaultValue: <String>[])
  final List<String>? groupNames;
  @JsonKey(name: 'groupType')
  final String? groupType;
  @JsonKey(name: 'function')
  final GroupFunctionDTO? function;
  static const fromJsonFactory = _$GroupItemDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GroupItemDTO &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.groupNames, groupNames) ||
                const DeepCollectionEquality()
                    .equals(other.groupNames, groupNames)) &&
            (identical(other.groupType, groupType) ||
                const DeepCollectionEquality()
                    .equals(other.groupType, groupType)) &&
            (identical(other.function, function) ||
                const DeepCollectionEquality()
                    .equals(other.function, function)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(groupNames) ^
      const DeepCollectionEquality().hash(groupType) ^
      const DeepCollectionEquality().hash(function) ^
      runtimeType.hashCode;
}

extension $GroupItemDTOExtension on GroupItemDTO {
  GroupItemDTO copyWith(
      {String? type,
      String? name,
      String? label,
      String? category,
      List<String>? tags,
      List<String>? groupNames,
      String? groupType,
      GroupFunctionDTO? function}) {
    return GroupItemDTO(
        type: type ?? this.type,
        name: name ?? this.name,
        label: label ?? this.label,
        category: category ?? this.category,
        tags: tags ?? this.tags,
        groupNames: groupNames ?? this.groupNames,
        groupType: groupType ?? this.groupType,
        function: function ?? this.function);
  }

  GroupItemDTO copyWithWrapped(
      {Wrapped<String?>? type,
      Wrapped<String?>? name,
      Wrapped<String?>? label,
      Wrapped<String?>? category,
      Wrapped<List<String>?>? tags,
      Wrapped<List<String>?>? groupNames,
      Wrapped<String?>? groupType,
      Wrapped<GroupFunctionDTO?>? function}) {
    return GroupItemDTO(
        type: (type != null ? type.value : this.type),
        name: (name != null ? name.value : this.name),
        label: (label != null ? label.value : this.label),
        category: (category != null ? category.value : this.category),
        tags: (tags != null ? tags.value : this.tags),
        groupNames: (groupNames != null ? groupNames.value : this.groupNames),
        groupType: (groupType != null ? groupType.value : this.groupType),
        function: (function != null ? function.value : this.function));
  }
}

@JsonSerializable(explicitToJson: true)
class EnrichedItemChannelLinkDTO {
  const EnrichedItemChannelLinkDTO({
    this.itemName,
    this.channelUID,
    this.configuration,
    this.editable,
  });

  factory EnrichedItemChannelLinkDTO.fromJson(Map<String, dynamic> json) =>
      _$EnrichedItemChannelLinkDTOFromJson(json);

  static const toJsonFactory = _$EnrichedItemChannelLinkDTOToJson;
  Map<String, dynamic> toJson() => _$EnrichedItemChannelLinkDTOToJson(this);

  @JsonKey(name: 'itemName')
  final String? itemName;
  @JsonKey(name: 'channelUID')
  final String? channelUID;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'editable')
  final bool? editable;
  static const fromJsonFactory = _$EnrichedItemChannelLinkDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EnrichedItemChannelLinkDTO &&
            (identical(other.itemName, itemName) ||
                const DeepCollectionEquality()
                    .equals(other.itemName, itemName)) &&
            (identical(other.channelUID, channelUID) ||
                const DeepCollectionEquality()
                    .equals(other.channelUID, channelUID)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.editable, editable) ||
                const DeepCollectionEquality()
                    .equals(other.editable, editable)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(itemName) ^
      const DeepCollectionEquality().hash(channelUID) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(editable) ^
      runtimeType.hashCode;
}

extension $EnrichedItemChannelLinkDTOExtension on EnrichedItemChannelLinkDTO {
  EnrichedItemChannelLinkDTO copyWith(
      {String? itemName,
      String? channelUID,
      Map<String, dynamic>? configuration,
      bool? editable}) {
    return EnrichedItemChannelLinkDTO(
        itemName: itemName ?? this.itemName,
        channelUID: channelUID ?? this.channelUID,
        configuration: configuration ?? this.configuration,
        editable: editable ?? this.editable);
  }

  EnrichedItemChannelLinkDTO copyWithWrapped(
      {Wrapped<String?>? itemName,
      Wrapped<String?>? channelUID,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<bool?>? editable}) {
    return EnrichedItemChannelLinkDTO(
        itemName: (itemName != null ? itemName.value : this.itemName),
        channelUID: (channelUID != null ? channelUID.value : this.channelUID),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        editable: (editable != null ? editable.value : this.editable));
  }
}

@JsonSerializable(explicitToJson: true)
class ItemChannelLinkDTO {
  const ItemChannelLinkDTO({
    this.itemName,
    this.channelUID,
    this.configuration,
  });

  factory ItemChannelLinkDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemChannelLinkDTOFromJson(json);

  static const toJsonFactory = _$ItemChannelLinkDTOToJson;
  Map<String, dynamic> toJson() => _$ItemChannelLinkDTOToJson(this);

  @JsonKey(name: 'itemName')
  final String? itemName;
  @JsonKey(name: 'channelUID')
  final String? channelUID;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  static const fromJsonFactory = _$ItemChannelLinkDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ItemChannelLinkDTO &&
            (identical(other.itemName, itemName) ||
                const DeepCollectionEquality()
                    .equals(other.itemName, itemName)) &&
            (identical(other.channelUID, channelUID) ||
                const DeepCollectionEquality()
                    .equals(other.channelUID, channelUID)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(itemName) ^
      const DeepCollectionEquality().hash(channelUID) ^
      const DeepCollectionEquality().hash(configuration) ^
      runtimeType.hashCode;
}

extension $ItemChannelLinkDTOExtension on ItemChannelLinkDTO {
  ItemChannelLinkDTO copyWith(
      {String? itemName,
      String? channelUID,
      Map<String, dynamic>? configuration}) {
    return ItemChannelLinkDTO(
        itemName: itemName ?? this.itemName,
        channelUID: channelUID ?? this.channelUID,
        configuration: configuration ?? this.configuration);
  }

  ItemChannelLinkDTO copyWithWrapped(
      {Wrapped<String?>? itemName,
      Wrapped<String?>? channelUID,
      Wrapped<Map<String, dynamic>?>? configuration}) {
    return ItemChannelLinkDTO(
        itemName: (itemName != null ? itemName.value : this.itemName),
        channelUID: (channelUID != null ? channelUID.value : this.channelUID),
        configuration:
            (configuration != null ? configuration.value : this.configuration));
  }
}

@JsonSerializable(explicitToJson: true)
class HistoryDataBean {
  const HistoryDataBean({
    this.time,
    this.state,
  });

  factory HistoryDataBean.fromJson(Map<String, dynamic> json) =>
      _$HistoryDataBeanFromJson(json);

  static const toJsonFactory = _$HistoryDataBeanToJson;
  Map<String, dynamic> toJson() => _$HistoryDataBeanToJson(this);

  @JsonKey(name: 'time')
  final int? time;
  @JsonKey(name: 'state')
  final String? state;
  static const fromJsonFactory = _$HistoryDataBeanFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HistoryDataBean &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(state) ^
      runtimeType.hashCode;
}

extension $HistoryDataBeanExtension on HistoryDataBean {
  HistoryDataBean copyWith({int? time, String? state}) {
    return HistoryDataBean(time: time ?? this.time, state: state ?? this.state);
  }

  HistoryDataBean copyWithWrapped(
      {Wrapped<int?>? time, Wrapped<String?>? state}) {
    return HistoryDataBean(
        time: (time != null ? time.value : this.time),
        state: (state != null ? state.value : this.state));
  }
}

@JsonSerializable(explicitToJson: true)
class ItemHistoryDTO {
  const ItemHistoryDTO({
    this.name,
    this.totalrecords,
    this.datapoints,
    this.data,
  });

  factory ItemHistoryDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemHistoryDTOFromJson(json);

  static const toJsonFactory = _$ItemHistoryDTOToJson;
  Map<String, dynamic> toJson() => _$ItemHistoryDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'totalrecords')
  final String? totalrecords;
  @JsonKey(name: 'datapoints')
  final String? datapoints;
  @JsonKey(name: 'data', defaultValue: <HistoryDataBean>[])
  final List<HistoryDataBean>? data;
  static const fromJsonFactory = _$ItemHistoryDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ItemHistoryDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.totalrecords, totalrecords) ||
                const DeepCollectionEquality()
                    .equals(other.totalrecords, totalrecords)) &&
            (identical(other.datapoints, datapoints) ||
                const DeepCollectionEquality()
                    .equals(other.datapoints, datapoints)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(totalrecords) ^
      const DeepCollectionEquality().hash(datapoints) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $ItemHistoryDTOExtension on ItemHistoryDTO {
  ItemHistoryDTO copyWith(
      {String? name,
      String? totalrecords,
      String? datapoints,
      List<HistoryDataBean>? data}) {
    return ItemHistoryDTO(
        name: name ?? this.name,
        totalrecords: totalrecords ?? this.totalrecords,
        datapoints: datapoints ?? this.datapoints,
        data: data ?? this.data);
  }

  ItemHistoryDTO copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? totalrecords,
      Wrapped<String?>? datapoints,
      Wrapped<List<HistoryDataBean>?>? data}) {
    return ItemHistoryDTO(
        name: (name != null ? name.value : this.name),
        totalrecords:
            (totalrecords != null ? totalrecords.value : this.totalrecords),
        datapoints: (datapoints != null ? datapoints.value : this.datapoints),
        data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class PersistenceCronStrategyDTO {
  const PersistenceCronStrategyDTO({
    this.name,
    this.cronExpression,
  });

  factory PersistenceCronStrategyDTO.fromJson(Map<String, dynamic> json) =>
      _$PersistenceCronStrategyDTOFromJson(json);

  static const toJsonFactory = _$PersistenceCronStrategyDTOToJson;
  Map<String, dynamic> toJson() => _$PersistenceCronStrategyDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'cronExpression')
  final String? cronExpression;
  static const fromJsonFactory = _$PersistenceCronStrategyDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PersistenceCronStrategyDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.cronExpression, cronExpression) ||
                const DeepCollectionEquality()
                    .equals(other.cronExpression, cronExpression)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(cronExpression) ^
      runtimeType.hashCode;
}

extension $PersistenceCronStrategyDTOExtension on PersistenceCronStrategyDTO {
  PersistenceCronStrategyDTO copyWith({String? name, String? cronExpression}) {
    return PersistenceCronStrategyDTO(
        name: name ?? this.name,
        cronExpression: cronExpression ?? this.cronExpression);
  }

  PersistenceCronStrategyDTO copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<String?>? cronExpression}) {
    return PersistenceCronStrategyDTO(
        name: (name != null ? name.value : this.name),
        cronExpression: (cronExpression != null
            ? cronExpression.value
            : this.cronExpression));
  }
}

@JsonSerializable(explicitToJson: true)
class PersistenceFilterDTO {
  const PersistenceFilterDTO({
    this.name,
    this.$value,
    this.relative,
    this.unit,
    this.lower,
    this.upper,
    this.values,
    this.inverted,
  });

  factory PersistenceFilterDTO.fromJson(Map<String, dynamic> json) =>
      _$PersistenceFilterDTOFromJson(json);

  static const toJsonFactory = _$PersistenceFilterDTOToJson;
  Map<String, dynamic> toJson() => _$PersistenceFilterDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'value')
  final double? $value;
  @JsonKey(name: 'relative')
  final bool? relative;
  @JsonKey(name: 'unit')
  final String? unit;
  @JsonKey(name: 'lower')
  final double? lower;
  @JsonKey(name: 'upper')
  final double? upper;
  @JsonKey(name: 'values', defaultValue: <String>[])
  final List<String>? values;
  @JsonKey(name: 'inverted')
  final bool? inverted;
  static const fromJsonFactory = _$PersistenceFilterDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PersistenceFilterDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)) &&
            (identical(other.relative, relative) ||
                const DeepCollectionEquality()
                    .equals(other.relative, relative)) &&
            (identical(other.unit, unit) ||
                const DeepCollectionEquality().equals(other.unit, unit)) &&
            (identical(other.lower, lower) ||
                const DeepCollectionEquality().equals(other.lower, lower)) &&
            (identical(other.upper, upper) ||
                const DeepCollectionEquality().equals(other.upper, upper)) &&
            (identical(other.values, values) ||
                const DeepCollectionEquality().equals(other.values, values)) &&
            (identical(other.inverted, inverted) ||
                const DeepCollectionEquality()
                    .equals(other.inverted, inverted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash($value) ^
      const DeepCollectionEquality().hash(relative) ^
      const DeepCollectionEquality().hash(unit) ^
      const DeepCollectionEquality().hash(lower) ^
      const DeepCollectionEquality().hash(upper) ^
      const DeepCollectionEquality().hash(values) ^
      const DeepCollectionEquality().hash(inverted) ^
      runtimeType.hashCode;
}

extension $PersistenceFilterDTOExtension on PersistenceFilterDTO {
  PersistenceFilterDTO copyWith(
      {String? name,
      double? $value,
      bool? relative,
      String? unit,
      double? lower,
      double? upper,
      List<String>? values,
      bool? inverted}) {
    return PersistenceFilterDTO(
        name: name ?? this.name,
        $value: $value ?? this.$value,
        relative: relative ?? this.relative,
        unit: unit ?? this.unit,
        lower: lower ?? this.lower,
        upper: upper ?? this.upper,
        values: values ?? this.values,
        inverted: inverted ?? this.inverted);
  }

  PersistenceFilterDTO copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<double?>? $value,
      Wrapped<bool?>? relative,
      Wrapped<String?>? unit,
      Wrapped<double?>? lower,
      Wrapped<double?>? upper,
      Wrapped<List<String>?>? values,
      Wrapped<bool?>? inverted}) {
    return PersistenceFilterDTO(
        name: (name != null ? name.value : this.name),
        $value: ($value != null ? $value.value : this.$value),
        relative: (relative != null ? relative.value : this.relative),
        unit: (unit != null ? unit.value : this.unit),
        lower: (lower != null ? lower.value : this.lower),
        upper: (upper != null ? upper.value : this.upper),
        values: (values != null ? values.value : this.values),
        inverted: (inverted != null ? inverted.value : this.inverted));
  }
}

@JsonSerializable(explicitToJson: true)
class PersistenceItemConfigurationDTO {
  const PersistenceItemConfigurationDTO({
    this.items,
    this.strategies,
    this.filters,
    this.alias,
  });

  factory PersistenceItemConfigurationDTO.fromJson(Map<String, dynamic> json) =>
      _$PersistenceItemConfigurationDTOFromJson(json);

  static const toJsonFactory = _$PersistenceItemConfigurationDTOToJson;
  Map<String, dynamic> toJson() =>
      _$PersistenceItemConfigurationDTOToJson(this);

  @JsonKey(name: 'items', defaultValue: <String>[])
  final List<String>? items;
  @JsonKey(name: 'strategies', defaultValue: <String>[])
  final List<String>? strategies;
  @JsonKey(name: 'filters', defaultValue: <String>[])
  final List<String>? filters;
  @JsonKey(name: 'alias')
  final String? alias;
  static const fromJsonFactory = _$PersistenceItemConfigurationDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PersistenceItemConfigurationDTO &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.strategies, strategies) ||
                const DeepCollectionEquality()
                    .equals(other.strategies, strategies)) &&
            (identical(other.filters, filters) ||
                const DeepCollectionEquality()
                    .equals(other.filters, filters)) &&
            (identical(other.alias, alias) ||
                const DeepCollectionEquality().equals(other.alias, alias)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(strategies) ^
      const DeepCollectionEquality().hash(filters) ^
      const DeepCollectionEquality().hash(alias) ^
      runtimeType.hashCode;
}

extension $PersistenceItemConfigurationDTOExtension
    on PersistenceItemConfigurationDTO {
  PersistenceItemConfigurationDTO copyWith(
      {List<String>? items,
      List<String>? strategies,
      List<String>? filters,
      String? alias}) {
    return PersistenceItemConfigurationDTO(
        items: items ?? this.items,
        strategies: strategies ?? this.strategies,
        filters: filters ?? this.filters,
        alias: alias ?? this.alias);
  }

  PersistenceItemConfigurationDTO copyWithWrapped(
      {Wrapped<List<String>?>? items,
      Wrapped<List<String>?>? strategies,
      Wrapped<List<String>?>? filters,
      Wrapped<String?>? alias}) {
    return PersistenceItemConfigurationDTO(
        items: (items != null ? items.value : this.items),
        strategies: (strategies != null ? strategies.value : this.strategies),
        filters: (filters != null ? filters.value : this.filters),
        alias: (alias != null ? alias.value : this.alias));
  }
}

@JsonSerializable(explicitToJson: true)
class PersistenceServiceConfigurationDTO {
  const PersistenceServiceConfigurationDTO({
    this.serviceId,
    this.configs,
    this.defaults,
    this.cronStrategies,
    this.thresholdFilters,
    this.timeFilters,
    this.equalsFilters,
    this.includeFilters,
    this.editable,
  });

  factory PersistenceServiceConfigurationDTO.fromJson(
          Map<String, dynamic> json) =>
      _$PersistenceServiceConfigurationDTOFromJson(json);

  static const toJsonFactory = _$PersistenceServiceConfigurationDTOToJson;
  Map<String, dynamic> toJson() =>
      _$PersistenceServiceConfigurationDTOToJson(this);

  @JsonKey(name: 'serviceId')
  final String? serviceId;
  @JsonKey(name: 'configs', defaultValue: <PersistenceItemConfigurationDTO>[])
  final List<PersistenceItemConfigurationDTO>? configs;
  @JsonKey(name: 'defaults', defaultValue: <String>[])
  final List<String>? defaults;
  @JsonKey(name: 'cronStrategies', defaultValue: <PersistenceCronStrategyDTO>[])
  final List<PersistenceCronStrategyDTO>? cronStrategies;
  @JsonKey(name: 'thresholdFilters', defaultValue: <PersistenceFilterDTO>[])
  final List<PersistenceFilterDTO>? thresholdFilters;
  @JsonKey(name: 'timeFilters', defaultValue: <PersistenceFilterDTO>[])
  final List<PersistenceFilterDTO>? timeFilters;
  @JsonKey(name: 'equalsFilters', defaultValue: <PersistenceFilterDTO>[])
  final List<PersistenceFilterDTO>? equalsFilters;
  @JsonKey(name: 'includeFilters', defaultValue: <PersistenceFilterDTO>[])
  final List<PersistenceFilterDTO>? includeFilters;
  @JsonKey(name: 'editable')
  final bool? editable;
  static const fromJsonFactory = _$PersistenceServiceConfigurationDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PersistenceServiceConfigurationDTO &&
            (identical(other.serviceId, serviceId) ||
                const DeepCollectionEquality()
                    .equals(other.serviceId, serviceId)) &&
            (identical(other.configs, configs) ||
                const DeepCollectionEquality()
                    .equals(other.configs, configs)) &&
            (identical(other.defaults, defaults) ||
                const DeepCollectionEquality()
                    .equals(other.defaults, defaults)) &&
            (identical(other.cronStrategies, cronStrategies) ||
                const DeepCollectionEquality()
                    .equals(other.cronStrategies, cronStrategies)) &&
            (identical(other.thresholdFilters, thresholdFilters) ||
                const DeepCollectionEquality()
                    .equals(other.thresholdFilters, thresholdFilters)) &&
            (identical(other.timeFilters, timeFilters) ||
                const DeepCollectionEquality()
                    .equals(other.timeFilters, timeFilters)) &&
            (identical(other.equalsFilters, equalsFilters) ||
                const DeepCollectionEquality()
                    .equals(other.equalsFilters, equalsFilters)) &&
            (identical(other.includeFilters, includeFilters) ||
                const DeepCollectionEquality()
                    .equals(other.includeFilters, includeFilters)) &&
            (identical(other.editable, editable) ||
                const DeepCollectionEquality()
                    .equals(other.editable, editable)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(serviceId) ^
      const DeepCollectionEquality().hash(configs) ^
      const DeepCollectionEquality().hash(defaults) ^
      const DeepCollectionEquality().hash(cronStrategies) ^
      const DeepCollectionEquality().hash(thresholdFilters) ^
      const DeepCollectionEquality().hash(timeFilters) ^
      const DeepCollectionEquality().hash(equalsFilters) ^
      const DeepCollectionEquality().hash(includeFilters) ^
      const DeepCollectionEquality().hash(editable) ^
      runtimeType.hashCode;
}

extension $PersistenceServiceConfigurationDTOExtension
    on PersistenceServiceConfigurationDTO {
  PersistenceServiceConfigurationDTO copyWith(
      {String? serviceId,
      List<PersistenceItemConfigurationDTO>? configs,
      List<String>? defaults,
      List<PersistenceCronStrategyDTO>? cronStrategies,
      List<PersistenceFilterDTO>? thresholdFilters,
      List<PersistenceFilterDTO>? timeFilters,
      List<PersistenceFilterDTO>? equalsFilters,
      List<PersistenceFilterDTO>? includeFilters,
      bool? editable}) {
    return PersistenceServiceConfigurationDTO(
        serviceId: serviceId ?? this.serviceId,
        configs: configs ?? this.configs,
        defaults: defaults ?? this.defaults,
        cronStrategies: cronStrategies ?? this.cronStrategies,
        thresholdFilters: thresholdFilters ?? this.thresholdFilters,
        timeFilters: timeFilters ?? this.timeFilters,
        equalsFilters: equalsFilters ?? this.equalsFilters,
        includeFilters: includeFilters ?? this.includeFilters,
        editable: editable ?? this.editable);
  }

  PersistenceServiceConfigurationDTO copyWithWrapped(
      {Wrapped<String?>? serviceId,
      Wrapped<List<PersistenceItemConfigurationDTO>?>? configs,
      Wrapped<List<String>?>? defaults,
      Wrapped<List<PersistenceCronStrategyDTO>?>? cronStrategies,
      Wrapped<List<PersistenceFilterDTO>?>? thresholdFilters,
      Wrapped<List<PersistenceFilterDTO>?>? timeFilters,
      Wrapped<List<PersistenceFilterDTO>?>? equalsFilters,
      Wrapped<List<PersistenceFilterDTO>?>? includeFilters,
      Wrapped<bool?>? editable}) {
    return PersistenceServiceConfigurationDTO(
        serviceId: (serviceId != null ? serviceId.value : this.serviceId),
        configs: (configs != null ? configs.value : this.configs),
        defaults: (defaults != null ? defaults.value : this.defaults),
        cronStrategies: (cronStrategies != null
            ? cronStrategies.value
            : this.cronStrategies),
        thresholdFilters: (thresholdFilters != null
            ? thresholdFilters.value
            : this.thresholdFilters),
        timeFilters:
            (timeFilters != null ? timeFilters.value : this.timeFilters),
        equalsFilters:
            (equalsFilters != null ? equalsFilters.value : this.equalsFilters),
        includeFilters: (includeFilters != null
            ? includeFilters.value
            : this.includeFilters),
        editable: (editable != null ? editable.value : this.editable));
  }
}

@JsonSerializable(explicitToJson: true)
class PersistenceItemInfo {
  const PersistenceItemInfo({
    this.earliest,
    this.latest,
    this.count,
    this.name,
  });

  factory PersistenceItemInfo.fromJson(Map<String, dynamic> json) =>
      _$PersistenceItemInfoFromJson(json);

  static const toJsonFactory = _$PersistenceItemInfoToJson;
  Map<String, dynamic> toJson() => _$PersistenceItemInfoToJson(this);

  @JsonKey(name: 'earliest')
  final DateTime? earliest;
  @JsonKey(name: 'latest')
  final DateTime? latest;
  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'name')
  final String? name;
  static const fromJsonFactory = _$PersistenceItemInfoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PersistenceItemInfo &&
            (identical(other.earliest, earliest) ||
                const DeepCollectionEquality()
                    .equals(other.earliest, earliest)) &&
            (identical(other.latest, latest) ||
                const DeepCollectionEquality().equals(other.latest, latest)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(earliest) ^
      const DeepCollectionEquality().hash(latest) ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $PersistenceItemInfoExtension on PersistenceItemInfo {
  PersistenceItemInfo copyWith(
      {DateTime? earliest, DateTime? latest, int? count, String? name}) {
    return PersistenceItemInfo(
        earliest: earliest ?? this.earliest,
        latest: latest ?? this.latest,
        count: count ?? this.count,
        name: name ?? this.name);
  }

  PersistenceItemInfo copyWithWrapped(
      {Wrapped<DateTime?>? earliest,
      Wrapped<DateTime?>? latest,
      Wrapped<int?>? count,
      Wrapped<String?>? name}) {
    return PersistenceItemInfo(
        earliest: (earliest != null ? earliest.value : this.earliest),
        latest: (latest != null ? latest.value : this.latest),
        count: (count != null ? count.value : this.count),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class PersistenceServiceDTO {
  const PersistenceServiceDTO({
    this.id,
    this.label,
    this.type,
  });

  factory PersistenceServiceDTO.fromJson(Map<String, dynamic> json) =>
      _$PersistenceServiceDTOFromJson(json);

  static const toJsonFactory = _$PersistenceServiceDTOToJson;
  Map<String, dynamic> toJson() => _$PersistenceServiceDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'type')
  final String? type;
  static const fromJsonFactory = _$PersistenceServiceDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PersistenceServiceDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $PersistenceServiceDTOExtension on PersistenceServiceDTO {
  PersistenceServiceDTO copyWith({String? id, String? label, String? type}) {
    return PersistenceServiceDTO(
        id: id ?? this.id, label: label ?? this.label, type: type ?? this.type);
  }

  PersistenceServiceDTO copyWithWrapped(
      {Wrapped<String?>? id, Wrapped<String?>? label, Wrapped<String?>? type}) {
    return PersistenceServiceDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        type: (type != null ? type.value : this.type));
  }
}

@JsonSerializable(explicitToJson: true)
class ProfileTypeDTO {
  const ProfileTypeDTO({
    this.uid,
    this.label,
    this.kind,
    this.supportedItemTypes,
  });

  factory ProfileTypeDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfileTypeDTOFromJson(json);

  static const toJsonFactory = _$ProfileTypeDTOToJson;
  Map<String, dynamic> toJson() => _$ProfileTypeDTOToJson(this);

  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'kind')
  final String? kind;
  @JsonKey(name: 'supportedItemTypes', defaultValue: <String>[])
  final List<String>? supportedItemTypes;
  static const fromJsonFactory = _$ProfileTypeDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ProfileTypeDTO &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.supportedItemTypes, supportedItemTypes) ||
                const DeepCollectionEquality()
                    .equals(other.supportedItemTypes, supportedItemTypes)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(supportedItemTypes) ^
      runtimeType.hashCode;
}

extension $ProfileTypeDTOExtension on ProfileTypeDTO {
  ProfileTypeDTO copyWith(
      {String? uid,
      String? label,
      String? kind,
      List<String>? supportedItemTypes}) {
    return ProfileTypeDTO(
        uid: uid ?? this.uid,
        label: label ?? this.label,
        kind: kind ?? this.kind,
        supportedItemTypes: supportedItemTypes ?? this.supportedItemTypes);
  }

  ProfileTypeDTO copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<String?>? label,
      Wrapped<String?>? kind,
      Wrapped<List<String>?>? supportedItemTypes}) {
    return ProfileTypeDTO(
        uid: (uid != null ? uid.value : this.uid),
        label: (label != null ? label.value : this.label),
        kind: (kind != null ? kind.value : this.kind),
        supportedItemTypes: (supportedItemTypes != null
            ? supportedItemTypes.value
            : this.supportedItemTypes));
  }
}

@JsonSerializable(explicitToJson: true)
class ConfigurableServiceDTO {
  const ConfigurableServiceDTO({
    this.id,
    this.label,
    this.category,
    this.configDescriptionURI,
    this.multiple,
  });

  factory ConfigurableServiceDTO.fromJson(Map<String, dynamic> json) =>
      _$ConfigurableServiceDTOFromJson(json);

  static const toJsonFactory = _$ConfigurableServiceDTOToJson;
  Map<String, dynamic> toJson() => _$ConfigurableServiceDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'configDescriptionURI')
  final String? configDescriptionURI;
  @JsonKey(name: 'multiple')
  final bool? multiple;
  static const fromJsonFactory = _$ConfigurableServiceDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ConfigurableServiceDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.configDescriptionURI, configDescriptionURI) ||
                const DeepCollectionEquality().equals(
                    other.configDescriptionURI, configDescriptionURI)) &&
            (identical(other.multiple, multiple) ||
                const DeepCollectionEquality()
                    .equals(other.multiple, multiple)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(configDescriptionURI) ^
      const DeepCollectionEquality().hash(multiple) ^
      runtimeType.hashCode;
}

extension $ConfigurableServiceDTOExtension on ConfigurableServiceDTO {
  ConfigurableServiceDTO copyWith(
      {String? id,
      String? label,
      String? category,
      String? configDescriptionURI,
      bool? multiple}) {
    return ConfigurableServiceDTO(
        id: id ?? this.id,
        label: label ?? this.label,
        category: category ?? this.category,
        configDescriptionURI: configDescriptionURI ?? this.configDescriptionURI,
        multiple: multiple ?? this.multiple);
  }

  ConfigurableServiceDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<String?>? category,
      Wrapped<String?>? configDescriptionURI,
      Wrapped<bool?>? multiple}) {
    return ConfigurableServiceDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        category: (category != null ? category.value : this.category),
        configDescriptionURI: (configDescriptionURI != null
            ? configDescriptionURI.value
            : this.configDescriptionURI),
        multiple: (multiple != null ? multiple.value : this.multiple));
  }
}

@JsonSerializable(explicitToJson: true)
class EnrichedSemanticTagDTO {
  const EnrichedSemanticTagDTO();

  factory EnrichedSemanticTagDTO.fromJson(Map<String, dynamic> json) =>
      _$EnrichedSemanticTagDTOFromJson(json);

  static const toJsonFactory = _$EnrichedSemanticTagDTOToJson;
  Map<String, dynamic> toJson() => _$EnrichedSemanticTagDTOToJson(this);

  static const fromJsonFactory = _$EnrichedSemanticTagDTOFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class EnrichedChannelDTO {
  const EnrichedChannelDTO({
    this.uid,
    this.id,
    this.channelTypeUID,
    this.itemType,
    this.kind,
    this.label,
    this.description,
    this.defaultTags,
    this.properties,
    this.configuration,
    this.autoUpdatePolicy,
    this.linkedItems,
  });

  factory EnrichedChannelDTO.fromJson(Map<String, dynamic> json) =>
      _$EnrichedChannelDTOFromJson(json);

  static const toJsonFactory = _$EnrichedChannelDTOToJson;
  Map<String, dynamic> toJson() => _$EnrichedChannelDTOToJson(this);

  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'channelTypeUID')
  final String? channelTypeUID;
  @JsonKey(name: 'itemType')
  final String? itemType;
  @JsonKey(name: 'kind')
  final String? kind;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'defaultTags', defaultValue: <String>[])
  final List<String>? defaultTags;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'autoUpdatePolicy')
  final String? autoUpdatePolicy;
  @JsonKey(name: 'linkedItems', defaultValue: <String>[])
  final List<String>? linkedItems;
  static const fromJsonFactory = _$EnrichedChannelDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EnrichedChannelDTO &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.channelTypeUID, channelTypeUID) ||
                const DeepCollectionEquality()
                    .equals(other.channelTypeUID, channelTypeUID)) &&
            (identical(other.itemType, itemType) ||
                const DeepCollectionEquality()
                    .equals(other.itemType, itemType)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.defaultTags, defaultTags) ||
                const DeepCollectionEquality()
                    .equals(other.defaultTags, defaultTags)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.autoUpdatePolicy, autoUpdatePolicy) ||
                const DeepCollectionEquality()
                    .equals(other.autoUpdatePolicy, autoUpdatePolicy)) &&
            (identical(other.linkedItems, linkedItems) ||
                const DeepCollectionEquality()
                    .equals(other.linkedItems, linkedItems)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(channelTypeUID) ^
      const DeepCollectionEquality().hash(itemType) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(defaultTags) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(autoUpdatePolicy) ^
      const DeepCollectionEquality().hash(linkedItems) ^
      runtimeType.hashCode;
}

extension $EnrichedChannelDTOExtension on EnrichedChannelDTO {
  EnrichedChannelDTO copyWith(
      {String? uid,
      String? id,
      String? channelTypeUID,
      String? itemType,
      String? kind,
      String? label,
      String? description,
      List<String>? defaultTags,
      Map<String, dynamic>? properties,
      Map<String, dynamic>? configuration,
      String? autoUpdatePolicy,
      List<String>? linkedItems}) {
    return EnrichedChannelDTO(
        uid: uid ?? this.uid,
        id: id ?? this.id,
        channelTypeUID: channelTypeUID ?? this.channelTypeUID,
        itemType: itemType ?? this.itemType,
        kind: kind ?? this.kind,
        label: label ?? this.label,
        description: description ?? this.description,
        defaultTags: defaultTags ?? this.defaultTags,
        properties: properties ?? this.properties,
        configuration: configuration ?? this.configuration,
        autoUpdatePolicy: autoUpdatePolicy ?? this.autoUpdatePolicy,
        linkedItems: linkedItems ?? this.linkedItems);
  }

  EnrichedChannelDTO copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<String?>? id,
      Wrapped<String?>? channelTypeUID,
      Wrapped<String?>? itemType,
      Wrapped<String?>? kind,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<List<String>?>? defaultTags,
      Wrapped<Map<String, dynamic>?>? properties,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<String?>? autoUpdatePolicy,
      Wrapped<List<String>?>? linkedItems}) {
    return EnrichedChannelDTO(
        uid: (uid != null ? uid.value : this.uid),
        id: (id != null ? id.value : this.id),
        channelTypeUID: (channelTypeUID != null
            ? channelTypeUID.value
            : this.channelTypeUID),
        itemType: (itemType != null ? itemType.value : this.itemType),
        kind: (kind != null ? kind.value : this.kind),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        defaultTags:
            (defaultTags != null ? defaultTags.value : this.defaultTags),
        properties: (properties != null ? properties.value : this.properties),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        autoUpdatePolicy: (autoUpdatePolicy != null
            ? autoUpdatePolicy.value
            : this.autoUpdatePolicy),
        linkedItems:
            (linkedItems != null ? linkedItems.value : this.linkedItems));
  }
}

@JsonSerializable(explicitToJson: true)
class EnrichedThingDTO {
  const EnrichedThingDTO({
    this.label,
    this.bridgeUID,
    this.configuration,
    this.properties,
    this.uid,
    this.thingTypeUID,
    this.location,
    this.channels,
    this.statusInfo,
    this.firmwareStatus,
    this.editable,
  });

  factory EnrichedThingDTO.fromJson(Map<String, dynamic> json) =>
      _$EnrichedThingDTOFromJson(json);

  static const toJsonFactory = _$EnrichedThingDTOToJson;
  Map<String, dynamic> toJson() => _$EnrichedThingDTOToJson(this);

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'bridgeUID')
  final String? bridgeUID;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  @JsonKey(name: 'UID')
  final String? uid;
  @JsonKey(name: 'thingTypeUID')
  final String? thingTypeUID;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'channels', defaultValue: <EnrichedChannelDTO>[])
  final List<EnrichedChannelDTO>? channels;
  @JsonKey(name: 'statusInfo')
  final ThingStatusInfo? statusInfo;
  @JsonKey(name: 'firmwareStatus')
  final FirmwareStatusDTO? firmwareStatus;
  @JsonKey(name: 'editable')
  final bool? editable;
  static const fromJsonFactory = _$EnrichedThingDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EnrichedThingDTO &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.bridgeUID, bridgeUID) ||
                const DeepCollectionEquality()
                    .equals(other.bridgeUID, bridgeUID)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.thingTypeUID, thingTypeUID) ||
                const DeepCollectionEquality()
                    .equals(other.thingTypeUID, thingTypeUID)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.channels, channels) ||
                const DeepCollectionEquality()
                    .equals(other.channels, channels)) &&
            (identical(other.statusInfo, statusInfo) ||
                const DeepCollectionEquality()
                    .equals(other.statusInfo, statusInfo)) &&
            (identical(other.firmwareStatus, firmwareStatus) ||
                const DeepCollectionEquality()
                    .equals(other.firmwareStatus, firmwareStatus)) &&
            (identical(other.editable, editable) ||
                const DeepCollectionEquality()
                    .equals(other.editable, editable)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(bridgeUID) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(thingTypeUID) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(channels) ^
      const DeepCollectionEquality().hash(statusInfo) ^
      const DeepCollectionEquality().hash(firmwareStatus) ^
      const DeepCollectionEquality().hash(editable) ^
      runtimeType.hashCode;
}

extension $EnrichedThingDTOExtension on EnrichedThingDTO {
  EnrichedThingDTO copyWith(
      {String? label,
      String? bridgeUID,
      Map<String, dynamic>? configuration,
      Map<String, dynamic>? properties,
      String? uid,
      String? thingTypeUID,
      String? location,
      List<EnrichedChannelDTO>? channels,
      ThingStatusInfo? statusInfo,
      FirmwareStatusDTO? firmwareStatus,
      bool? editable}) {
    return EnrichedThingDTO(
        label: label ?? this.label,
        bridgeUID: bridgeUID ?? this.bridgeUID,
        configuration: configuration ?? this.configuration,
        properties: properties ?? this.properties,
        uid: uid ?? this.uid,
        thingTypeUID: thingTypeUID ?? this.thingTypeUID,
        location: location ?? this.location,
        channels: channels ?? this.channels,
        statusInfo: statusInfo ?? this.statusInfo,
        firmwareStatus: firmwareStatus ?? this.firmwareStatus,
        editable: editable ?? this.editable);
  }

  EnrichedThingDTO copyWithWrapped(
      {Wrapped<String?>? label,
      Wrapped<String?>? bridgeUID,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<Map<String, dynamic>?>? properties,
      Wrapped<String?>? uid,
      Wrapped<String?>? thingTypeUID,
      Wrapped<String?>? location,
      Wrapped<List<EnrichedChannelDTO>?>? channels,
      Wrapped<ThingStatusInfo?>? statusInfo,
      Wrapped<FirmwareStatusDTO?>? firmwareStatus,
      Wrapped<bool?>? editable}) {
    return EnrichedThingDTO(
        label: (label != null ? label.value : this.label),
        bridgeUID: (bridgeUID != null ? bridgeUID.value : this.bridgeUID),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        properties: (properties != null ? properties.value : this.properties),
        uid: (uid != null ? uid.value : this.uid),
        thingTypeUID:
            (thingTypeUID != null ? thingTypeUID.value : this.thingTypeUID),
        location: (location != null ? location.value : this.location),
        channels: (channels != null ? channels.value : this.channels),
        statusInfo: (statusInfo != null ? statusInfo.value : this.statusInfo),
        firmwareStatus: (firmwareStatus != null
            ? firmwareStatus.value
            : this.firmwareStatus),
        editable: (editable != null ? editable.value : this.editable));
  }
}

@JsonSerializable(explicitToJson: true)
class FirmwareStatusDTO {
  const FirmwareStatusDTO({
    this.status,
    this.updatableVersion,
  });

  factory FirmwareStatusDTO.fromJson(Map<String, dynamic> json) =>
      _$FirmwareStatusDTOFromJson(json);

  static const toJsonFactory = _$FirmwareStatusDTOToJson;
  Map<String, dynamic> toJson() => _$FirmwareStatusDTOToJson(this);

  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'updatableVersion')
  final String? updatableVersion;
  static const fromJsonFactory = _$FirmwareStatusDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FirmwareStatusDTO &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.updatableVersion, updatableVersion) ||
                const DeepCollectionEquality()
                    .equals(other.updatableVersion, updatableVersion)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(updatableVersion) ^
      runtimeType.hashCode;
}

extension $FirmwareStatusDTOExtension on FirmwareStatusDTO {
  FirmwareStatusDTO copyWith({String? status, String? updatableVersion}) {
    return FirmwareStatusDTO(
        status: status ?? this.status,
        updatableVersion: updatableVersion ?? this.updatableVersion);
  }

  FirmwareStatusDTO copyWithWrapped(
      {Wrapped<String?>? status, Wrapped<String?>? updatableVersion}) {
    return FirmwareStatusDTO(
        status: (status != null ? status.value : this.status),
        updatableVersion: (updatableVersion != null
            ? updatableVersion.value
            : this.updatableVersion));
  }
}

@JsonSerializable(explicitToJson: true)
class ThingStatusInfo {
  const ThingStatusInfo({
    this.status,
    this.statusDetail,
    this.description,
  });

  factory ThingStatusInfo.fromJson(Map<String, dynamic> json) =>
      _$ThingStatusInfoFromJson(json);

  static const toJsonFactory = _$ThingStatusInfoToJson;
  Map<String, dynamic> toJson() => _$ThingStatusInfoToJson(this);

  @JsonKey(
    name: 'status',
    toJson: thingStatusInfoStatusNullableToJson,
    fromJson: thingStatusInfoStatusNullableFromJson,
  )
  final enums.ThingStatusInfoStatus? status;
  @JsonKey(
    name: 'statusDetail',
    toJson: thingStatusInfoStatusDetailNullableToJson,
    fromJson: thingStatusInfoStatusDetailNullableFromJson,
  )
  final enums.ThingStatusInfoStatusDetail? statusDetail;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$ThingStatusInfoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ThingStatusInfo &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.statusDetail, statusDetail) ||
                const DeepCollectionEquality()
                    .equals(other.statusDetail, statusDetail)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(statusDetail) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $ThingStatusInfoExtension on ThingStatusInfo {
  ThingStatusInfo copyWith(
      {enums.ThingStatusInfoStatus? status,
      enums.ThingStatusInfoStatusDetail? statusDetail,
      String? description}) {
    return ThingStatusInfo(
        status: status ?? this.status,
        statusDetail: statusDetail ?? this.statusDetail,
        description: description ?? this.description);
  }

  ThingStatusInfo copyWithWrapped(
      {Wrapped<enums.ThingStatusInfoStatus?>? status,
      Wrapped<enums.ThingStatusInfoStatusDetail?>? statusDetail,
      Wrapped<String?>? description}) {
    return ThingStatusInfo(
        status: (status != null ? status.value : this.status),
        statusDetail:
            (statusDetail != null ? statusDetail.value : this.statusDetail),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class ChannelDTO {
  const ChannelDTO({
    this.uid,
    this.id,
    this.channelTypeUID,
    this.itemType,
    this.kind,
    this.label,
    this.description,
    this.defaultTags,
    this.properties,
    this.configuration,
    this.autoUpdatePolicy,
  });

  factory ChannelDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelDTOFromJson(json);

  static const toJsonFactory = _$ChannelDTOToJson;
  Map<String, dynamic> toJson() => _$ChannelDTOToJson(this);

  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'channelTypeUID')
  final String? channelTypeUID;
  @JsonKey(name: 'itemType')
  final String? itemType;
  @JsonKey(name: 'kind')
  final String? kind;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'defaultTags', defaultValue: <String>[])
  final List<String>? defaultTags;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'autoUpdatePolicy')
  final String? autoUpdatePolicy;
  static const fromJsonFactory = _$ChannelDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChannelDTO &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.channelTypeUID, channelTypeUID) ||
                const DeepCollectionEquality()
                    .equals(other.channelTypeUID, channelTypeUID)) &&
            (identical(other.itemType, itemType) ||
                const DeepCollectionEquality()
                    .equals(other.itemType, itemType)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.defaultTags, defaultTags) ||
                const DeepCollectionEquality()
                    .equals(other.defaultTags, defaultTags)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.autoUpdatePolicy, autoUpdatePolicy) ||
                const DeepCollectionEquality()
                    .equals(other.autoUpdatePolicy, autoUpdatePolicy)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(channelTypeUID) ^
      const DeepCollectionEquality().hash(itemType) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(defaultTags) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(autoUpdatePolicy) ^
      runtimeType.hashCode;
}

extension $ChannelDTOExtension on ChannelDTO {
  ChannelDTO copyWith(
      {String? uid,
      String? id,
      String? channelTypeUID,
      String? itemType,
      String? kind,
      String? label,
      String? description,
      List<String>? defaultTags,
      Map<String, dynamic>? properties,
      Map<String, dynamic>? configuration,
      String? autoUpdatePolicy}) {
    return ChannelDTO(
        uid: uid ?? this.uid,
        id: id ?? this.id,
        channelTypeUID: channelTypeUID ?? this.channelTypeUID,
        itemType: itemType ?? this.itemType,
        kind: kind ?? this.kind,
        label: label ?? this.label,
        description: description ?? this.description,
        defaultTags: defaultTags ?? this.defaultTags,
        properties: properties ?? this.properties,
        configuration: configuration ?? this.configuration,
        autoUpdatePolicy: autoUpdatePolicy ?? this.autoUpdatePolicy);
  }

  ChannelDTO copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<String?>? id,
      Wrapped<String?>? channelTypeUID,
      Wrapped<String?>? itemType,
      Wrapped<String?>? kind,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<List<String>?>? defaultTags,
      Wrapped<Map<String, dynamic>?>? properties,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<String?>? autoUpdatePolicy}) {
    return ChannelDTO(
        uid: (uid != null ? uid.value : this.uid),
        id: (id != null ? id.value : this.id),
        channelTypeUID: (channelTypeUID != null
            ? channelTypeUID.value
            : this.channelTypeUID),
        itemType: (itemType != null ? itemType.value : this.itemType),
        kind: (kind != null ? kind.value : this.kind),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        defaultTags:
            (defaultTags != null ? defaultTags.value : this.defaultTags),
        properties: (properties != null ? properties.value : this.properties),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        autoUpdatePolicy: (autoUpdatePolicy != null
            ? autoUpdatePolicy.value
            : this.autoUpdatePolicy));
  }
}

@JsonSerializable(explicitToJson: true)
class ThingDTO {
  const ThingDTO({
    this.label,
    this.bridgeUID,
    this.configuration,
    this.properties,
    this.uid,
    this.thingTypeUID,
    this.location,
    this.channels,
  });

  factory ThingDTO.fromJson(Map<String, dynamic> json) =>
      _$ThingDTOFromJson(json);

  static const toJsonFactory = _$ThingDTOToJson;
  Map<String, dynamic> toJson() => _$ThingDTOToJson(this);

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'bridgeUID')
  final String? bridgeUID;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  @JsonKey(name: 'UID')
  final String? uid;
  @JsonKey(name: 'thingTypeUID')
  final String? thingTypeUID;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'channels', defaultValue: <ChannelDTO>[])
  final List<ChannelDTO>? channels;
  static const fromJsonFactory = _$ThingDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ThingDTO &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.bridgeUID, bridgeUID) ||
                const DeepCollectionEquality()
                    .equals(other.bridgeUID, bridgeUID)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.thingTypeUID, thingTypeUID) ||
                const DeepCollectionEquality()
                    .equals(other.thingTypeUID, thingTypeUID)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.channels, channels) ||
                const DeepCollectionEquality()
                    .equals(other.channels, channels)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(bridgeUID) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(thingTypeUID) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(channels) ^
      runtimeType.hashCode;
}

extension $ThingDTOExtension on ThingDTO {
  ThingDTO copyWith(
      {String? label,
      String? bridgeUID,
      Map<String, dynamic>? configuration,
      Map<String, dynamic>? properties,
      String? uid,
      String? thingTypeUID,
      String? location,
      List<ChannelDTO>? channels}) {
    return ThingDTO(
        label: label ?? this.label,
        bridgeUID: bridgeUID ?? this.bridgeUID,
        configuration: configuration ?? this.configuration,
        properties: properties ?? this.properties,
        uid: uid ?? this.uid,
        thingTypeUID: thingTypeUID ?? this.thingTypeUID,
        location: location ?? this.location,
        channels: channels ?? this.channels);
  }

  ThingDTO copyWithWrapped(
      {Wrapped<String?>? label,
      Wrapped<String?>? bridgeUID,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<Map<String, dynamic>?>? properties,
      Wrapped<String?>? uid,
      Wrapped<String?>? thingTypeUID,
      Wrapped<String?>? location,
      Wrapped<List<ChannelDTO>?>? channels}) {
    return ThingDTO(
        label: (label != null ? label.value : this.label),
        bridgeUID: (bridgeUID != null ? bridgeUID.value : this.bridgeUID),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        properties: (properties != null ? properties.value : this.properties),
        uid: (uid != null ? uid.value : this.uid),
        thingTypeUID:
            (thingTypeUID != null ? thingTypeUID.value : this.thingTypeUID),
        location: (location != null ? location.value : this.location),
        channels: (channels != null ? channels.value : this.channels));
  }
}

@JsonSerializable(explicitToJson: true)
class ConfigStatusMessage {
  const ConfigStatusMessage({
    this.parameterName,
    this.type,
    this.message,
    this.statusCode,
  });

  factory ConfigStatusMessage.fromJson(Map<String, dynamic> json) =>
      _$ConfigStatusMessageFromJson(json);

  static const toJsonFactory = _$ConfigStatusMessageToJson;
  Map<String, dynamic> toJson() => _$ConfigStatusMessageToJson(this);

  @JsonKey(name: 'parameterName')
  final String? parameterName;
  @JsonKey(
    name: 'type',
    toJson: configStatusMessageTypeNullableToJson,
    fromJson: configStatusMessageTypeNullableFromJson,
  )
  final enums.ConfigStatusMessageType? type;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'statusCode')
  final int? statusCode;
  static const fromJsonFactory = _$ConfigStatusMessageFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ConfigStatusMessage &&
            (identical(other.parameterName, parameterName) ||
                const DeepCollectionEquality()
                    .equals(other.parameterName, parameterName)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.statusCode, statusCode) ||
                const DeepCollectionEquality()
                    .equals(other.statusCode, statusCode)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(parameterName) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(statusCode) ^
      runtimeType.hashCode;
}

extension $ConfigStatusMessageExtension on ConfigStatusMessage {
  ConfigStatusMessage copyWith(
      {String? parameterName,
      enums.ConfigStatusMessageType? type,
      String? message,
      int? statusCode}) {
    return ConfigStatusMessage(
        parameterName: parameterName ?? this.parameterName,
        type: type ?? this.type,
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode);
  }

  ConfigStatusMessage copyWithWrapped(
      {Wrapped<String?>? parameterName,
      Wrapped<enums.ConfigStatusMessageType?>? type,
      Wrapped<String?>? message,
      Wrapped<int?>? statusCode}) {
    return ConfigStatusMessage(
        parameterName:
            (parameterName != null ? parameterName.value : this.parameterName),
        type: (type != null ? type.value : this.type),
        message: (message != null ? message.value : this.message),
        statusCode: (statusCode != null ? statusCode.value : this.statusCode));
  }
}

@JsonSerializable(explicitToJson: true)
class FirmwareDTO {
  const FirmwareDTO({
    this.thingTypeUID,
    this.vendor,
    this.model,
    this.modelRestricted,
    this.description,
    this.version,
    this.changelog,
    this.prerequisiteVersion,
  });

  factory FirmwareDTO.fromJson(Map<String, dynamic> json) =>
      _$FirmwareDTOFromJson(json);

  static const toJsonFactory = _$FirmwareDTOToJson;
  Map<String, dynamic> toJson() => _$FirmwareDTOToJson(this);

  @JsonKey(name: 'thingTypeUID')
  final String? thingTypeUID;
  @JsonKey(name: 'vendor')
  final String? vendor;
  @JsonKey(name: 'model')
  final String? model;
  @JsonKey(name: 'modelRestricted')
  final bool? modelRestricted;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'changelog')
  final String? changelog;
  @JsonKey(name: 'prerequisiteVersion')
  final String? prerequisiteVersion;
  static const fromJsonFactory = _$FirmwareDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FirmwareDTO &&
            (identical(other.thingTypeUID, thingTypeUID) ||
                const DeepCollectionEquality()
                    .equals(other.thingTypeUID, thingTypeUID)) &&
            (identical(other.vendor, vendor) ||
                const DeepCollectionEquality().equals(other.vendor, vendor)) &&
            (identical(other.model, model) ||
                const DeepCollectionEquality().equals(other.model, model)) &&
            (identical(other.modelRestricted, modelRestricted) ||
                const DeepCollectionEquality()
                    .equals(other.modelRestricted, modelRestricted)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.changelog, changelog) ||
                const DeepCollectionEquality()
                    .equals(other.changelog, changelog)) &&
            (identical(other.prerequisiteVersion, prerequisiteVersion) ||
                const DeepCollectionEquality()
                    .equals(other.prerequisiteVersion, prerequisiteVersion)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(thingTypeUID) ^
      const DeepCollectionEquality().hash(vendor) ^
      const DeepCollectionEquality().hash(model) ^
      const DeepCollectionEquality().hash(modelRestricted) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(changelog) ^
      const DeepCollectionEquality().hash(prerequisiteVersion) ^
      runtimeType.hashCode;
}

extension $FirmwareDTOExtension on FirmwareDTO {
  FirmwareDTO copyWith(
      {String? thingTypeUID,
      String? vendor,
      String? model,
      bool? modelRestricted,
      String? description,
      String? version,
      String? changelog,
      String? prerequisiteVersion}) {
    return FirmwareDTO(
        thingTypeUID: thingTypeUID ?? this.thingTypeUID,
        vendor: vendor ?? this.vendor,
        model: model ?? this.model,
        modelRestricted: modelRestricted ?? this.modelRestricted,
        description: description ?? this.description,
        version: version ?? this.version,
        changelog: changelog ?? this.changelog,
        prerequisiteVersion: prerequisiteVersion ?? this.prerequisiteVersion);
  }

  FirmwareDTO copyWithWrapped(
      {Wrapped<String?>? thingTypeUID,
      Wrapped<String?>? vendor,
      Wrapped<String?>? model,
      Wrapped<bool?>? modelRestricted,
      Wrapped<String?>? description,
      Wrapped<String?>? version,
      Wrapped<String?>? changelog,
      Wrapped<String?>? prerequisiteVersion}) {
    return FirmwareDTO(
        thingTypeUID:
            (thingTypeUID != null ? thingTypeUID.value : this.thingTypeUID),
        vendor: (vendor != null ? vendor.value : this.vendor),
        model: (model != null ? model.value : this.model),
        modelRestricted: (modelRestricted != null
            ? modelRestricted.value
            : this.modelRestricted),
        description:
            (description != null ? description.value : this.description),
        version: (version != null ? version.value : this.version),
        changelog: (changelog != null ? changelog.value : this.changelog),
        prerequisiteVersion: (prerequisiteVersion != null
            ? prerequisiteVersion.value
            : this.prerequisiteVersion));
  }
}

@JsonSerializable(explicitToJson: true)
class StrippedThingTypeDTO {
  const StrippedThingTypeDTO({
    this.uid,
    this.label,
    this.description,
    this.category,
    this.listed,
    this.supportedBridgeTypeUIDs,
    this.bridge,
  });

  factory StrippedThingTypeDTO.fromJson(Map<String, dynamic> json) =>
      _$StrippedThingTypeDTOFromJson(json);

  static const toJsonFactory = _$StrippedThingTypeDTOToJson;
  Map<String, dynamic> toJson() => _$StrippedThingTypeDTOToJson(this);

  @JsonKey(name: 'UID')
  final String? uid;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'listed')
  final bool? listed;
  @JsonKey(name: 'supportedBridgeTypeUIDs', defaultValue: <String>[])
  final List<String>? supportedBridgeTypeUIDs;
  @JsonKey(name: 'bridge')
  final bool? bridge;
  static const fromJsonFactory = _$StrippedThingTypeDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StrippedThingTypeDTO &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.listed, listed) ||
                const DeepCollectionEquality().equals(other.listed, listed)) &&
            (identical(
                    other.supportedBridgeTypeUIDs, supportedBridgeTypeUIDs) ||
                const DeepCollectionEquality().equals(
                    other.supportedBridgeTypeUIDs, supportedBridgeTypeUIDs)) &&
            (identical(other.bridge, bridge) ||
                const DeepCollectionEquality().equals(other.bridge, bridge)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(listed) ^
      const DeepCollectionEquality().hash(supportedBridgeTypeUIDs) ^
      const DeepCollectionEquality().hash(bridge) ^
      runtimeType.hashCode;
}

extension $StrippedThingTypeDTOExtension on StrippedThingTypeDTO {
  StrippedThingTypeDTO copyWith(
      {String? uid,
      String? label,
      String? description,
      String? category,
      bool? listed,
      List<String>? supportedBridgeTypeUIDs,
      bool? bridge}) {
    return StrippedThingTypeDTO(
        uid: uid ?? this.uid,
        label: label ?? this.label,
        description: description ?? this.description,
        category: category ?? this.category,
        listed: listed ?? this.listed,
        supportedBridgeTypeUIDs:
            supportedBridgeTypeUIDs ?? this.supportedBridgeTypeUIDs,
        bridge: bridge ?? this.bridge);
  }

  StrippedThingTypeDTO copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<String?>? category,
      Wrapped<bool?>? listed,
      Wrapped<List<String>?>? supportedBridgeTypeUIDs,
      Wrapped<bool?>? bridge}) {
    return StrippedThingTypeDTO(
        uid: (uid != null ? uid.value : this.uid),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        category: (category != null ? category.value : this.category),
        listed: (listed != null ? listed.value : this.listed),
        supportedBridgeTypeUIDs: (supportedBridgeTypeUIDs != null
            ? supportedBridgeTypeUIDs.value
            : this.supportedBridgeTypeUIDs),
        bridge: (bridge != null ? bridge.value : this.bridge));
  }
}

@JsonSerializable(explicitToJson: true)
class ChannelDefinitionDTO {
  const ChannelDefinitionDTO({
    this.description,
    this.id,
    this.label,
    this.tags,
    this.properties,
    this.category,
    this.stateDescription,
    this.advanced,
    this.typeUID,
  });

  factory ChannelDefinitionDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelDefinitionDTOFromJson(json);

  static const toJsonFactory = _$ChannelDefinitionDTOToJson;
  Map<String, dynamic> toJson() => _$ChannelDefinitionDTOToJson(this);

  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'stateDescription')
  final StateDescription? stateDescription;
  @JsonKey(name: 'advanced')
  final bool? advanced;
  @JsonKey(name: 'typeUID')
  final String? typeUID;
  static const fromJsonFactory = _$ChannelDefinitionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChannelDefinitionDTO &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.stateDescription, stateDescription) ||
                const DeepCollectionEquality()
                    .equals(other.stateDescription, stateDescription)) &&
            (identical(other.advanced, advanced) ||
                const DeepCollectionEquality()
                    .equals(other.advanced, advanced)) &&
            (identical(other.typeUID, typeUID) ||
                const DeepCollectionEquality().equals(other.typeUID, typeUID)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(stateDescription) ^
      const DeepCollectionEquality().hash(advanced) ^
      const DeepCollectionEquality().hash(typeUID) ^
      runtimeType.hashCode;
}

extension $ChannelDefinitionDTOExtension on ChannelDefinitionDTO {
  ChannelDefinitionDTO copyWith(
      {String? description,
      String? id,
      String? label,
      List<String>? tags,
      Map<String, dynamic>? properties,
      String? category,
      StateDescription? stateDescription,
      bool? advanced,
      String? typeUID}) {
    return ChannelDefinitionDTO(
        description: description ?? this.description,
        id: id ?? this.id,
        label: label ?? this.label,
        tags: tags ?? this.tags,
        properties: properties ?? this.properties,
        category: category ?? this.category,
        stateDescription: stateDescription ?? this.stateDescription,
        advanced: advanced ?? this.advanced,
        typeUID: typeUID ?? this.typeUID);
  }

  ChannelDefinitionDTO copyWithWrapped(
      {Wrapped<String?>? description,
      Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<List<String>?>? tags,
      Wrapped<Map<String, dynamic>?>? properties,
      Wrapped<String?>? category,
      Wrapped<StateDescription?>? stateDescription,
      Wrapped<bool?>? advanced,
      Wrapped<String?>? typeUID}) {
    return ChannelDefinitionDTO(
        description:
            (description != null ? description.value : this.description),
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        tags: (tags != null ? tags.value : this.tags),
        properties: (properties != null ? properties.value : this.properties),
        category: (category != null ? category.value : this.category),
        stateDescription: (stateDescription != null
            ? stateDescription.value
            : this.stateDescription),
        advanced: (advanced != null ? advanced.value : this.advanced),
        typeUID: (typeUID != null ? typeUID.value : this.typeUID));
  }
}

@JsonSerializable(explicitToJson: true)
class ChannelGroupDefinitionDTO {
  const ChannelGroupDefinitionDTO({
    this.id,
    this.description,
    this.label,
    this.channels,
  });

  factory ChannelGroupDefinitionDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelGroupDefinitionDTOFromJson(json);

  static const toJsonFactory = _$ChannelGroupDefinitionDTOToJson;
  Map<String, dynamic> toJson() => _$ChannelGroupDefinitionDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'channels', defaultValue: <ChannelDefinitionDTO>[])
  final List<ChannelDefinitionDTO>? channels;
  static const fromJsonFactory = _$ChannelGroupDefinitionDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChannelGroupDefinitionDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.channels, channels) ||
                const DeepCollectionEquality()
                    .equals(other.channels, channels)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(channels) ^
      runtimeType.hashCode;
}

extension $ChannelGroupDefinitionDTOExtension on ChannelGroupDefinitionDTO {
  ChannelGroupDefinitionDTO copyWith(
      {String? id,
      String? description,
      String? label,
      List<ChannelDefinitionDTO>? channels}) {
    return ChannelGroupDefinitionDTO(
        id: id ?? this.id,
        description: description ?? this.description,
        label: label ?? this.label,
        channels: channels ?? this.channels);
  }

  ChannelGroupDefinitionDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? description,
      Wrapped<String?>? label,
      Wrapped<List<ChannelDefinitionDTO>?>? channels}) {
    return ChannelGroupDefinitionDTO(
        id: (id != null ? id.value : this.id),
        description:
            (description != null ? description.value : this.description),
        label: (label != null ? label.value : this.label),
        channels: (channels != null ? channels.value : this.channels));
  }
}

@JsonSerializable(explicitToJson: true)
class ThingTypeDTO {
  const ThingTypeDTO({
    this.uid,
    this.label,
    this.description,
    this.category,
    this.listed,
    this.supportedBridgeTypeUIDs,
    this.bridge,
    this.channels,
    this.channelGroups,
    this.configParameters,
    this.parameterGroups,
    this.properties,
    this.extensibleChannelTypeIds,
  });

  factory ThingTypeDTO.fromJson(Map<String, dynamic> json) =>
      _$ThingTypeDTOFromJson(json);

  static const toJsonFactory = _$ThingTypeDTOToJson;
  Map<String, dynamic> toJson() => _$ThingTypeDTOToJson(this);

  @JsonKey(name: 'UID')
  final String? uid;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'listed')
  final bool? listed;
  @JsonKey(name: 'supportedBridgeTypeUIDs', defaultValue: <String>[])
  final List<String>? supportedBridgeTypeUIDs;
  @JsonKey(name: 'bridge')
  final bool? bridge;
  @JsonKey(name: 'channels', defaultValue: <ChannelDefinitionDTO>[])
  final List<ChannelDefinitionDTO>? channels;
  @JsonKey(name: 'channelGroups', defaultValue: <ChannelGroupDefinitionDTO>[])
  final List<ChannelGroupDefinitionDTO>? channelGroups;
  @JsonKey(
      name: 'configParameters', defaultValue: <ConfigDescriptionParameterDTO>[])
  final List<ConfigDescriptionParameterDTO>? configParameters;
  @JsonKey(
      name: 'parameterGroups',
      defaultValue: <ConfigDescriptionParameterGroupDTO>[])
  final List<ConfigDescriptionParameterGroupDTO>? parameterGroups;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  @JsonKey(name: 'extensibleChannelTypeIds', defaultValue: <String>[])
  final List<String>? extensibleChannelTypeIds;
  static const fromJsonFactory = _$ThingTypeDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ThingTypeDTO &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.listed, listed) ||
                const DeepCollectionEquality().equals(other.listed, listed)) &&
            (identical(
                    other.supportedBridgeTypeUIDs, supportedBridgeTypeUIDs) ||
                const DeepCollectionEquality().equals(
                    other.supportedBridgeTypeUIDs, supportedBridgeTypeUIDs)) &&
            (identical(other.bridge, bridge) ||
                const DeepCollectionEquality().equals(other.bridge, bridge)) &&
            (identical(other.channels, channels) ||
                const DeepCollectionEquality()
                    .equals(other.channels, channels)) &&
            (identical(other.channelGroups, channelGroups) ||
                const DeepCollectionEquality()
                    .equals(other.channelGroups, channelGroups)) &&
            (identical(other.configParameters, configParameters) ||
                const DeepCollectionEquality()
                    .equals(other.configParameters, configParameters)) &&
            (identical(other.parameterGroups, parameterGroups) ||
                const DeepCollectionEquality()
                    .equals(other.parameterGroups, parameterGroups)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)) &&
            (identical(
                    other.extensibleChannelTypeIds, extensibleChannelTypeIds) ||
                const DeepCollectionEquality().equals(
                    other.extensibleChannelTypeIds, extensibleChannelTypeIds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(listed) ^
      const DeepCollectionEquality().hash(supportedBridgeTypeUIDs) ^
      const DeepCollectionEquality().hash(bridge) ^
      const DeepCollectionEquality().hash(channels) ^
      const DeepCollectionEquality().hash(channelGroups) ^
      const DeepCollectionEquality().hash(configParameters) ^
      const DeepCollectionEquality().hash(parameterGroups) ^
      const DeepCollectionEquality().hash(properties) ^
      const DeepCollectionEquality().hash(extensibleChannelTypeIds) ^
      runtimeType.hashCode;
}

extension $ThingTypeDTOExtension on ThingTypeDTO {
  ThingTypeDTO copyWith(
      {String? uid,
      String? label,
      String? description,
      String? category,
      bool? listed,
      List<String>? supportedBridgeTypeUIDs,
      bool? bridge,
      List<ChannelDefinitionDTO>? channels,
      List<ChannelGroupDefinitionDTO>? channelGroups,
      List<ConfigDescriptionParameterDTO>? configParameters,
      List<ConfigDescriptionParameterGroupDTO>? parameterGroups,
      Map<String, dynamic>? properties,
      List<String>? extensibleChannelTypeIds}) {
    return ThingTypeDTO(
        uid: uid ?? this.uid,
        label: label ?? this.label,
        description: description ?? this.description,
        category: category ?? this.category,
        listed: listed ?? this.listed,
        supportedBridgeTypeUIDs:
            supportedBridgeTypeUIDs ?? this.supportedBridgeTypeUIDs,
        bridge: bridge ?? this.bridge,
        channels: channels ?? this.channels,
        channelGroups: channelGroups ?? this.channelGroups,
        configParameters: configParameters ?? this.configParameters,
        parameterGroups: parameterGroups ?? this.parameterGroups,
        properties: properties ?? this.properties,
        extensibleChannelTypeIds:
            extensibleChannelTypeIds ?? this.extensibleChannelTypeIds);
  }

  ThingTypeDTO copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<String?>? category,
      Wrapped<bool?>? listed,
      Wrapped<List<String>?>? supportedBridgeTypeUIDs,
      Wrapped<bool?>? bridge,
      Wrapped<List<ChannelDefinitionDTO>?>? channels,
      Wrapped<List<ChannelGroupDefinitionDTO>?>? channelGroups,
      Wrapped<List<ConfigDescriptionParameterDTO>?>? configParameters,
      Wrapped<List<ConfigDescriptionParameterGroupDTO>?>? parameterGroups,
      Wrapped<Map<String, dynamic>?>? properties,
      Wrapped<List<String>?>? extensibleChannelTypeIds}) {
    return ThingTypeDTO(
        uid: (uid != null ? uid.value : this.uid),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        category: (category != null ? category.value : this.category),
        listed: (listed != null ? listed.value : this.listed),
        supportedBridgeTypeUIDs: (supportedBridgeTypeUIDs != null
            ? supportedBridgeTypeUIDs.value
            : this.supportedBridgeTypeUIDs),
        bridge: (bridge != null ? bridge.value : this.bridge),
        channels: (channels != null ? channels.value : this.channels),
        channelGroups:
            (channelGroups != null ? channelGroups.value : this.channelGroups),
        configParameters: (configParameters != null
            ? configParameters.value
            : this.configParameters),
        parameterGroups: (parameterGroups != null
            ? parameterGroups.value
            : this.parameterGroups),
        properties: (properties != null ? properties.value : this.properties),
        extensibleChannelTypeIds: (extensibleChannelTypeIds != null
            ? extensibleChannelTypeIds.value
            : this.extensibleChannelTypeIds));
  }
}

@JsonSerializable(explicitToJson: true)
class Links {
  const Links({
    this.type,
    this.url,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  static const toJsonFactory = _$LinksToJson;
  Map<String, dynamic> toJson() => _$LinksToJson(this);

  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'url')
  final String? url;
  static const fromJsonFactory = _$LinksFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Links &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(url) ^
      runtimeType.hashCode;
}

extension $LinksExtension on Links {
  Links copyWith({String? type, String? url}) {
    return Links(type: type ?? this.type, url: url ?? this.url);
  }

  Links copyWithWrapped({Wrapped<String?>? type, Wrapped<String?>? url}) {
    return Links(
        type: (type != null ? type.value : this.type),
        url: (url != null ? url.value : this.url));
  }
}

@JsonSerializable(explicitToJson: true)
class RootBean {
  const RootBean({
    this.version,
    this.locale,
    this.measurementSystem,
    this.runtimeInfo,
    this.links,
  });

  factory RootBean.fromJson(Map<String, dynamic> json) =>
      _$RootBeanFromJson(json);

  static const toJsonFactory = _$RootBeanToJson;
  Map<String, dynamic> toJson() => _$RootBeanToJson(this);

  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'locale')
  final String? locale;
  @JsonKey(name: 'measurementSystem')
  final String? measurementSystem;
  @JsonKey(name: 'runtimeInfo')
  final RuntimeInfo? runtimeInfo;
  @JsonKey(name: 'links', defaultValue: <Links>[])
  final List<Links>? links;
  static const fromJsonFactory = _$RootBeanFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RootBean &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.locale, locale) ||
                const DeepCollectionEquality().equals(other.locale, locale)) &&
            (identical(other.measurementSystem, measurementSystem) ||
                const DeepCollectionEquality()
                    .equals(other.measurementSystem, measurementSystem)) &&
            (identical(other.runtimeInfo, runtimeInfo) ||
                const DeepCollectionEquality()
                    .equals(other.runtimeInfo, runtimeInfo)) &&
            (identical(other.links, links) ||
                const DeepCollectionEquality().equals(other.links, links)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(locale) ^
      const DeepCollectionEquality().hash(measurementSystem) ^
      const DeepCollectionEquality().hash(runtimeInfo) ^
      const DeepCollectionEquality().hash(links) ^
      runtimeType.hashCode;
}

extension $RootBeanExtension on RootBean {
  RootBean copyWith(
      {String? version,
      String? locale,
      String? measurementSystem,
      RuntimeInfo? runtimeInfo,
      List<Links>? links}) {
    return RootBean(
        version: version ?? this.version,
        locale: locale ?? this.locale,
        measurementSystem: measurementSystem ?? this.measurementSystem,
        runtimeInfo: runtimeInfo ?? this.runtimeInfo,
        links: links ?? this.links);
  }

  RootBean copyWithWrapped(
      {Wrapped<String?>? version,
      Wrapped<String?>? locale,
      Wrapped<String?>? measurementSystem,
      Wrapped<RuntimeInfo?>? runtimeInfo,
      Wrapped<List<Links>?>? links}) {
    return RootBean(
        version: (version != null ? version.value : this.version),
        locale: (locale != null ? locale.value : this.locale),
        measurementSystem: (measurementSystem != null
            ? measurementSystem.value
            : this.measurementSystem),
        runtimeInfo:
            (runtimeInfo != null ? runtimeInfo.value : this.runtimeInfo),
        links: (links != null ? links.value : this.links));
  }
}

@JsonSerializable(explicitToJson: true)
class RuntimeInfo {
  const RuntimeInfo({
    this.version,
    this.buildString,
  });

  factory RuntimeInfo.fromJson(Map<String, dynamic> json) =>
      _$RuntimeInfoFromJson(json);

  static const toJsonFactory = _$RuntimeInfoToJson;
  Map<String, dynamic> toJson() => _$RuntimeInfoToJson(this);

  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'buildString')
  final String? buildString;
  static const fromJsonFactory = _$RuntimeInfoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RuntimeInfo &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.buildString, buildString) ||
                const DeepCollectionEquality()
                    .equals(other.buildString, buildString)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(buildString) ^
      runtimeType.hashCode;
}

extension $RuntimeInfoExtension on RuntimeInfo {
  RuntimeInfo copyWith({String? version, String? buildString}) {
    return RuntimeInfo(
        version: version ?? this.version,
        buildString: buildString ?? this.buildString);
  }

  RuntimeInfo copyWithWrapped(
      {Wrapped<String?>? version, Wrapped<String?>? buildString}) {
    return RuntimeInfo(
        version: (version != null ? version.value : this.version),
        buildString:
            (buildString != null ? buildString.value : this.buildString));
  }
}

@JsonSerializable(explicitToJson: true)
class SystemInfo {
  const SystemInfo({
    this.configFolder,
    this.userdataFolder,
    this.logFolder,
    this.javaVersion,
    this.javaVendor,
    this.javaVendorVersion,
    this.osName,
    this.osVersion,
    this.osArchitecture,
    this.availableProcessors,
    this.freeMemory,
    this.totalMemory,
    this.startLevel,
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) =>
      _$SystemInfoFromJson(json);

  static const toJsonFactory = _$SystemInfoToJson;
  Map<String, dynamic> toJson() => _$SystemInfoToJson(this);

  @JsonKey(name: 'configFolder')
  final String? configFolder;
  @JsonKey(name: 'userdataFolder')
  final String? userdataFolder;
  @JsonKey(name: 'logFolder')
  final String? logFolder;
  @JsonKey(name: 'javaVersion')
  final String? javaVersion;
  @JsonKey(name: 'javaVendor')
  final String? javaVendor;
  @JsonKey(name: 'javaVendorVersion')
  final String? javaVendorVersion;
  @JsonKey(name: 'osName')
  final String? osName;
  @JsonKey(name: 'osVersion')
  final String? osVersion;
  @JsonKey(name: 'osArchitecture')
  final String? osArchitecture;
  @JsonKey(name: 'availableProcessors')
  final int? availableProcessors;
  @JsonKey(name: 'freeMemory')
  final int? freeMemory;
  @JsonKey(name: 'totalMemory')
  final int? totalMemory;
  @JsonKey(name: 'startLevel')
  final int? startLevel;
  static const fromJsonFactory = _$SystemInfoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SystemInfo &&
            (identical(other.configFolder, configFolder) ||
                const DeepCollectionEquality()
                    .equals(other.configFolder, configFolder)) &&
            (identical(other.userdataFolder, userdataFolder) ||
                const DeepCollectionEquality()
                    .equals(other.userdataFolder, userdataFolder)) &&
            (identical(other.logFolder, logFolder) ||
                const DeepCollectionEquality()
                    .equals(other.logFolder, logFolder)) &&
            (identical(other.javaVersion, javaVersion) ||
                const DeepCollectionEquality()
                    .equals(other.javaVersion, javaVersion)) &&
            (identical(other.javaVendor, javaVendor) ||
                const DeepCollectionEquality()
                    .equals(other.javaVendor, javaVendor)) &&
            (identical(other.javaVendorVersion, javaVendorVersion) ||
                const DeepCollectionEquality()
                    .equals(other.javaVendorVersion, javaVendorVersion)) &&
            (identical(other.osName, osName) ||
                const DeepCollectionEquality().equals(other.osName, osName)) &&
            (identical(other.osVersion, osVersion) ||
                const DeepCollectionEquality()
                    .equals(other.osVersion, osVersion)) &&
            (identical(other.osArchitecture, osArchitecture) ||
                const DeepCollectionEquality()
                    .equals(other.osArchitecture, osArchitecture)) &&
            (identical(other.availableProcessors, availableProcessors) ||
                const DeepCollectionEquality()
                    .equals(other.availableProcessors, availableProcessors)) &&
            (identical(other.freeMemory, freeMemory) ||
                const DeepCollectionEquality()
                    .equals(other.freeMemory, freeMemory)) &&
            (identical(other.totalMemory, totalMemory) ||
                const DeepCollectionEquality()
                    .equals(other.totalMemory, totalMemory)) &&
            (identical(other.startLevel, startLevel) ||
                const DeepCollectionEquality()
                    .equals(other.startLevel, startLevel)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(configFolder) ^
      const DeepCollectionEquality().hash(userdataFolder) ^
      const DeepCollectionEquality().hash(logFolder) ^
      const DeepCollectionEquality().hash(javaVersion) ^
      const DeepCollectionEquality().hash(javaVendor) ^
      const DeepCollectionEquality().hash(javaVendorVersion) ^
      const DeepCollectionEquality().hash(osName) ^
      const DeepCollectionEquality().hash(osVersion) ^
      const DeepCollectionEquality().hash(osArchitecture) ^
      const DeepCollectionEquality().hash(availableProcessors) ^
      const DeepCollectionEquality().hash(freeMemory) ^
      const DeepCollectionEquality().hash(totalMemory) ^
      const DeepCollectionEquality().hash(startLevel) ^
      runtimeType.hashCode;
}

extension $SystemInfoExtension on SystemInfo {
  SystemInfo copyWith(
      {String? configFolder,
      String? userdataFolder,
      String? logFolder,
      String? javaVersion,
      String? javaVendor,
      String? javaVendorVersion,
      String? osName,
      String? osVersion,
      String? osArchitecture,
      int? availableProcessors,
      int? freeMemory,
      int? totalMemory,
      int? startLevel}) {
    return SystemInfo(
        configFolder: configFolder ?? this.configFolder,
        userdataFolder: userdataFolder ?? this.userdataFolder,
        logFolder: logFolder ?? this.logFolder,
        javaVersion: javaVersion ?? this.javaVersion,
        javaVendor: javaVendor ?? this.javaVendor,
        javaVendorVersion: javaVendorVersion ?? this.javaVendorVersion,
        osName: osName ?? this.osName,
        osVersion: osVersion ?? this.osVersion,
        osArchitecture: osArchitecture ?? this.osArchitecture,
        availableProcessors: availableProcessors ?? this.availableProcessors,
        freeMemory: freeMemory ?? this.freeMemory,
        totalMemory: totalMemory ?? this.totalMemory,
        startLevel: startLevel ?? this.startLevel);
  }

  SystemInfo copyWithWrapped(
      {Wrapped<String?>? configFolder,
      Wrapped<String?>? userdataFolder,
      Wrapped<String?>? logFolder,
      Wrapped<String?>? javaVersion,
      Wrapped<String?>? javaVendor,
      Wrapped<String?>? javaVendorVersion,
      Wrapped<String?>? osName,
      Wrapped<String?>? osVersion,
      Wrapped<String?>? osArchitecture,
      Wrapped<int?>? availableProcessors,
      Wrapped<int?>? freeMemory,
      Wrapped<int?>? totalMemory,
      Wrapped<int?>? startLevel}) {
    return SystemInfo(
        configFolder:
            (configFolder != null ? configFolder.value : this.configFolder),
        userdataFolder: (userdataFolder != null
            ? userdataFolder.value
            : this.userdataFolder),
        logFolder: (logFolder != null ? logFolder.value : this.logFolder),
        javaVersion:
            (javaVersion != null ? javaVersion.value : this.javaVersion),
        javaVendor: (javaVendor != null ? javaVendor.value : this.javaVendor),
        javaVendorVersion: (javaVendorVersion != null
            ? javaVendorVersion.value
            : this.javaVendorVersion),
        osName: (osName != null ? osName.value : this.osName),
        osVersion: (osVersion != null ? osVersion.value : this.osVersion),
        osArchitecture: (osArchitecture != null
            ? osArchitecture.value
            : this.osArchitecture),
        availableProcessors: (availableProcessors != null
            ? availableProcessors.value
            : this.availableProcessors),
        freeMemory: (freeMemory != null ? freeMemory.value : this.freeMemory),
        totalMemory:
            (totalMemory != null ? totalMemory.value : this.totalMemory),
        startLevel: (startLevel != null ? startLevel.value : this.startLevel));
  }
}

@JsonSerializable(explicitToJson: true)
class SystemInfoBean {
  const SystemInfoBean({
    this.systemInfo,
  });

  factory SystemInfoBean.fromJson(Map<String, dynamic> json) =>
      _$SystemInfoBeanFromJson(json);

  static const toJsonFactory = _$SystemInfoBeanToJson;
  Map<String, dynamic> toJson() => _$SystemInfoBeanToJson(this);

  @JsonKey(name: 'systemInfo')
  final SystemInfo? systemInfo;
  static const fromJsonFactory = _$SystemInfoBeanFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SystemInfoBean &&
            (identical(other.systemInfo, systemInfo) ||
                const DeepCollectionEquality()
                    .equals(other.systemInfo, systemInfo)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(systemInfo) ^ runtimeType.hashCode;
}

extension $SystemInfoBeanExtension on SystemInfoBean {
  SystemInfoBean copyWith({SystemInfo? systemInfo}) {
    return SystemInfoBean(systemInfo: systemInfo ?? this.systemInfo);
  }

  SystemInfoBean copyWithWrapped({Wrapped<SystemInfo?>? systemInfo}) {
    return SystemInfoBean(
        systemInfo: (systemInfo != null ? systemInfo.value : this.systemInfo));
  }
}

@JsonSerializable(explicitToJson: true)
class DimensionInfo {
  const DimensionInfo({
    this.dimension,
    this.systemUnit,
  });

  factory DimensionInfo.fromJson(Map<String, dynamic> json) =>
      _$DimensionInfoFromJson(json);

  static const toJsonFactory = _$DimensionInfoToJson;
  Map<String, dynamic> toJson() => _$DimensionInfoToJson(this);

  @JsonKey(name: 'dimension')
  final String? dimension;
  @JsonKey(name: 'systemUnit')
  final String? systemUnit;
  static const fromJsonFactory = _$DimensionInfoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DimensionInfo &&
            (identical(other.dimension, dimension) ||
                const DeepCollectionEquality()
                    .equals(other.dimension, dimension)) &&
            (identical(other.systemUnit, systemUnit) ||
                const DeepCollectionEquality()
                    .equals(other.systemUnit, systemUnit)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dimension) ^
      const DeepCollectionEquality().hash(systemUnit) ^
      runtimeType.hashCode;
}

extension $DimensionInfoExtension on DimensionInfo {
  DimensionInfo copyWith({String? dimension, String? systemUnit}) {
    return DimensionInfo(
        dimension: dimension ?? this.dimension,
        systemUnit: systemUnit ?? this.systemUnit);
  }

  DimensionInfo copyWithWrapped(
      {Wrapped<String?>? dimension, Wrapped<String?>? systemUnit}) {
    return DimensionInfo(
        dimension: (dimension != null ? dimension.value : this.dimension),
        systemUnit: (systemUnit != null ? systemUnit.value : this.systemUnit));
  }
}

@JsonSerializable(explicitToJson: true)
class UoMInfo {
  const UoMInfo({
    this.dimensions,
  });

  factory UoMInfo.fromJson(Map<String, dynamic> json) =>
      _$UoMInfoFromJson(json);

  static const toJsonFactory = _$UoMInfoToJson;
  Map<String, dynamic> toJson() => _$UoMInfoToJson(this);

  @JsonKey(name: 'dimensions', defaultValue: <DimensionInfo>[])
  final List<DimensionInfo>? dimensions;
  static const fromJsonFactory = _$UoMInfoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UoMInfo &&
            (identical(other.dimensions, dimensions) ||
                const DeepCollectionEquality()
                    .equals(other.dimensions, dimensions)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dimensions) ^ runtimeType.hashCode;
}

extension $UoMInfoExtension on UoMInfo {
  UoMInfo copyWith({List<DimensionInfo>? dimensions}) {
    return UoMInfo(dimensions: dimensions ?? this.dimensions);
  }

  UoMInfo copyWithWrapped({Wrapped<List<DimensionInfo>?>? dimensions}) {
    return UoMInfo(
        dimensions: (dimensions != null ? dimensions.value : this.dimensions));
  }
}

@JsonSerializable(explicitToJson: true)
class UoMInfoBean {
  const UoMInfoBean({
    this.uomInfo,
  });

  factory UoMInfoBean.fromJson(Map<String, dynamic> json) =>
      _$UoMInfoBeanFromJson(json);

  static const toJsonFactory = _$UoMInfoBeanToJson;
  Map<String, dynamic> toJson() => _$UoMInfoBeanToJson(this);

  @JsonKey(name: 'uomInfo')
  final UoMInfo? uomInfo;
  static const fromJsonFactory = _$UoMInfoBeanFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UoMInfoBean &&
            (identical(other.uomInfo, uomInfo) ||
                const DeepCollectionEquality().equals(other.uomInfo, uomInfo)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uomInfo) ^ runtimeType.hashCode;
}

extension $UoMInfoBeanExtension on UoMInfoBean {
  UoMInfoBean copyWith({UoMInfo? uomInfo}) {
    return UoMInfoBean(uomInfo: uomInfo ?? this.uomInfo);
  }

  UoMInfoBean copyWithWrapped({Wrapped<UoMInfo?>? uomInfo}) {
    return UoMInfoBean(
        uomInfo: (uomInfo != null ? uomInfo.value : this.uomInfo));
  }
}

@JsonSerializable(explicitToJson: true)
class MappingDTO {
  const MappingDTO({
    this.command,
    this.label,
  });

  factory MappingDTO.fromJson(Map<String, dynamic> json) =>
      _$MappingDTOFromJson(json);

  static const toJsonFactory = _$MappingDTOToJson;
  Map<String, dynamic> toJson() => _$MappingDTOToJson(this);

  @JsonKey(name: 'command')
  final String? command;
  @JsonKey(name: 'label')
  final String? label;
  static const fromJsonFactory = _$MappingDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MappingDTO &&
            (identical(other.command, command) ||
                const DeepCollectionEquality()
                    .equals(other.command, command)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(command) ^
      const DeepCollectionEquality().hash(label) ^
      runtimeType.hashCode;
}

extension $MappingDTOExtension on MappingDTO {
  MappingDTO copyWith({String? command, String? label}) {
    return MappingDTO(
        command: command ?? this.command, label: label ?? this.label);
  }

  MappingDTO copyWithWrapped(
      {Wrapped<String?>? command, Wrapped<String?>? label}) {
    return MappingDTO(
        command: (command != null ? command.value : this.command),
        label: (label != null ? label.value : this.label));
  }
}

@JsonSerializable(explicitToJson: true)
class PageDTO {
  const PageDTO({
    this.id,
    this.title,
    this.icon,
    this.link,
    this.parent,
    this.leaf,
    this.timeout,
    this.widgets,
  });

  factory PageDTO.fromJson(Map<String, dynamic> json) =>
      _$PageDTOFromJson(json);

  static const toJsonFactory = _$PageDTOToJson;
  Map<String, dynamic> toJson() => _$PageDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'icon')
  final String? icon;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'parent')
  final PageDTO? parent;
  @JsonKey(name: 'leaf')
  final bool? leaf;
  @JsonKey(name: 'timeout')
  final bool? timeout;
  @JsonKey(name: 'widgets', defaultValue: <WidgetDTO>[])
  final List<WidgetDTO>? widgets;
  static const fromJsonFactory = _$PageDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PageDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.icon, icon) ||
                const DeepCollectionEquality().equals(other.icon, icon)) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.parent, parent) ||
                const DeepCollectionEquality().equals(other.parent, parent)) &&
            (identical(other.leaf, leaf) ||
                const DeepCollectionEquality().equals(other.leaf, leaf)) &&
            (identical(other.timeout, timeout) ||
                const DeepCollectionEquality()
                    .equals(other.timeout, timeout)) &&
            (identical(other.widgets, widgets) ||
                const DeepCollectionEquality().equals(other.widgets, widgets)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(icon) ^
      const DeepCollectionEquality().hash(link) ^
      const DeepCollectionEquality().hash(parent) ^
      const DeepCollectionEquality().hash(leaf) ^
      const DeepCollectionEquality().hash(timeout) ^
      const DeepCollectionEquality().hash(widgets) ^
      runtimeType.hashCode;
}

extension $PageDTOExtension on PageDTO {
  PageDTO copyWith(
      {String? id,
      String? title,
      String? icon,
      String? link,
      PageDTO? parent,
      bool? leaf,
      bool? timeout,
      List<WidgetDTO>? widgets}) {
    return PageDTO(
        id: id ?? this.id,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        link: link ?? this.link,
        parent: parent ?? this.parent,
        leaf: leaf ?? this.leaf,
        timeout: timeout ?? this.timeout,
        widgets: widgets ?? this.widgets);
  }

  PageDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? title,
      Wrapped<String?>? icon,
      Wrapped<String?>? link,
      Wrapped<PageDTO?>? parent,
      Wrapped<bool?>? leaf,
      Wrapped<bool?>? timeout,
      Wrapped<List<WidgetDTO>?>? widgets}) {
    return PageDTO(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        icon: (icon != null ? icon.value : this.icon),
        link: (link != null ? link.value : this.link),
        parent: (parent != null ? parent.value : this.parent),
        leaf: (leaf != null ? leaf.value : this.leaf),
        timeout: (timeout != null ? timeout.value : this.timeout),
        widgets: (widgets != null ? widgets.value : this.widgets));
  }
}

@JsonSerializable(explicitToJson: true)
class WidgetDTO {
  const WidgetDTO({
    this.widgetId,
    this.type,
    this.name,
    this.visibility,
    this.label,
    this.icon,
    this.labelcolor,
    this.valuecolor,
    this.iconcolor,
    this.pattern,
    this.unit,
    this.mappings,
    this.switchSupport,
    this.sendFrequency,
    this.refresh,
    this.height,
    this.minValue,
    this.maxValue,
    this.step,
    this.inputHint,
    this.url,
    this.encoding,
    this.service,
    this.period,
    this.yAxisDecimalPattern,
    this.legend,
    this.forceAsItem,
    this.state,
    this.item,
    this.linkedPage,
  });

  factory WidgetDTO.fromJson(Map<String, dynamic> json) =>
      _$WidgetDTOFromJson(json);

  static const toJsonFactory = _$WidgetDTOToJson;
  Map<String, dynamic> toJson() => _$WidgetDTOToJson(this);

  @JsonKey(name: 'widgetId')
  final String? widgetId;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'visibility')
  final bool? visibility;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'icon')
  final String? icon;
  @JsonKey(name: 'labelcolor')
  final String? labelcolor;
  @JsonKey(name: 'valuecolor')
  final String? valuecolor;
  @JsonKey(name: 'iconcolor')
  final String? iconcolor;
  @JsonKey(name: 'pattern')
  final String? pattern;
  @JsonKey(name: 'unit')
  final String? unit;
  @JsonKey(name: 'mappings', defaultValue: <MappingDTO>[])
  final List<MappingDTO>? mappings;
  @JsonKey(name: 'switchSupport')
  final bool? switchSupport;
  @JsonKey(name: 'sendFrequency')
  final int? sendFrequency;
  @JsonKey(name: 'refresh')
  final int? refresh;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'minValue')
  final double? minValue;
  @JsonKey(name: 'maxValue')
  final double? maxValue;
  @JsonKey(name: 'step')
  final double? step;
  @JsonKey(name: 'inputHint')
  final String? inputHint;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'encoding')
  final String? encoding;
  @JsonKey(name: 'service')
  final String? service;
  @JsonKey(name: 'period')
  final String? period;
  @JsonKey(name: 'yAxisDecimalPattern')
  final String? yAxisDecimalPattern;
  @JsonKey(name: 'legend')
  final bool? legend;
  @JsonKey(name: 'forceAsItem')
  final bool? forceAsItem;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'item')
  final EnrichedItemDTO? item;
  @JsonKey(name: 'linkedPage')
  final PageDTO? linkedPage;
  static const fromJsonFactory = _$WidgetDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WidgetDTO &&
            (identical(other.widgetId, widgetId) ||
                const DeepCollectionEquality()
                    .equals(other.widgetId, widgetId)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.visibility, visibility) ||
                const DeepCollectionEquality()
                    .equals(other.visibility, visibility)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.icon, icon) ||
                const DeepCollectionEquality().equals(other.icon, icon)) &&
            (identical(other.labelcolor, labelcolor) ||
                const DeepCollectionEquality()
                    .equals(other.labelcolor, labelcolor)) &&
            (identical(other.valuecolor, valuecolor) ||
                const DeepCollectionEquality()
                    .equals(other.valuecolor, valuecolor)) &&
            (identical(other.iconcolor, iconcolor) ||
                const DeepCollectionEquality()
                    .equals(other.iconcolor, iconcolor)) &&
            (identical(other.pattern, pattern) ||
                const DeepCollectionEquality()
                    .equals(other.pattern, pattern)) &&
            (identical(other.unit, unit) ||
                const DeepCollectionEquality().equals(other.unit, unit)) &&
            (identical(other.mappings, mappings) ||
                const DeepCollectionEquality()
                    .equals(other.mappings, mappings)) &&
            (identical(other.switchSupport, switchSupport) ||
                const DeepCollectionEquality()
                    .equals(other.switchSupport, switchSupport)) &&
            (identical(other.sendFrequency, sendFrequency) ||
                const DeepCollectionEquality()
                    .equals(other.sendFrequency, sendFrequency)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality()
                    .equals(other.refresh, refresh)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.minValue, minValue) ||
                const DeepCollectionEquality()
                    .equals(other.minValue, minValue)) &&
            (identical(other.maxValue, maxValue) ||
                const DeepCollectionEquality()
                    .equals(other.maxValue, maxValue)) &&
            (identical(other.step, step) ||
                const DeepCollectionEquality().equals(other.step, step)) &&
            (identical(other.inputHint, inputHint) ||
                const DeepCollectionEquality()
                    .equals(other.inputHint, inputHint)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.encoding, encoding) ||
                const DeepCollectionEquality()
                    .equals(other.encoding, encoding)) &&
            (identical(other.service, service) ||
                const DeepCollectionEquality()
                    .equals(other.service, service)) &&
            (identical(other.period, period) ||
                const DeepCollectionEquality().equals(other.period, period)) &&
            (identical(other.yAxisDecimalPattern, yAxisDecimalPattern) ||
                const DeepCollectionEquality()
                    .equals(other.yAxisDecimalPattern, yAxisDecimalPattern)) &&
            (identical(other.legend, legend) ||
                const DeepCollectionEquality().equals(other.legend, legend)) &&
            (identical(other.forceAsItem, forceAsItem) ||
                const DeepCollectionEquality().equals(other.forceAsItem, forceAsItem)) &&
            (identical(other.state, state) || const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.item, item) || const DeepCollectionEquality().equals(other.item, item)) &&
            (identical(other.linkedPage, linkedPage) || const DeepCollectionEquality().equals(other.linkedPage, linkedPage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(widgetId) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(visibility) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(icon) ^
      const DeepCollectionEquality().hash(labelcolor) ^
      const DeepCollectionEquality().hash(valuecolor) ^
      const DeepCollectionEquality().hash(iconcolor) ^
      const DeepCollectionEquality().hash(pattern) ^
      const DeepCollectionEquality().hash(unit) ^
      const DeepCollectionEquality().hash(mappings) ^
      const DeepCollectionEquality().hash(switchSupport) ^
      const DeepCollectionEquality().hash(sendFrequency) ^
      const DeepCollectionEquality().hash(refresh) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(minValue) ^
      const DeepCollectionEquality().hash(maxValue) ^
      const DeepCollectionEquality().hash(step) ^
      const DeepCollectionEquality().hash(inputHint) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(encoding) ^
      const DeepCollectionEquality().hash(service) ^
      const DeepCollectionEquality().hash(period) ^
      const DeepCollectionEquality().hash(yAxisDecimalPattern) ^
      const DeepCollectionEquality().hash(legend) ^
      const DeepCollectionEquality().hash(forceAsItem) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(item) ^
      const DeepCollectionEquality().hash(linkedPage) ^
      runtimeType.hashCode;
}

extension $WidgetDTOExtension on WidgetDTO {
  WidgetDTO copyWith(
      {String? widgetId,
      String? type,
      String? name,
      bool? visibility,
      String? label,
      String? icon,
      String? labelcolor,
      String? valuecolor,
      String? iconcolor,
      String? pattern,
      String? unit,
      List<MappingDTO>? mappings,
      bool? switchSupport,
      int? sendFrequency,
      int? refresh,
      int? height,
      double? minValue,
      double? maxValue,
      double? step,
      String? inputHint,
      String? url,
      String? encoding,
      String? service,
      String? period,
      String? yAxisDecimalPattern,
      bool? legend,
      bool? forceAsItem,
      String? state,
      EnrichedItemDTO? item,
      PageDTO? linkedPage}) {
    return WidgetDTO(
        widgetId: widgetId ?? this.widgetId,
        type: type ?? this.type,
        name: name ?? this.name,
        visibility: visibility ?? this.visibility,
        label: label ?? this.label,
        icon: icon ?? this.icon,
        labelcolor: labelcolor ?? this.labelcolor,
        valuecolor: valuecolor ?? this.valuecolor,
        iconcolor: iconcolor ?? this.iconcolor,
        pattern: pattern ?? this.pattern,
        unit: unit ?? this.unit,
        mappings: mappings ?? this.mappings,
        switchSupport: switchSupport ?? this.switchSupport,
        sendFrequency: sendFrequency ?? this.sendFrequency,
        refresh: refresh ?? this.refresh,
        height: height ?? this.height,
        minValue: minValue ?? this.minValue,
        maxValue: maxValue ?? this.maxValue,
        step: step ?? this.step,
        inputHint: inputHint ?? this.inputHint,
        url: url ?? this.url,
        encoding: encoding ?? this.encoding,
        service: service ?? this.service,
        period: period ?? this.period,
        yAxisDecimalPattern: yAxisDecimalPattern ?? this.yAxisDecimalPattern,
        legend: legend ?? this.legend,
        forceAsItem: forceAsItem ?? this.forceAsItem,
        state: state ?? this.state,
        item: item ?? this.item,
        linkedPage: linkedPage ?? this.linkedPage);
  }

  WidgetDTO copyWithWrapped(
      {Wrapped<String?>? widgetId,
      Wrapped<String?>? type,
      Wrapped<String?>? name,
      Wrapped<bool?>? visibility,
      Wrapped<String?>? label,
      Wrapped<String?>? icon,
      Wrapped<String?>? labelcolor,
      Wrapped<String?>? valuecolor,
      Wrapped<String?>? iconcolor,
      Wrapped<String?>? pattern,
      Wrapped<String?>? unit,
      Wrapped<List<MappingDTO>?>? mappings,
      Wrapped<bool?>? switchSupport,
      Wrapped<int?>? sendFrequency,
      Wrapped<int?>? refresh,
      Wrapped<int?>? height,
      Wrapped<double?>? minValue,
      Wrapped<double?>? maxValue,
      Wrapped<double?>? step,
      Wrapped<String?>? inputHint,
      Wrapped<String?>? url,
      Wrapped<String?>? encoding,
      Wrapped<String?>? service,
      Wrapped<String?>? period,
      Wrapped<String?>? yAxisDecimalPattern,
      Wrapped<bool?>? legend,
      Wrapped<bool?>? forceAsItem,
      Wrapped<String?>? state,
      Wrapped<EnrichedItemDTO?>? item,
      Wrapped<PageDTO?>? linkedPage}) {
    return WidgetDTO(
        widgetId: (widgetId != null ? widgetId.value : this.widgetId),
        type: (type != null ? type.value : this.type),
        name: (name != null ? name.value : this.name),
        visibility: (visibility != null ? visibility.value : this.visibility),
        label: (label != null ? label.value : this.label),
        icon: (icon != null ? icon.value : this.icon),
        labelcolor: (labelcolor != null ? labelcolor.value : this.labelcolor),
        valuecolor: (valuecolor != null ? valuecolor.value : this.valuecolor),
        iconcolor: (iconcolor != null ? iconcolor.value : this.iconcolor),
        pattern: (pattern != null ? pattern.value : this.pattern),
        unit: (unit != null ? unit.value : this.unit),
        mappings: (mappings != null ? mappings.value : this.mappings),
        switchSupport:
            (switchSupport != null ? switchSupport.value : this.switchSupport),
        sendFrequency:
            (sendFrequency != null ? sendFrequency.value : this.sendFrequency),
        refresh: (refresh != null ? refresh.value : this.refresh),
        height: (height != null ? height.value : this.height),
        minValue: (minValue != null ? minValue.value : this.minValue),
        maxValue: (maxValue != null ? maxValue.value : this.maxValue),
        step: (step != null ? step.value : this.step),
        inputHint: (inputHint != null ? inputHint.value : this.inputHint),
        url: (url != null ? url.value : this.url),
        encoding: (encoding != null ? encoding.value : this.encoding),
        service: (service != null ? service.value : this.service),
        period: (period != null ? period.value : this.period),
        yAxisDecimalPattern: (yAxisDecimalPattern != null
            ? yAxisDecimalPattern.value
            : this.yAxisDecimalPattern),
        legend: (legend != null ? legend.value : this.legend),
        forceAsItem:
            (forceAsItem != null ? forceAsItem.value : this.forceAsItem),
        state: (state != null ? state.value : this.state),
        item: (item != null ? item.value : this.item),
        linkedPage: (linkedPage != null ? linkedPage.value : this.linkedPage));
  }
}

@JsonSerializable(explicitToJson: true)
class SitemapDTO {
  const SitemapDTO({
    this.name,
    this.icon,
    this.label,
    this.link,
    this.homepage,
  });

  factory SitemapDTO.fromJson(Map<String, dynamic> json) =>
      _$SitemapDTOFromJson(json);

  static const toJsonFactory = _$SitemapDTOToJson;
  Map<String, dynamic> toJson() => _$SitemapDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'icon')
  final String? icon;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'homepage')
  final PageDTO? homepage;
  static const fromJsonFactory = _$SitemapDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SitemapDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.icon, icon) ||
                const DeepCollectionEquality().equals(other.icon, icon)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.homepage, homepage) ||
                const DeepCollectionEquality()
                    .equals(other.homepage, homepage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(icon) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(link) ^
      const DeepCollectionEquality().hash(homepage) ^
      runtimeType.hashCode;
}

extension $SitemapDTOExtension on SitemapDTO {
  SitemapDTO copyWith(
      {String? name,
      String? icon,
      String? label,
      String? link,
      PageDTO? homepage}) {
    return SitemapDTO(
        name: name ?? this.name,
        icon: icon ?? this.icon,
        label: label ?? this.label,
        link: link ?? this.link,
        homepage: homepage ?? this.homepage);
  }

  SitemapDTO copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? icon,
      Wrapped<String?>? label,
      Wrapped<String?>? link,
      Wrapped<PageDTO?>? homepage}) {
    return SitemapDTO(
        name: (name != null ? name.value : this.name),
        icon: (icon != null ? icon.value : this.icon),
        label: (label != null ? label.value : this.label),
        link: (link != null ? link.value : this.link),
        homepage: (homepage != null ? homepage.value : this.homepage));
  }
}

@JsonSerializable(explicitToJson: true)
class Transformation {
  const Transformation({
    this.uid,
    this.label,
    this.type,
    this.configuration,
  });

  factory Transformation.fromJson(Map<String, dynamic> json) =>
      _$TransformationFromJson(json);

  static const toJsonFactory = _$TransformationToJson;
  Map<String, dynamic> toJson() => _$TransformationToJson(this);

  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  static const fromJsonFactory = _$TransformationFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Transformation &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(configuration) ^
      runtimeType.hashCode;
}

extension $TransformationExtension on Transformation {
  Transformation copyWith(
      {String? uid,
      String? label,
      String? type,
      Map<String, dynamic>? configuration}) {
    return Transformation(
        uid: uid ?? this.uid,
        label: label ?? this.label,
        type: type ?? this.type,
        configuration: configuration ?? this.configuration);
  }

  Transformation copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<String?>? label,
      Wrapped<String?>? type,
      Wrapped<Map<String, dynamic>?>? configuration}) {
    return Transformation(
        uid: (uid != null ? uid.value : this.uid),
        label: (label != null ? label.value : this.label),
        type: (type != null ? type.value : this.type),
        configuration:
            (configuration != null ? configuration.value : this.configuration));
  }
}

@JsonSerializable(explicitToJson: true)
class TransformationDTO {
  const TransformationDTO({
    this.uid,
    this.label,
    this.type,
    this.configuration,
    this.editable,
  });

  factory TransformationDTO.fromJson(Map<String, dynamic> json) =>
      _$TransformationDTOFromJson(json);

  static const toJsonFactory = _$TransformationDTOToJson;
  Map<String, dynamic> toJson() => _$TransformationDTOToJson(this);

  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic>? configuration;
  @JsonKey(name: 'editable')
  final bool? editable;
  static const fromJsonFactory = _$TransformationDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TransformationDTO &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.configuration, configuration) ||
                const DeepCollectionEquality()
                    .equals(other.configuration, configuration)) &&
            (identical(other.editable, editable) ||
                const DeepCollectionEquality()
                    .equals(other.editable, editable)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(configuration) ^
      const DeepCollectionEquality().hash(editable) ^
      runtimeType.hashCode;
}

extension $TransformationDTOExtension on TransformationDTO {
  TransformationDTO copyWith(
      {String? uid,
      String? label,
      String? type,
      Map<String, dynamic>? configuration,
      bool? editable}) {
    return TransformationDTO(
        uid: uid ?? this.uid,
        label: label ?? this.label,
        type: type ?? this.type,
        configuration: configuration ?? this.configuration,
        editable: editable ?? this.editable);
  }

  TransformationDTO copyWithWrapped(
      {Wrapped<String?>? uid,
      Wrapped<String?>? label,
      Wrapped<String?>? type,
      Wrapped<Map<String, dynamic>?>? configuration,
      Wrapped<bool?>? editable}) {
    return TransformationDTO(
        uid: (uid != null ? uid.value : this.uid),
        label: (label != null ? label.value : this.label),
        type: (type != null ? type.value : this.type),
        configuration:
            (configuration != null ? configuration.value : this.configuration),
        editable: (editable != null ? editable.value : this.editable));
  }
}

@JsonSerializable(explicitToJson: true)
class RootUIComponent {
  const RootUIComponent({
    this.component,
    this.config,
    this.slots,
    this.uid,
    this.tags,
    this.props,
    this.timestamp,
    this.type,
  });

  factory RootUIComponent.fromJson(Map<String, dynamic> json) =>
      _$RootUIComponentFromJson(json);

  static const toJsonFactory = _$RootUIComponentToJson;
  Map<String, dynamic> toJson() => _$RootUIComponentToJson(this);

  @JsonKey(name: 'component')
  final String? component;
  @JsonKey(name: 'config')
  final Map<String, dynamic>? config;
  @JsonKey(name: 'slots')
  final Map<String, dynamic>? slots;
  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'props')
  final ConfigDescriptionDTO? props;
  @JsonKey(name: 'timestamp')
  final DateTime? timestamp;
  @JsonKey(name: 'type')
  final String? type;
  static const fromJsonFactory = _$RootUIComponentFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RootUIComponent &&
            (identical(other.component, component) ||
                const DeepCollectionEquality()
                    .equals(other.component, component)) &&
            (identical(other.config, config) ||
                const DeepCollectionEquality().equals(other.config, config)) &&
            (identical(other.slots, slots) ||
                const DeepCollectionEquality().equals(other.slots, slots)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.props, props) ||
                const DeepCollectionEquality().equals(other.props, props)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(component) ^
      const DeepCollectionEquality().hash(config) ^
      const DeepCollectionEquality().hash(slots) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(props) ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $RootUIComponentExtension on RootUIComponent {
  RootUIComponent copyWith(
      {String? component,
      Map<String, dynamic>? config,
      Map<String, dynamic>? slots,
      String? uid,
      List<String>? tags,
      ConfigDescriptionDTO? props,
      DateTime? timestamp,
      String? type}) {
    return RootUIComponent(
        component: component ?? this.component,
        config: config ?? this.config,
        slots: slots ?? this.slots,
        uid: uid ?? this.uid,
        tags: tags ?? this.tags,
        props: props ?? this.props,
        timestamp: timestamp ?? this.timestamp,
        type: type ?? this.type);
  }

  RootUIComponent copyWithWrapped(
      {Wrapped<String?>? component,
      Wrapped<Map<String, dynamic>?>? config,
      Wrapped<Map<String, dynamic>?>? slots,
      Wrapped<String?>? uid,
      Wrapped<List<String>?>? tags,
      Wrapped<ConfigDescriptionDTO?>? props,
      Wrapped<DateTime?>? timestamp,
      Wrapped<String?>? type}) {
    return RootUIComponent(
        component: (component != null ? component.value : this.component),
        config: (config != null ? config.value : this.config),
        slots: (slots != null ? slots.value : this.slots),
        uid: (uid != null ? uid.value : this.uid),
        tags: (tags != null ? tags.value : this.tags),
        props: (props != null ? props.value : this.props),
        timestamp: (timestamp != null ? timestamp.value : this.timestamp),
        type: (type != null ? type.value : this.type));
  }
}

@JsonSerializable(explicitToJson: true)
class UIComponent {
  const UIComponent({
    this.component,
    this.config,
    this.type,
  });

  factory UIComponent.fromJson(Map<String, dynamic> json) =>
      _$UIComponentFromJson(json);

  static const toJsonFactory = _$UIComponentToJson;
  Map<String, dynamic> toJson() => _$UIComponentToJson(this);

  @JsonKey(name: 'component')
  final String? component;
  @JsonKey(name: 'config')
  final Map<String, dynamic>? config;
  @JsonKey(name: 'type')
  final String? type;
  static const fromJsonFactory = _$UIComponentFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UIComponent &&
            (identical(other.component, component) ||
                const DeepCollectionEquality()
                    .equals(other.component, component)) &&
            (identical(other.config, config) ||
                const DeepCollectionEquality().equals(other.config, config)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(component) ^
      const DeepCollectionEquality().hash(config) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $UIComponentExtension on UIComponent {
  UIComponent copyWith(
      {String? component, Map<String, dynamic>? config, String? type}) {
    return UIComponent(
        component: component ?? this.component,
        config: config ?? this.config,
        type: type ?? this.type);
  }

  UIComponent copyWithWrapped(
      {Wrapped<String?>? component,
      Wrapped<Map<String, dynamic>?>? config,
      Wrapped<String?>? type}) {
    return UIComponent(
        component: (component != null ? component.value : this.component),
        config: (config != null ? config.value : this.config),
        type: (type != null ? type.value : this.type));
  }
}

@JsonSerializable(explicitToJson: true)
class TileDTO {
  const TileDTO({
    this.name,
    this.url,
    this.overlay,
    this.imageUrl,
  });

  factory TileDTO.fromJson(Map<String, dynamic> json) =>
      _$TileDTOFromJson(json);

  static const toJsonFactory = _$TileDTOToJson;
  Map<String, dynamic> toJson() => _$TileDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'overlay')
  final String? overlay;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  static const fromJsonFactory = _$TileDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TileDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.overlay, overlay) ||
                const DeepCollectionEquality()
                    .equals(other.overlay, overlay)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(overlay) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      runtimeType.hashCode;
}

extension $TileDTOExtension on TileDTO {
  TileDTO copyWith(
      {String? name, String? url, String? overlay, String? imageUrl}) {
    return TileDTO(
        name: name ?? this.name,
        url: url ?? this.url,
        overlay: overlay ?? this.overlay,
        imageUrl: imageUrl ?? this.imageUrl);
  }

  TileDTO copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? url,
      Wrapped<String?>? overlay,
      Wrapped<String?>? imageUrl}) {
    return TileDTO(
        name: (name != null ? name.value : this.name),
        url: (url != null ? url.value : this.url),
        overlay: (overlay != null ? overlay.value : this.overlay),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl));
  }
}

@JsonSerializable(explicitToJson: true)
class VoiceDTO {
  const VoiceDTO({
    this.id,
    this.label,
    this.locale,
  });

  factory VoiceDTO.fromJson(Map<String, dynamic> json) =>
      _$VoiceDTOFromJson(json);

  static const toJsonFactory = _$VoiceDTOToJson;
  Map<String, dynamic> toJson() => _$VoiceDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'locale')
  final String? locale;
  static const fromJsonFactory = _$VoiceDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VoiceDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.locale, locale) ||
                const DeepCollectionEquality().equals(other.locale, locale)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(locale) ^
      runtimeType.hashCode;
}

extension $VoiceDTOExtension on VoiceDTO {
  VoiceDTO copyWith({String? id, String? label, String? locale}) {
    return VoiceDTO(
        id: id ?? this.id,
        label: label ?? this.label,
        locale: locale ?? this.locale);
  }

  VoiceDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<String?>? locale}) {
    return VoiceDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        locale: (locale != null ? locale.value : this.locale));
  }
}

@JsonSerializable(explicitToJson: true)
class HumanLanguageInterpreterDTO {
  const HumanLanguageInterpreterDTO({
    this.id,
    this.label,
    this.locales,
  });

  factory HumanLanguageInterpreterDTO.fromJson(Map<String, dynamic> json) =>
      _$HumanLanguageInterpreterDTOFromJson(json);

  static const toJsonFactory = _$HumanLanguageInterpreterDTOToJson;
  Map<String, dynamic> toJson() => _$HumanLanguageInterpreterDTOToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'locales', defaultValue: <String>[])
  final List<String>? locales;
  static const fromJsonFactory = _$HumanLanguageInterpreterDTOFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HumanLanguageInterpreterDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.locales, locales) ||
                const DeepCollectionEquality().equals(other.locales, locales)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(locales) ^
      runtimeType.hashCode;
}

extension $HumanLanguageInterpreterDTOExtension on HumanLanguageInterpreterDTO {
  HumanLanguageInterpreterDTO copyWith(
      {String? id, String? label, List<String>? locales}) {
    return HumanLanguageInterpreterDTO(
        id: id ?? this.id,
        label: label ?? this.label,
        locales: locales ?? this.locales);
  }

  HumanLanguageInterpreterDTO copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<List<String>?>? locales}) {
    return HumanLanguageInterpreterDTO(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        locales: (locales != null ? locales.value : this.locales));
  }
}

@JsonSerializable(explicitToJson: true)
class LoggerInfo {
  const LoggerInfo({
    this.loggerName,
    this.level,
  });

  factory LoggerInfo.fromJson(Map<String, dynamic> json) =>
      _$LoggerInfoFromJson(json);

  static const toJsonFactory = _$LoggerInfoToJson;
  Map<String, dynamic> toJson() => _$LoggerInfoToJson(this);

  @JsonKey(name: 'loggerName')
  final String? loggerName;
  @JsonKey(name: 'level')
  final String? level;
  static const fromJsonFactory = _$LoggerInfoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoggerInfo &&
            (identical(other.loggerName, loggerName) ||
                const DeepCollectionEquality()
                    .equals(other.loggerName, loggerName)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(loggerName) ^
      const DeepCollectionEquality().hash(level) ^
      runtimeType.hashCode;
}

extension $LoggerInfoExtension on LoggerInfo {
  LoggerInfo copyWith({String? loggerName, String? level}) {
    return LoggerInfo(
        loggerName: loggerName ?? this.loggerName, level: level ?? this.level);
  }

  LoggerInfo copyWithWrapped(
      {Wrapped<String?>? loggerName, Wrapped<String?>? level}) {
    return LoggerInfo(
        loggerName: (loggerName != null ? loggerName.value : this.loggerName),
        level: (level != null ? level.value : this.level));
  }
}

@JsonSerializable(explicitToJson: true)
class LoggerBean {
  const LoggerBean({
    this.loggers,
  });

  factory LoggerBean.fromJson(Map<String, dynamic> json) =>
      _$LoggerBeanFromJson(json);

  static const toJsonFactory = _$LoggerBeanToJson;
  Map<String, dynamic> toJson() => _$LoggerBeanToJson(this);

  @JsonKey(name: 'loggers', defaultValue: <LoggerInfo>[])
  final List<LoggerInfo>? loggers;
  static const fromJsonFactory = _$LoggerBeanFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoggerBean &&
            (identical(other.loggers, loggers) ||
                const DeepCollectionEquality().equals(other.loggers, loggers)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(loggers) ^ runtimeType.hashCode;
}

extension $LoggerBeanExtension on LoggerBean {
  LoggerBean copyWith({List<LoggerInfo>? loggers}) {
    return LoggerBean(loggers: loggers ?? this.loggers);
  }

  LoggerBean copyWithWrapped({Wrapped<List<LoggerInfo>?>? loggers}) {
    return LoggerBean(
        loggers: (loggers != null ? loggers.value : this.loggers));
  }
}

@JsonSerializable(explicitToJson: true)
class IconSet {
  const IconSet({
    this.id,
    this.label,
    this.description,
    this.formats,
  });

  factory IconSet.fromJson(Map<String, dynamic> json) =>
      _$IconSetFromJson(json);

  static const toJsonFactory = _$IconSetToJson;
  Map<String, dynamic> toJson() => _$IconSetToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(
    name: 'formats',
    toJson: iconSetFormatsListToJson,
    fromJson: iconSetFormatsListFromJson,
  )
  final List<enums.IconSetFormats>? formats;
  static const fromJsonFactory = _$IconSetFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IconSet &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.formats, formats) ||
                const DeepCollectionEquality().equals(other.formats, formats)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(formats) ^
      runtimeType.hashCode;
}

extension $IconSetExtension on IconSet {
  IconSet copyWith(
      {String? id,
      String? label,
      String? description,
      List<enums.IconSetFormats>? formats}) {
    return IconSet(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        formats: formats ?? this.formats);
  }

  IconSet copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? label,
      Wrapped<String?>? description,
      Wrapped<List<enums.IconSetFormats>?>? formats}) {
    return IconSet(
        id: (id != null ? id.value : this.id),
        label: (label != null ? label.value : this.label),
        description:
            (description != null ? description.value : this.description),
        formats: (formats != null ? formats.value : this.formats));
  }
}

@JsonSerializable(explicitToJson: true)
class GalleryWidgetsListItem {
  const GalleryWidgetsListItem({
    this.id,
    this.title,
    this.description,
    this.likes,
    this.views,
    this.posts,
    this.imageUrl,
    this.createdDate,
  });

  factory GalleryWidgetsListItem.fromJson(Map<String, dynamic> json) =>
      _$GalleryWidgetsListItemFromJson(json);

  static const toJsonFactory = _$GalleryWidgetsListItemToJson;
  Map<String, dynamic> toJson() => _$GalleryWidgetsListItemToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'likes')
  final int? likes;
  @JsonKey(name: 'views')
  final int? views;
  @JsonKey(name: 'posts')
  final int? posts;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'createdDate')
  final DateTime? createdDate;
  static const fromJsonFactory = _$GalleryWidgetsListItemFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GalleryWidgetsListItem &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.likes, likes) ||
                const DeepCollectionEquality().equals(other.likes, likes)) &&
            (identical(other.views, views) ||
                const DeepCollectionEquality().equals(other.views, views)) &&
            (identical(other.posts, posts) ||
                const DeepCollectionEquality().equals(other.posts, posts)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.createdDate, createdDate) ||
                const DeepCollectionEquality()
                    .equals(other.createdDate, createdDate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(likes) ^
      const DeepCollectionEquality().hash(views) ^
      const DeepCollectionEquality().hash(posts) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(createdDate) ^
      runtimeType.hashCode;
}

extension $GalleryWidgetsListItemExtension on GalleryWidgetsListItem {
  GalleryWidgetsListItem copyWith(
      {String? id,
      String? title,
      String? description,
      int? likes,
      int? views,
      int? posts,
      String? imageUrl,
      DateTime? createdDate}) {
    return GalleryWidgetsListItem(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        likes: likes ?? this.likes,
        views: views ?? this.views,
        posts: posts ?? this.posts,
        imageUrl: imageUrl ?? this.imageUrl,
        createdDate: createdDate ?? this.createdDate);
  }

  GalleryWidgetsListItem copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<int?>? likes,
      Wrapped<int?>? views,
      Wrapped<int?>? posts,
      Wrapped<String?>? imageUrl,
      Wrapped<DateTime?>? createdDate}) {
    return GalleryWidgetsListItem(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        likes: (likes != null ? likes.value : this.likes),
        views: (views != null ? views.value : this.views),
        posts: (posts != null ? posts.value : this.posts),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        createdDate:
            (createdDate != null ? createdDate.value : this.createdDate));
  }
}

@JsonSerializable(explicitToJson: true)
class GalleryItem {
  const GalleryItem({
    this.id,
    this.title,
    this.description,
    this.likes,
    this.views,
    this.posts,
    this.imageUrl,
    this.author,
    this.authorName,
    this.authorAvatarUrl,
    this.createdDate,
    this.updatedDate,
    this.readme,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) =>
      _$GalleryItemFromJson(json);

  static const toJsonFactory = _$GalleryItemToJson;
  Map<String, dynamic> toJson() => _$GalleryItemToJson(this);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'likes')
  final int? likes;
  @JsonKey(name: 'views')
  final int? views;
  @JsonKey(name: 'posts')
  final int? posts;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'author')
  final String? author;
  @JsonKey(name: 'authorName')
  final String? authorName;
  @JsonKey(name: 'authorAvatarUrl')
  final String? authorAvatarUrl;
  @JsonKey(name: 'createdDate')
  final DateTime? createdDate;
  @JsonKey(name: 'updatedDate')
  final DateTime? updatedDate;
  @JsonKey(name: 'readme')
  final String? readme;
  static const fromJsonFactory = _$GalleryItemFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GalleryItem &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.likes, likes) ||
                const DeepCollectionEquality().equals(other.likes, likes)) &&
            (identical(other.views, views) ||
                const DeepCollectionEquality().equals(other.views, views)) &&
            (identical(other.posts, posts) ||
                const DeepCollectionEquality().equals(other.posts, posts)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.authorName, authorName) ||
                const DeepCollectionEquality()
                    .equals(other.authorName, authorName)) &&
            (identical(other.authorAvatarUrl, authorAvatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.authorAvatarUrl, authorAvatarUrl)) &&
            (identical(other.createdDate, createdDate) ||
                const DeepCollectionEquality()
                    .equals(other.createdDate, createdDate)) &&
            (identical(other.updatedDate, updatedDate) ||
                const DeepCollectionEquality()
                    .equals(other.updatedDate, updatedDate)) &&
            (identical(other.readme, readme) ||
                const DeepCollectionEquality().equals(other.readme, readme)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(likes) ^
      const DeepCollectionEquality().hash(views) ^
      const DeepCollectionEquality().hash(posts) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(authorName) ^
      const DeepCollectionEquality().hash(authorAvatarUrl) ^
      const DeepCollectionEquality().hash(createdDate) ^
      const DeepCollectionEquality().hash(updatedDate) ^
      const DeepCollectionEquality().hash(readme) ^
      runtimeType.hashCode;
}

extension $GalleryItemExtension on GalleryItem {
  GalleryItem copyWith(
      {String? id,
      String? title,
      String? description,
      int? likes,
      int? views,
      int? posts,
      String? imageUrl,
      String? author,
      String? authorName,
      String? authorAvatarUrl,
      DateTime? createdDate,
      DateTime? updatedDate,
      String? readme}) {
    return GalleryItem(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        likes: likes ?? this.likes,
        views: views ?? this.views,
        posts: posts ?? this.posts,
        imageUrl: imageUrl ?? this.imageUrl,
        author: author ?? this.author,
        authorName: authorName ?? this.authorName,
        authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
        readme: readme ?? this.readme);
  }

  GalleryItem copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<int?>? likes,
      Wrapped<int?>? views,
      Wrapped<int?>? posts,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? author,
      Wrapped<String?>? authorName,
      Wrapped<String?>? authorAvatarUrl,
      Wrapped<DateTime?>? createdDate,
      Wrapped<DateTime?>? updatedDate,
      Wrapped<String?>? readme}) {
    return GalleryItem(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        likes: (likes != null ? likes.value : this.likes),
        views: (views != null ? views.value : this.views),
        posts: (posts != null ? posts.value : this.posts),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        author: (author != null ? author.value : this.author),
        authorName: (authorName != null ? authorName.value : this.authorName),
        authorAvatarUrl: (authorAvatarUrl != null
            ? authorAvatarUrl.value
            : this.authorAvatarUrl),
        createdDate:
            (createdDate != null ? createdDate.value : this.createdDate),
        updatedDate:
            (updatedDate != null ? updatedDate.value : this.updatedDate),
        readme: (readme != null ? readme.value : this.readme));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthLogoutPost$RequestBody {
  const AuthLogoutPost$RequestBody({
    this.refreshToken,
    this.id,
  });

  factory AuthLogoutPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthLogoutPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$AuthLogoutPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$AuthLogoutPost$RequestBodyToJson(this);

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'id')
  final String? id;
  static const fromJsonFactory = _$AuthLogoutPost$RequestBodyFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AuthLogoutPost$RequestBody &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $AuthLogoutPost$RequestBodyExtension on AuthLogoutPost$RequestBody {
  AuthLogoutPost$RequestBody copyWith({String? refreshToken, String? id}) {
    return AuthLogoutPost$RequestBody(
        refreshToken: refreshToken ?? this.refreshToken, id: id ?? this.id);
  }

  AuthLogoutPost$RequestBody copyWithWrapped(
      {Wrapped<String?>? refreshToken, Wrapped<String?>? id}) {
    return AuthLogoutPost$RequestBody(
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthTokenPost$RequestBody {
  const AuthTokenPost$RequestBody({
    this.grantType,
    this.code,
    this.redirectUri,
    this.clientId,
    this.refreshToken,
    this.codeVerifier,
  });

  factory AuthTokenPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$AuthTokenPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$AuthTokenPost$RequestBodyToJson(this);

  @JsonKey(name: 'grant_type')
  final String? grantType;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'redirect_uri')
  final String? redirectUri;
  @JsonKey(name: 'client_id')
  final String? clientId;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'code_verifier')
  final String? codeVerifier;
  static const fromJsonFactory = _$AuthTokenPost$RequestBodyFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AuthTokenPost$RequestBody &&
            (identical(other.grantType, grantType) ||
                const DeepCollectionEquality()
                    .equals(other.grantType, grantType)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality()
                    .equals(other.redirectUri, redirectUri)) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.codeVerifier, codeVerifier) ||
                const DeepCollectionEquality()
                    .equals(other.codeVerifier, codeVerifier)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(grantType) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(redirectUri) ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(codeVerifier) ^
      runtimeType.hashCode;
}

extension $AuthTokenPost$RequestBodyExtension on AuthTokenPost$RequestBody {
  AuthTokenPost$RequestBody copyWith(
      {String? grantType,
      String? code,
      String? redirectUri,
      String? clientId,
      String? refreshToken,
      String? codeVerifier}) {
    return AuthTokenPost$RequestBody(
        grantType: grantType ?? this.grantType,
        code: code ?? this.code,
        redirectUri: redirectUri ?? this.redirectUri,
        clientId: clientId ?? this.clientId,
        refreshToken: refreshToken ?? this.refreshToken,
        codeVerifier: codeVerifier ?? this.codeVerifier);
  }

  AuthTokenPost$RequestBody copyWithWrapped(
      {Wrapped<String?>? grantType,
      Wrapped<String?>? code,
      Wrapped<String?>? redirectUri,
      Wrapped<String?>? clientId,
      Wrapped<String?>? refreshToken,
      Wrapped<String?>? codeVerifier}) {
    return AuthTokenPost$RequestBody(
        grantType: (grantType != null ? grantType.value : this.grantType),
        code: (code != null ? code.value : this.code),
        redirectUri:
            (redirectUri != null ? redirectUri.value : this.redirectUri),
        clientId: (clientId != null ? clientId.value : this.clientId),
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken),
        codeVerifier:
            (codeVerifier != null ? codeVerifier.value : this.codeVerifier));
  }
}

String? configDescriptionParameterDTOTypeNullableToJson(
    enums.ConfigDescriptionParameterDTOType?
        configDescriptionParameterDTOType) {
  return configDescriptionParameterDTOType?.value;
}

String? configDescriptionParameterDTOTypeToJson(
    enums.ConfigDescriptionParameterDTOType configDescriptionParameterDTOType) {
  return configDescriptionParameterDTOType.value;
}

enums.ConfigDescriptionParameterDTOType
    configDescriptionParameterDTOTypeFromJson(
  Object? configDescriptionParameterDTOType, [
  enums.ConfigDescriptionParameterDTOType? defaultValue,
]) {
  return enums.ConfigDescriptionParameterDTOType.values.firstWhereOrNull(
          (e) => e.value == configDescriptionParameterDTOType) ??
      defaultValue ??
      enums.ConfigDescriptionParameterDTOType.swaggerGeneratedUnknown;
}

enums.ConfigDescriptionParameterDTOType?
    configDescriptionParameterDTOTypeNullableFromJson(
  Object? configDescriptionParameterDTOType, [
  enums.ConfigDescriptionParameterDTOType? defaultValue,
]) {
  if (configDescriptionParameterDTOType == null) {
    return null;
  }
  return enums.ConfigDescriptionParameterDTOType.values.firstWhereOrNull(
          (e) => e.value == configDescriptionParameterDTOType) ??
      defaultValue;
}

String configDescriptionParameterDTOTypeExplodedListToJson(
    List<enums.ConfigDescriptionParameterDTOType>?
        configDescriptionParameterDTOType) {
  return configDescriptionParameterDTOType?.map((e) => e.value!).join(',') ??
      '';
}

List<String> configDescriptionParameterDTOTypeListToJson(
    List<enums.ConfigDescriptionParameterDTOType>?
        configDescriptionParameterDTOType) {
  if (configDescriptionParameterDTOType == null) {
    return [];
  }

  return configDescriptionParameterDTOType.map((e) => e.value!).toList();
}

List<enums.ConfigDescriptionParameterDTOType>
    configDescriptionParameterDTOTypeListFromJson(
  List? configDescriptionParameterDTOType, [
  List<enums.ConfigDescriptionParameterDTOType>? defaultValue,
]) {
  if (configDescriptionParameterDTOType == null) {
    return defaultValue ?? [];
  }

  return configDescriptionParameterDTOType
      .map((e) => configDescriptionParameterDTOTypeFromJson(e.toString()))
      .toList();
}

List<enums.ConfigDescriptionParameterDTOType>?
    configDescriptionParameterDTOTypeNullableListFromJson(
  List? configDescriptionParameterDTOType, [
  List<enums.ConfigDescriptionParameterDTOType>? defaultValue,
]) {
  if (configDescriptionParameterDTOType == null) {
    return defaultValue;
  }

  return configDescriptionParameterDTOType
      .map((e) => configDescriptionParameterDTOTypeFromJson(e.toString()))
      .toList();
}

String? moduleTypeDTOVisibilityNullableToJson(
    enums.ModuleTypeDTOVisibility? moduleTypeDTOVisibility) {
  return moduleTypeDTOVisibility?.value;
}

String? moduleTypeDTOVisibilityToJson(
    enums.ModuleTypeDTOVisibility moduleTypeDTOVisibility) {
  return moduleTypeDTOVisibility.value;
}

enums.ModuleTypeDTOVisibility moduleTypeDTOVisibilityFromJson(
  Object? moduleTypeDTOVisibility, [
  enums.ModuleTypeDTOVisibility? defaultValue,
]) {
  return enums.ModuleTypeDTOVisibility.values
          .firstWhereOrNull((e) => e.value == moduleTypeDTOVisibility) ??
      defaultValue ??
      enums.ModuleTypeDTOVisibility.swaggerGeneratedUnknown;
}

enums.ModuleTypeDTOVisibility? moduleTypeDTOVisibilityNullableFromJson(
  Object? moduleTypeDTOVisibility, [
  enums.ModuleTypeDTOVisibility? defaultValue,
]) {
  if (moduleTypeDTOVisibility == null) {
    return null;
  }
  return enums.ModuleTypeDTOVisibility.values
          .firstWhereOrNull((e) => e.value == moduleTypeDTOVisibility) ??
      defaultValue;
}

String moduleTypeDTOVisibilityExplodedListToJson(
    List<enums.ModuleTypeDTOVisibility>? moduleTypeDTOVisibility) {
  return moduleTypeDTOVisibility?.map((e) => e.value!).join(',') ?? '';
}

List<String> moduleTypeDTOVisibilityListToJson(
    List<enums.ModuleTypeDTOVisibility>? moduleTypeDTOVisibility) {
  if (moduleTypeDTOVisibility == null) {
    return [];
  }

  return moduleTypeDTOVisibility.map((e) => e.value!).toList();
}

List<enums.ModuleTypeDTOVisibility> moduleTypeDTOVisibilityListFromJson(
  List? moduleTypeDTOVisibility, [
  List<enums.ModuleTypeDTOVisibility>? defaultValue,
]) {
  if (moduleTypeDTOVisibility == null) {
    return defaultValue ?? [];
  }

  return moduleTypeDTOVisibility
      .map((e) => moduleTypeDTOVisibilityFromJson(e.toString()))
      .toList();
}

List<enums.ModuleTypeDTOVisibility>?
    moduleTypeDTOVisibilityNullableListFromJson(
  List? moduleTypeDTOVisibility, [
  List<enums.ModuleTypeDTOVisibility>? defaultValue,
]) {
  if (moduleTypeDTOVisibility == null) {
    return defaultValue;
  }

  return moduleTypeDTOVisibility
      .map((e) => moduleTypeDTOVisibilityFromJson(e.toString()))
      .toList();
}

String? ruleDTOVisibilityNullableToJson(
    enums.RuleDTOVisibility? ruleDTOVisibility) {
  return ruleDTOVisibility?.value;
}

String? ruleDTOVisibilityToJson(enums.RuleDTOVisibility ruleDTOVisibility) {
  return ruleDTOVisibility.value;
}

enums.RuleDTOVisibility ruleDTOVisibilityFromJson(
  Object? ruleDTOVisibility, [
  enums.RuleDTOVisibility? defaultValue,
]) {
  return enums.RuleDTOVisibility.values
          .firstWhereOrNull((e) => e.value == ruleDTOVisibility) ??
      defaultValue ??
      enums.RuleDTOVisibility.swaggerGeneratedUnknown;
}

enums.RuleDTOVisibility? ruleDTOVisibilityNullableFromJson(
  Object? ruleDTOVisibility, [
  enums.RuleDTOVisibility? defaultValue,
]) {
  if (ruleDTOVisibility == null) {
    return null;
  }
  return enums.RuleDTOVisibility.values
          .firstWhereOrNull((e) => e.value == ruleDTOVisibility) ??
      defaultValue;
}

String ruleDTOVisibilityExplodedListToJson(
    List<enums.RuleDTOVisibility>? ruleDTOVisibility) {
  return ruleDTOVisibility?.map((e) => e.value!).join(',') ?? '';
}

List<String> ruleDTOVisibilityListToJson(
    List<enums.RuleDTOVisibility>? ruleDTOVisibility) {
  if (ruleDTOVisibility == null) {
    return [];
  }

  return ruleDTOVisibility.map((e) => e.value!).toList();
}

List<enums.RuleDTOVisibility> ruleDTOVisibilityListFromJson(
  List? ruleDTOVisibility, [
  List<enums.RuleDTOVisibility>? defaultValue,
]) {
  if (ruleDTOVisibility == null) {
    return defaultValue ?? [];
  }

  return ruleDTOVisibility
      .map((e) => ruleDTOVisibilityFromJson(e.toString()))
      .toList();
}

List<enums.RuleDTOVisibility>? ruleDTOVisibilityNullableListFromJson(
  List? ruleDTOVisibility, [
  List<enums.RuleDTOVisibility>? defaultValue,
]) {
  if (ruleDTOVisibility == null) {
    return defaultValue;
  }

  return ruleDTOVisibility
      .map((e) => ruleDTOVisibilityFromJson(e.toString()))
      .toList();
}

String? enrichedRuleDTOVisibilityNullableToJson(
    enums.EnrichedRuleDTOVisibility? enrichedRuleDTOVisibility) {
  return enrichedRuleDTOVisibility?.value;
}

String? enrichedRuleDTOVisibilityToJson(
    enums.EnrichedRuleDTOVisibility enrichedRuleDTOVisibility) {
  return enrichedRuleDTOVisibility.value;
}

enums.EnrichedRuleDTOVisibility enrichedRuleDTOVisibilityFromJson(
  Object? enrichedRuleDTOVisibility, [
  enums.EnrichedRuleDTOVisibility? defaultValue,
]) {
  return enums.EnrichedRuleDTOVisibility.values
          .firstWhereOrNull((e) => e.value == enrichedRuleDTOVisibility) ??
      defaultValue ??
      enums.EnrichedRuleDTOVisibility.swaggerGeneratedUnknown;
}

enums.EnrichedRuleDTOVisibility? enrichedRuleDTOVisibilityNullableFromJson(
  Object? enrichedRuleDTOVisibility, [
  enums.EnrichedRuleDTOVisibility? defaultValue,
]) {
  if (enrichedRuleDTOVisibility == null) {
    return null;
  }
  return enums.EnrichedRuleDTOVisibility.values
          .firstWhereOrNull((e) => e.value == enrichedRuleDTOVisibility) ??
      defaultValue;
}

String enrichedRuleDTOVisibilityExplodedListToJson(
    List<enums.EnrichedRuleDTOVisibility>? enrichedRuleDTOVisibility) {
  return enrichedRuleDTOVisibility?.map((e) => e.value!).join(',') ?? '';
}

List<String> enrichedRuleDTOVisibilityListToJson(
    List<enums.EnrichedRuleDTOVisibility>? enrichedRuleDTOVisibility) {
  if (enrichedRuleDTOVisibility == null) {
    return [];
  }

  return enrichedRuleDTOVisibility.map((e) => e.value!).toList();
}

List<enums.EnrichedRuleDTOVisibility> enrichedRuleDTOVisibilityListFromJson(
  List? enrichedRuleDTOVisibility, [
  List<enums.EnrichedRuleDTOVisibility>? defaultValue,
]) {
  if (enrichedRuleDTOVisibility == null) {
    return defaultValue ?? [];
  }

  return enrichedRuleDTOVisibility
      .map((e) => enrichedRuleDTOVisibilityFromJson(e.toString()))
      .toList();
}

List<enums.EnrichedRuleDTOVisibility>?
    enrichedRuleDTOVisibilityNullableListFromJson(
  List? enrichedRuleDTOVisibility, [
  List<enums.EnrichedRuleDTOVisibility>? defaultValue,
]) {
  if (enrichedRuleDTOVisibility == null) {
    return defaultValue;
  }

  return enrichedRuleDTOVisibility
      .map((e) => enrichedRuleDTOVisibilityFromJson(e.toString()))
      .toList();
}

String? ruleStatusInfoStatusNullableToJson(
    enums.RuleStatusInfoStatus? ruleStatusInfoStatus) {
  return ruleStatusInfoStatus?.value;
}

String? ruleStatusInfoStatusToJson(
    enums.RuleStatusInfoStatus ruleStatusInfoStatus) {
  return ruleStatusInfoStatus.value;
}

enums.RuleStatusInfoStatus ruleStatusInfoStatusFromJson(
  Object? ruleStatusInfoStatus, [
  enums.RuleStatusInfoStatus? defaultValue,
]) {
  return enums.RuleStatusInfoStatus.values
          .firstWhereOrNull((e) => e.value == ruleStatusInfoStatus) ??
      defaultValue ??
      enums.RuleStatusInfoStatus.swaggerGeneratedUnknown;
}

enums.RuleStatusInfoStatus? ruleStatusInfoStatusNullableFromJson(
  Object? ruleStatusInfoStatus, [
  enums.RuleStatusInfoStatus? defaultValue,
]) {
  if (ruleStatusInfoStatus == null) {
    return null;
  }
  return enums.RuleStatusInfoStatus.values
          .firstWhereOrNull((e) => e.value == ruleStatusInfoStatus) ??
      defaultValue;
}

String ruleStatusInfoStatusExplodedListToJson(
    List<enums.RuleStatusInfoStatus>? ruleStatusInfoStatus) {
  return ruleStatusInfoStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> ruleStatusInfoStatusListToJson(
    List<enums.RuleStatusInfoStatus>? ruleStatusInfoStatus) {
  if (ruleStatusInfoStatus == null) {
    return [];
  }

  return ruleStatusInfoStatus.map((e) => e.value!).toList();
}

List<enums.RuleStatusInfoStatus> ruleStatusInfoStatusListFromJson(
  List? ruleStatusInfoStatus, [
  List<enums.RuleStatusInfoStatus>? defaultValue,
]) {
  if (ruleStatusInfoStatus == null) {
    return defaultValue ?? [];
  }

  return ruleStatusInfoStatus
      .map((e) => ruleStatusInfoStatusFromJson(e.toString()))
      .toList();
}

List<enums.RuleStatusInfoStatus>? ruleStatusInfoStatusNullableListFromJson(
  List? ruleStatusInfoStatus, [
  List<enums.RuleStatusInfoStatus>? defaultValue,
]) {
  if (ruleStatusInfoStatus == null) {
    return defaultValue;
  }

  return ruleStatusInfoStatus
      .map((e) => ruleStatusInfoStatusFromJson(e.toString()))
      .toList();
}

String? ruleStatusInfoStatusDetailNullableToJson(
    enums.RuleStatusInfoStatusDetail? ruleStatusInfoStatusDetail) {
  return ruleStatusInfoStatusDetail?.value;
}

String? ruleStatusInfoStatusDetailToJson(
    enums.RuleStatusInfoStatusDetail ruleStatusInfoStatusDetail) {
  return ruleStatusInfoStatusDetail.value;
}

enums.RuleStatusInfoStatusDetail ruleStatusInfoStatusDetailFromJson(
  Object? ruleStatusInfoStatusDetail, [
  enums.RuleStatusInfoStatusDetail? defaultValue,
]) {
  return enums.RuleStatusInfoStatusDetail.values
          .firstWhereOrNull((e) => e.value == ruleStatusInfoStatusDetail) ??
      defaultValue ??
      enums.RuleStatusInfoStatusDetail.swaggerGeneratedUnknown;
}

enums.RuleStatusInfoStatusDetail? ruleStatusInfoStatusDetailNullableFromJson(
  Object? ruleStatusInfoStatusDetail, [
  enums.RuleStatusInfoStatusDetail? defaultValue,
]) {
  if (ruleStatusInfoStatusDetail == null) {
    return null;
  }
  return enums.RuleStatusInfoStatusDetail.values
          .firstWhereOrNull((e) => e.value == ruleStatusInfoStatusDetail) ??
      defaultValue;
}

String ruleStatusInfoStatusDetailExplodedListToJson(
    List<enums.RuleStatusInfoStatusDetail>? ruleStatusInfoStatusDetail) {
  return ruleStatusInfoStatusDetail?.map((e) => e.value!).join(',') ?? '';
}

List<String> ruleStatusInfoStatusDetailListToJson(
    List<enums.RuleStatusInfoStatusDetail>? ruleStatusInfoStatusDetail) {
  if (ruleStatusInfoStatusDetail == null) {
    return [];
  }

  return ruleStatusInfoStatusDetail.map((e) => e.value!).toList();
}

List<enums.RuleStatusInfoStatusDetail> ruleStatusInfoStatusDetailListFromJson(
  List? ruleStatusInfoStatusDetail, [
  List<enums.RuleStatusInfoStatusDetail>? defaultValue,
]) {
  if (ruleStatusInfoStatusDetail == null) {
    return defaultValue ?? [];
  }

  return ruleStatusInfoStatusDetail
      .map((e) => ruleStatusInfoStatusDetailFromJson(e.toString()))
      .toList();
}

List<enums.RuleStatusInfoStatusDetail>?
    ruleStatusInfoStatusDetailNullableListFromJson(
  List? ruleStatusInfoStatusDetail, [
  List<enums.RuleStatusInfoStatusDetail>? defaultValue,
]) {
  if (ruleStatusInfoStatusDetail == null) {
    return defaultValue;
  }

  return ruleStatusInfoStatusDetail
      .map((e) => ruleStatusInfoStatusDetailFromJson(e.toString()))
      .toList();
}

String? configDescriptionParameterTypeNullableToJson(
    enums.ConfigDescriptionParameterType? configDescriptionParameterType) {
  return configDescriptionParameterType?.value;
}

String? configDescriptionParameterTypeToJson(
    enums.ConfigDescriptionParameterType configDescriptionParameterType) {
  return configDescriptionParameterType.value;
}

enums.ConfigDescriptionParameterType configDescriptionParameterTypeFromJson(
  Object? configDescriptionParameterType, [
  enums.ConfigDescriptionParameterType? defaultValue,
]) {
  return enums.ConfigDescriptionParameterType.values
          .firstWhereOrNull((e) => e.value == configDescriptionParameterType) ??
      defaultValue ??
      enums.ConfigDescriptionParameterType.swaggerGeneratedUnknown;
}

enums.ConfigDescriptionParameterType?
    configDescriptionParameterTypeNullableFromJson(
  Object? configDescriptionParameterType, [
  enums.ConfigDescriptionParameterType? defaultValue,
]) {
  if (configDescriptionParameterType == null) {
    return null;
  }
  return enums.ConfigDescriptionParameterType.values
          .firstWhereOrNull((e) => e.value == configDescriptionParameterType) ??
      defaultValue;
}

String configDescriptionParameterTypeExplodedListToJson(
    List<enums.ConfigDescriptionParameterType>?
        configDescriptionParameterType) {
  return configDescriptionParameterType?.map((e) => e.value!).join(',') ?? '';
}

List<String> configDescriptionParameterTypeListToJson(
    List<enums.ConfigDescriptionParameterType>?
        configDescriptionParameterType) {
  if (configDescriptionParameterType == null) {
    return [];
  }

  return configDescriptionParameterType.map((e) => e.value!).toList();
}

List<enums.ConfigDescriptionParameterType>
    configDescriptionParameterTypeListFromJson(
  List? configDescriptionParameterType, [
  List<enums.ConfigDescriptionParameterType>? defaultValue,
]) {
  if (configDescriptionParameterType == null) {
    return defaultValue ?? [];
  }

  return configDescriptionParameterType
      .map((e) => configDescriptionParameterTypeFromJson(e.toString()))
      .toList();
}

List<enums.ConfigDescriptionParameterType>?
    configDescriptionParameterTypeNullableListFromJson(
  List? configDescriptionParameterType, [
  List<enums.ConfigDescriptionParameterType>? defaultValue,
]) {
  if (configDescriptionParameterType == null) {
    return defaultValue;
  }

  return configDescriptionParameterType
      .map((e) => configDescriptionParameterTypeFromJson(e.toString()))
      .toList();
}

String? ruleVisibilityNullableToJson(enums.RuleVisibility? ruleVisibility) {
  return ruleVisibility?.value;
}

String? ruleVisibilityToJson(enums.RuleVisibility ruleVisibility) {
  return ruleVisibility.value;
}

enums.RuleVisibility ruleVisibilityFromJson(
  Object? ruleVisibility, [
  enums.RuleVisibility? defaultValue,
]) {
  return enums.RuleVisibility.values
          .firstWhereOrNull((e) => e.value == ruleVisibility) ??
      defaultValue ??
      enums.RuleVisibility.swaggerGeneratedUnknown;
}

enums.RuleVisibility? ruleVisibilityNullableFromJson(
  Object? ruleVisibility, [
  enums.RuleVisibility? defaultValue,
]) {
  if (ruleVisibility == null) {
    return null;
  }
  return enums.RuleVisibility.values
          .firstWhereOrNull((e) => e.value == ruleVisibility) ??
      defaultValue;
}

String ruleVisibilityExplodedListToJson(
    List<enums.RuleVisibility>? ruleVisibility) {
  return ruleVisibility?.map((e) => e.value!).join(',') ?? '';
}

List<String> ruleVisibilityListToJson(
    List<enums.RuleVisibility>? ruleVisibility) {
  if (ruleVisibility == null) {
    return [];
  }

  return ruleVisibility.map((e) => e.value!).toList();
}

List<enums.RuleVisibility> ruleVisibilityListFromJson(
  List? ruleVisibility, [
  List<enums.RuleVisibility>? defaultValue,
]) {
  if (ruleVisibility == null) {
    return defaultValue ?? [];
  }

  return ruleVisibility
      .map((e) => ruleVisibilityFromJson(e.toString()))
      .toList();
}

List<enums.RuleVisibility>? ruleVisibilityNullableListFromJson(
  List? ruleVisibility, [
  List<enums.RuleVisibility>? defaultValue,
]) {
  if (ruleVisibility == null) {
    return defaultValue;
  }

  return ruleVisibility
      .map((e) => ruleVisibilityFromJson(e.toString()))
      .toList();
}

String? templateVisibilityNullableToJson(
    enums.TemplateVisibility? templateVisibility) {
  return templateVisibility?.value;
}

String? templateVisibilityToJson(enums.TemplateVisibility templateVisibility) {
  return templateVisibility.value;
}

enums.TemplateVisibility templateVisibilityFromJson(
  Object? templateVisibility, [
  enums.TemplateVisibility? defaultValue,
]) {
  return enums.TemplateVisibility.values
          .firstWhereOrNull((e) => e.value == templateVisibility) ??
      defaultValue ??
      enums.TemplateVisibility.swaggerGeneratedUnknown;
}

enums.TemplateVisibility? templateVisibilityNullableFromJson(
  Object? templateVisibility, [
  enums.TemplateVisibility? defaultValue,
]) {
  if (templateVisibility == null) {
    return null;
  }
  return enums.TemplateVisibility.values
          .firstWhereOrNull((e) => e.value == templateVisibility) ??
      defaultValue;
}

String templateVisibilityExplodedListToJson(
    List<enums.TemplateVisibility>? templateVisibility) {
  return templateVisibility?.map((e) => e.value!).join(',') ?? '';
}

List<String> templateVisibilityListToJson(
    List<enums.TemplateVisibility>? templateVisibility) {
  if (templateVisibility == null) {
    return [];
  }

  return templateVisibility.map((e) => e.value!).toList();
}

List<enums.TemplateVisibility> templateVisibilityListFromJson(
  List? templateVisibility, [
  List<enums.TemplateVisibility>? defaultValue,
]) {
  if (templateVisibility == null) {
    return defaultValue ?? [];
  }

  return templateVisibility
      .map((e) => templateVisibilityFromJson(e.toString()))
      .toList();
}

List<enums.TemplateVisibility>? templateVisibilityNullableListFromJson(
  List? templateVisibility, [
  List<enums.TemplateVisibility>? defaultValue,
]) {
  if (templateVisibility == null) {
    return defaultValue;
  }

  return templateVisibility
      .map((e) => templateVisibilityFromJson(e.toString()))
      .toList();
}

String? discoveryResultDTOFlagNullableToJson(
    enums.DiscoveryResultDTOFlag? discoveryResultDTOFlag) {
  return discoveryResultDTOFlag?.value;
}

String? discoveryResultDTOFlagToJson(
    enums.DiscoveryResultDTOFlag discoveryResultDTOFlag) {
  return discoveryResultDTOFlag.value;
}

enums.DiscoveryResultDTOFlag discoveryResultDTOFlagFromJson(
  Object? discoveryResultDTOFlag, [
  enums.DiscoveryResultDTOFlag? defaultValue,
]) {
  return enums.DiscoveryResultDTOFlag.values
          .firstWhereOrNull((e) => e.value == discoveryResultDTOFlag) ??
      defaultValue ??
      enums.DiscoveryResultDTOFlag.swaggerGeneratedUnknown;
}

enums.DiscoveryResultDTOFlag? discoveryResultDTOFlagNullableFromJson(
  Object? discoveryResultDTOFlag, [
  enums.DiscoveryResultDTOFlag? defaultValue,
]) {
  if (discoveryResultDTOFlag == null) {
    return null;
  }
  return enums.DiscoveryResultDTOFlag.values
          .firstWhereOrNull((e) => e.value == discoveryResultDTOFlag) ??
      defaultValue;
}

String discoveryResultDTOFlagExplodedListToJson(
    List<enums.DiscoveryResultDTOFlag>? discoveryResultDTOFlag) {
  return discoveryResultDTOFlag?.map((e) => e.value!).join(',') ?? '';
}

List<String> discoveryResultDTOFlagListToJson(
    List<enums.DiscoveryResultDTOFlag>? discoveryResultDTOFlag) {
  if (discoveryResultDTOFlag == null) {
    return [];
  }

  return discoveryResultDTOFlag.map((e) => e.value!).toList();
}

List<enums.DiscoveryResultDTOFlag> discoveryResultDTOFlagListFromJson(
  List? discoveryResultDTOFlag, [
  List<enums.DiscoveryResultDTOFlag>? defaultValue,
]) {
  if (discoveryResultDTOFlag == null) {
    return defaultValue ?? [];
  }

  return discoveryResultDTOFlag
      .map((e) => discoveryResultDTOFlagFromJson(e.toString()))
      .toList();
}

List<enums.DiscoveryResultDTOFlag>? discoveryResultDTOFlagNullableListFromJson(
  List? discoveryResultDTOFlag, [
  List<enums.DiscoveryResultDTOFlag>? defaultValue,
]) {
  if (discoveryResultDTOFlag == null) {
    return defaultValue;
  }

  return discoveryResultDTOFlag
      .map((e) => discoveryResultDTOFlagFromJson(e.toString()))
      .toList();
}

String? thingStatusInfoStatusNullableToJson(
    enums.ThingStatusInfoStatus? thingStatusInfoStatus) {
  return thingStatusInfoStatus?.value;
}

String? thingStatusInfoStatusToJson(
    enums.ThingStatusInfoStatus thingStatusInfoStatus) {
  return thingStatusInfoStatus.value;
}

enums.ThingStatusInfoStatus thingStatusInfoStatusFromJson(
  Object? thingStatusInfoStatus, [
  enums.ThingStatusInfoStatus? defaultValue,
]) {
  return enums.ThingStatusInfoStatus.values
          .firstWhereOrNull((e) => e.value == thingStatusInfoStatus) ??
      defaultValue ??
      enums.ThingStatusInfoStatus.swaggerGeneratedUnknown;
}

enums.ThingStatusInfoStatus? thingStatusInfoStatusNullableFromJson(
  Object? thingStatusInfoStatus, [
  enums.ThingStatusInfoStatus? defaultValue,
]) {
  if (thingStatusInfoStatus == null) {
    return null;
  }
  return enums.ThingStatusInfoStatus.values
          .firstWhereOrNull((e) => e.value == thingStatusInfoStatus) ??
      defaultValue;
}

String thingStatusInfoStatusExplodedListToJson(
    List<enums.ThingStatusInfoStatus>? thingStatusInfoStatus) {
  return thingStatusInfoStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> thingStatusInfoStatusListToJson(
    List<enums.ThingStatusInfoStatus>? thingStatusInfoStatus) {
  if (thingStatusInfoStatus == null) {
    return [];
  }

  return thingStatusInfoStatus.map((e) => e.value!).toList();
}

List<enums.ThingStatusInfoStatus> thingStatusInfoStatusListFromJson(
  List? thingStatusInfoStatus, [
  List<enums.ThingStatusInfoStatus>? defaultValue,
]) {
  if (thingStatusInfoStatus == null) {
    return defaultValue ?? [];
  }

  return thingStatusInfoStatus
      .map((e) => thingStatusInfoStatusFromJson(e.toString()))
      .toList();
}

List<enums.ThingStatusInfoStatus>? thingStatusInfoStatusNullableListFromJson(
  List? thingStatusInfoStatus, [
  List<enums.ThingStatusInfoStatus>? defaultValue,
]) {
  if (thingStatusInfoStatus == null) {
    return defaultValue;
  }

  return thingStatusInfoStatus
      .map((e) => thingStatusInfoStatusFromJson(e.toString()))
      .toList();
}

String? thingStatusInfoStatusDetailNullableToJson(
    enums.ThingStatusInfoStatusDetail? thingStatusInfoStatusDetail) {
  return thingStatusInfoStatusDetail?.value;
}

String? thingStatusInfoStatusDetailToJson(
    enums.ThingStatusInfoStatusDetail thingStatusInfoStatusDetail) {
  return thingStatusInfoStatusDetail.value;
}

enums.ThingStatusInfoStatusDetail thingStatusInfoStatusDetailFromJson(
  Object? thingStatusInfoStatusDetail, [
  enums.ThingStatusInfoStatusDetail? defaultValue,
]) {
  return enums.ThingStatusInfoStatusDetail.values
          .firstWhereOrNull((e) => e.value == thingStatusInfoStatusDetail) ??
      defaultValue ??
      enums.ThingStatusInfoStatusDetail.swaggerGeneratedUnknown;
}

enums.ThingStatusInfoStatusDetail? thingStatusInfoStatusDetailNullableFromJson(
  Object? thingStatusInfoStatusDetail, [
  enums.ThingStatusInfoStatusDetail? defaultValue,
]) {
  if (thingStatusInfoStatusDetail == null) {
    return null;
  }
  return enums.ThingStatusInfoStatusDetail.values
          .firstWhereOrNull((e) => e.value == thingStatusInfoStatusDetail) ??
      defaultValue;
}

String thingStatusInfoStatusDetailExplodedListToJson(
    List<enums.ThingStatusInfoStatusDetail>? thingStatusInfoStatusDetail) {
  return thingStatusInfoStatusDetail?.map((e) => e.value!).join(',') ?? '';
}

List<String> thingStatusInfoStatusDetailListToJson(
    List<enums.ThingStatusInfoStatusDetail>? thingStatusInfoStatusDetail) {
  if (thingStatusInfoStatusDetail == null) {
    return [];
  }

  return thingStatusInfoStatusDetail.map((e) => e.value!).toList();
}

List<enums.ThingStatusInfoStatusDetail> thingStatusInfoStatusDetailListFromJson(
  List? thingStatusInfoStatusDetail, [
  List<enums.ThingStatusInfoStatusDetail>? defaultValue,
]) {
  if (thingStatusInfoStatusDetail == null) {
    return defaultValue ?? [];
  }

  return thingStatusInfoStatusDetail
      .map((e) => thingStatusInfoStatusDetailFromJson(e.toString()))
      .toList();
}

List<enums.ThingStatusInfoStatusDetail>?
    thingStatusInfoStatusDetailNullableListFromJson(
  List? thingStatusInfoStatusDetail, [
  List<enums.ThingStatusInfoStatusDetail>? defaultValue,
]) {
  if (thingStatusInfoStatusDetail == null) {
    return defaultValue;
  }

  return thingStatusInfoStatusDetail
      .map((e) => thingStatusInfoStatusDetailFromJson(e.toString()))
      .toList();
}

String? configStatusMessageTypeNullableToJson(
    enums.ConfigStatusMessageType? configStatusMessageType) {
  return configStatusMessageType?.value;
}

String? configStatusMessageTypeToJson(
    enums.ConfigStatusMessageType configStatusMessageType) {
  return configStatusMessageType.value;
}

enums.ConfigStatusMessageType configStatusMessageTypeFromJson(
  Object? configStatusMessageType, [
  enums.ConfigStatusMessageType? defaultValue,
]) {
  return enums.ConfigStatusMessageType.values
          .firstWhereOrNull((e) => e.value == configStatusMessageType) ??
      defaultValue ??
      enums.ConfigStatusMessageType.swaggerGeneratedUnknown;
}

enums.ConfigStatusMessageType? configStatusMessageTypeNullableFromJson(
  Object? configStatusMessageType, [
  enums.ConfigStatusMessageType? defaultValue,
]) {
  if (configStatusMessageType == null) {
    return null;
  }
  return enums.ConfigStatusMessageType.values
          .firstWhereOrNull((e) => e.value == configStatusMessageType) ??
      defaultValue;
}

String configStatusMessageTypeExplodedListToJson(
    List<enums.ConfigStatusMessageType>? configStatusMessageType) {
  return configStatusMessageType?.map((e) => e.value!).join(',') ?? '';
}

List<String> configStatusMessageTypeListToJson(
    List<enums.ConfigStatusMessageType>? configStatusMessageType) {
  if (configStatusMessageType == null) {
    return [];
  }

  return configStatusMessageType.map((e) => e.value!).toList();
}

List<enums.ConfigStatusMessageType> configStatusMessageTypeListFromJson(
  List? configStatusMessageType, [
  List<enums.ConfigStatusMessageType>? defaultValue,
]) {
  if (configStatusMessageType == null) {
    return defaultValue ?? [];
  }

  return configStatusMessageType
      .map((e) => configStatusMessageTypeFromJson(e.toString()))
      .toList();
}

List<enums.ConfigStatusMessageType>?
    configStatusMessageTypeNullableListFromJson(
  List? configStatusMessageType, [
  List<enums.ConfigStatusMessageType>? defaultValue,
]) {
  if (configStatusMessageType == null) {
    return defaultValue;
  }

  return configStatusMessageType
      .map((e) => configStatusMessageTypeFromJson(e.toString()))
      .toList();
}

String? iconSetFormatsNullableToJson(enums.IconSetFormats? iconSetFormats) {
  return iconSetFormats?.value;
}

String? iconSetFormatsToJson(enums.IconSetFormats iconSetFormats) {
  return iconSetFormats.value;
}

enums.IconSetFormats iconSetFormatsFromJson(
  Object? iconSetFormats, [
  enums.IconSetFormats? defaultValue,
]) {
  return enums.IconSetFormats.values
          .firstWhereOrNull((e) => e.value == iconSetFormats) ??
      defaultValue ??
      enums.IconSetFormats.swaggerGeneratedUnknown;
}

enums.IconSetFormats? iconSetFormatsNullableFromJson(
  Object? iconSetFormats, [
  enums.IconSetFormats? defaultValue,
]) {
  if (iconSetFormats == null) {
    return null;
  }
  return enums.IconSetFormats.values
          .firstWhereOrNull((e) => e.value == iconSetFormats) ??
      defaultValue;
}

String iconSetFormatsExplodedListToJson(
    List<enums.IconSetFormats>? iconSetFormats) {
  return iconSetFormats?.map((e) => e.value!).join(',') ?? '';
}

List<String> iconSetFormatsListToJson(
    List<enums.IconSetFormats>? iconSetFormats) {
  if (iconSetFormats == null) {
    return [];
  }

  return iconSetFormats.map((e) => e.value!).toList();
}

List<enums.IconSetFormats> iconSetFormatsListFromJson(
  List? iconSetFormats, [
  List<enums.IconSetFormats>? defaultValue,
]) {
  if (iconSetFormats == null) {
    return defaultValue ?? [];
  }

  return iconSetFormats
      .map((e) => iconSetFormatsFromJson(e.toString()))
      .toList();
}

List<enums.IconSetFormats>? iconSetFormatsNullableListFromJson(
  List? iconSetFormats, [
  List<enums.IconSetFormats>? defaultValue,
]) {
  if (iconSetFormats == null) {
    return defaultValue;
  }

  return iconSetFormats
      .map((e) => iconSetFormatsFromJson(e.toString()))
      .toList();
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
