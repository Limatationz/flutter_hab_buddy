// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_view_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteViewSettings _$FavouriteViewSettingsFromJson(
        Map<String, dynamic> json) =>
    FavouriteViewSettings(
      $enumDecode(_$FavouriteViewTypeEnumMap, json['viewType']),
      (json['manualRoomsSortOrder'] as List<dynamic>)
          .map((e) =>
              FavouriteViewManualSortOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavouriteViewSettingsToJson(
        FavouriteViewSettings instance) =>
    <String, dynamic>{
      'viewType': _$FavouriteViewTypeEnumMap[instance.viewType]!,
      'manualRoomsSortOrder': instance.manualRoomsSortOrder,
    };

const _$FavouriteViewTypeEnumMap = {
  FavouriteViewType.auto: 'auto',
  FavouriteViewType.manual: 'manual',
};

FavouriteViewManualSortOrder _$FavouriteViewManualSortOrderFromJson(
        Map<String, dynamic> json) =>
    FavouriteViewManualSortOrder(
      (json['roomId'] as num).toInt(),
      (json['sensorNames'] as List<dynamic>).map((e) => e as String).toList(),
      (json['itemNames'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FavouriteViewManualSortOrderToJson(
        FavouriteViewManualSortOrder instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'sensorNames': instance.sensorNames,
      'itemNames': instance.itemNames,
    };
