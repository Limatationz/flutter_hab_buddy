import 'package:json_annotation/json_annotation.dart';

part 'login_data.g.dart';

// General Login Data
@JsonSerializable()
class LoginData extends JsonSerializable {
  final LocalLoginData localLoginData;
  final CloudLoginData? cloudLoginData;
  final RemoteLoginData? remoteLoginData;
  final ApiLoginData? apiLoginData;

  LoginData(this.localLoginData,
      {this.cloudLoginData, this.remoteLoginData, this.apiLoginData});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);

  // copyWith
  LoginData copyWith({
    LocalLoginData? localLoginData,
    CloudLoginData? cloudLoginData,
    RemoteLoginData? remoteLoginData,
    ApiLoginData? apiLoginData,
  }) {
    return LoginData(
      localLoginData ?? this.localLoginData,
      cloudLoginData: cloudLoginData ?? this.cloudLoginData,
      remoteLoginData: remoteLoginData ?? this.remoteLoginData,
      apiLoginData: apiLoginData ?? this.apiLoginData,
    );
  }

  bool get hasCloudLogin => cloudLoginData != null;

  bool get hasRemoteLogin => remoteLoginData != null;

  bool get hasApiLogin => apiLoginData != null;
}

// Login Data for Local OpenHAB Server
@JsonSerializable()
class LocalLoginData extends JsonSerializable {
  final String host;
  final String port;

  String get url => 'http://$host:$port/rest';

  LocalLoginData(this.host, this.port);

  factory LocalLoginData.fromJson(Map<String, dynamic> json) =>
      _$LocalLoginDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocalLoginDataToJson(this);
}

// Login Data for MyOpenHAB
@JsonSerializable()
class CloudLoginData extends JsonSerializable {
  final String username;
  final String password;

  CloudLoginData(this.username, this.password);

  factory CloudLoginData.fromJson(Map<String, dynamic> json) =>
      _$CloudLoginDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CloudLoginDataToJson(this);
}

// Login Data for remote access via available url
@JsonSerializable()
class RemoteLoginData extends JsonSerializable {
  final String url;
  final String? port;
  final String? basicAuthUsername;
  final String? basicAuthPassword;

  String get fullUrl => "${port != null ? '$url:$port' : url}/rest";

  bool get hasBasicAuth => basicAuthUsername != null && basicAuthPassword != null;

  RemoteLoginData(this.url,
      {this.port, this.basicAuthUsername, this.basicAuthPassword});

  factory RemoteLoginData.fromJson(Map<String, dynamic> json) =>
      _$RemoteLoginDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoteLoginDataToJson(this);
}

// Login Data for the Api
@JsonSerializable()
class ApiLoginData extends JsonSerializable {
  final String apiToken;

  ApiLoginData(this.apiToken);

  factory ApiLoginData.fromJson(Map<String, dynamic> json) =>
      _$ApiLoginDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ApiLoginDataToJson(this);
}
