// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      $value: json['value'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$StateOptionToJson(StateOption instance) =>
    <String, dynamic>{
      'value': instance.$value,
      'label': instance.label,
    };
