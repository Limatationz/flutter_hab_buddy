import 'package:json_annotation/json_annotation.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  final String itemName;
  final WeatherLocationData location;
  final WeatherRequestType type;

  WeatherData({
    required this.itemName,
    required this.location,
    required this.type,});

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}

@JsonSerializable()
class WeatherLocationData {
  final String? city;
  final double? lat;
  final double? lon;

  String get locationString => city ?? "$lat,$lon";

  WeatherLocationData({this.city, this.lat, this.lon})
      : assert(city != null || (lat != null && lon != null));

  factory WeatherLocationData.fromJson(Map<String, dynamic> json) =>
      _$WeatherLocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherLocationDataToJson(this);
}

enum WeatherRequestType {
  current,
  forecast,
  both;
}