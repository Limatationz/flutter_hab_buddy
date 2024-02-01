// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      itemName: json['itemName'] as String,
      location: WeatherLocationData.fromJson(
          json['location'] as Map<String, dynamic>),
      type: $enumDecode(_$WeatherRequestTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'location': instance.location,
      'type': _$WeatherRequestTypeEnumMap[instance.type]!,
    };

const _$WeatherRequestTypeEnumMap = {
  WeatherRequestType.current: 'current',
  WeatherRequestType.forecast: 'forecast',
  WeatherRequestType.both: 'both',
};

WeatherLocationData _$WeatherLocationDataFromJson(Map<String, dynamic> json) =>
    WeatherLocationData(
      city: json['city'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherLocationDataToJson(
        WeatherLocationData instance) =>
    <String, dynamic>{
      'city': instance.city,
      'lat': instance.lat,
      'lon': instance.lon,
    };
