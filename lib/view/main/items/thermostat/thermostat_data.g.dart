// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thermostat_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThermostatData _$ThermostatDataFromJson(Map<String, dynamic> json) =>
    ThermostatData(
      heatingSetpointItemName: json['heatingSetpointItemName'] as String,
      currentTemperatureItemName: json['currentTemperatureItemName'] as String,
      modeItemName: json['modeItemName'] as String?,
      currentHumidityItemName: json['currentHumidityItemName'] as String?,
    );

Map<String, dynamic> _$ThermostatDataToJson(ThermostatData instance) =>
    <String, dynamic>{
      'heatingSetpointItemName': instance.heatingSetpointItemName,
      'modeItemName': instance.modeItemName,
      'currentTemperatureItemName': instance.currentTemperatureItemName,
      'currentHumidityItemName': instance.currentHumidityItemName,
    };
