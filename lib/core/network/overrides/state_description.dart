

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_description.g.dart';

@JsonSerializable(explicitToJson: true)
class StateDescription extends HiveObject {
  StateDescription({
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
  bool operator ==(Object other) {
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
}

@JsonSerializable(explicitToJson: true)
class StateOption extends HiveObject {
  StateOption({
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
  bool operator ==(Object other) {
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
}