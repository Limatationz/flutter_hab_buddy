import 'package:json_annotation/json_annotation.dart';

part 'thermostat_data.g.dart';

@JsonSerializable()
class ThermostatData {
  final String heatingSetpointItemName;
  final String? modeItemName;
  final String currentTemperatureItemName;
  final String? currentHumidityItemName;

  const ThermostatData({
    required this.heatingSetpointItemName,
    required this.currentTemperatureItemName,
    this.modeItemName,
    this.currentHumidityItemName,
  });

  factory ThermostatData.fromJson(Map<String, dynamic> json) => _$ThermostatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ThermostatDataToJson(this);
}

enum ThermostatMode {
  @JsonValue('AUTO')
  auto,
  @JsonValue('MANUAL')
  manual,
  @JsonValue('OFF')
  off,
  @JsonValue('UNKNOWN')
  unknown,
}