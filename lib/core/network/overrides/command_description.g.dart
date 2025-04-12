// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
