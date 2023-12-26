// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complex_player_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplexPlayerData _$ComplexPlayerDataFromJson(Map<String, dynamic> json) =>
    ComplexPlayerData(
      playerItemName: json['playerItemName'] as String,
      totalDurationItemName: json['totalDurationItemName'] as String,
      currentDurationItemName: json['currentDurationItemName'] as String,
      volumeDimmerItemName: json['volumeDimmerItemName'] as String?,
      imageItemName: json['imageItemName'] as String?,
    );

Map<String, dynamic> _$ComplexPlayerDataToJson(ComplexPlayerData instance) =>
    <String, dynamic>{
      'playerItemName': instance.playerItemName,
      'totalDurationItemName': instance.totalDurationItemName,
      'currentDurationItemName': instance.currentDurationItemName,
      'volumeDimmerItemName': instance.volumeDimmerItemName,
      'imageItemName': instance.imageItemName,
    };
