import 'package:json_annotation/json_annotation.dart';

part 'clock_data.g.dart';

@JsonSerializable()
class ClockData {
  final String itemName;
  final String format;

  const ClockData({
    required this.itemName,
    required this.format,
  });

  factory ClockData.fromJson(Map<String, dynamic> json) => _$ClockDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClockDataToJson(this);

}