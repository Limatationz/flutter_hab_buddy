// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      LocalLoginData.fromJson(json['localLoginData'] as Map<String, dynamic>),
      cloudLoginData: json['cloudLoginData'] == null
          ? null
          : CloudLoginData.fromJson(
              json['cloudLoginData'] as Map<String, dynamic>),
      remoteLoginData: json['remoteLoginData'] == null
          ? null
          : RemoteLoginData.fromJson(
              json['remoteLoginData'] as Map<String, dynamic>),
      apiLoginData: json['apiLoginData'] == null
          ? null
          : ApiLoginData.fromJson(json['apiLoginData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'localLoginData': instance.localLoginData,
      'cloudLoginData': instance.cloudLoginData,
      'remoteLoginData': instance.remoteLoginData,
      'apiLoginData': instance.apiLoginData,
    };

LocalLoginData _$LocalLoginDataFromJson(Map<String, dynamic> json) =>
    LocalLoginData(
      json['host'] as String,
      json['port'] as String,
    );

Map<String, dynamic> _$LocalLoginDataToJson(LocalLoginData instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
    };

CloudLoginData _$CloudLoginDataFromJson(Map<String, dynamic> json) =>
    CloudLoginData(
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$CloudLoginDataToJson(CloudLoginData instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

RemoteLoginData _$RemoteLoginDataFromJson(Map<String, dynamic> json) =>
    RemoteLoginData(
      json['url'] as String,
      port: json['port'] as String?,
    );

Map<String, dynamic> _$RemoteLoginDataToJson(RemoteLoginData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'port': instance.port,
    };

ApiLoginData _$ApiLoginDataFromJson(Map<String, dynamic> json) => ApiLoginData(
      json['apiToken'] as String,
    );

Map<String, dynamic> _$ApiLoginDataToJson(ApiLoginData instance) =>
    <String, dynamic>{
      'apiToken': instance.apiToken,
    };
