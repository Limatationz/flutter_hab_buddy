import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'command_description.g.dart';

@JsonSerializable(explicitToJson: true)
class CommandDescription extends HiveObject {
  CommandDescription({this.commandOptions});

  factory CommandDescription.fromJson(Map<String, dynamic> json) =>
      _$CommandDescriptionFromJson(json);

  static const toJsonFactory = _$CommandDescriptionToJson;

  Map<String, dynamic> toJson() => _$CommandDescriptionToJson(this);

  @JsonKey(name: 'commandOptions', defaultValue: <CommandOption>[])
  final List<CommandOption>? commandOptions;
  static const fromJsonFactory = _$CommandDescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CommandDescription &&
            (identical(other.commandOptions, commandOptions) ||
                const DeepCollectionEquality().equals(
                  other.commandOptions,
                  commandOptions,
                )));
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
      commandOptions: commandOptions ?? this.commandOptions,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CommandOption extends HiveObject {
  CommandOption({this.command, this.label});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CommandOption &&
            (identical(other.command, command) ||
                const DeepCollectionEquality().equals(
                  other.command,
                  command,
                )) &&
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
      command: command ?? this.command,
      label: label ?? this.label,
    );
  }
}
