import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../core/database/login/login_data.dart';
import 'connectivity_manager.dart';

class LoginRepository {
  static const String _secureStorageKey = 'loginData';

  final _secureStorage = const FlutterSecureStorage();
  final BehaviorSubject<bool?> _loggedIn = BehaviorSubject.seeded(null);

  Stream<bool?> get loggedIn => _loggedIn.stream;

  final BehaviorSubject<LoginData?> _loginData = BehaviorSubject.seeded(null);

  Stream<LoginData?> get loginData => _loginData.stream;

  Stream<bool> get hasApiAccessStream => _loginData.map((event) => event?.apiLoginData != null);

  Completer<bool> loginComplete = Completer();

  late final ConnectivityManager _connectivityManager;

  ConnectivityManager get connectivityManager => _connectivityManager;

  final Completer<bool> firstConnectionComplete = Completer();

  LoginRepository() {
    _connectivityManager = ConnectivityManager(loginData, firstConnectionComplete);

    _loginData.listen((event) {
      if (event != null) {
        loginComplete.complete(true);
      }
    });
  }

  Map<String, String> get basicAuth {
    if (connectivityManager.connectionState == ServerConnectionState.cloud &&
        _loginData.value?.cloudLoginData != null) {
      final username = _loginData.value!.cloudLoginData?.username;
      final password = _loginData.value!.cloudLoginData?.password;

      if (username == null || password == null) {
        return {};
      }

      final bytes = utf8.encode("$username:$password");
      final base64Str = base64.encode(bytes);
      return {"Authorization": "Basic $base64Str"};
    } else if (connectivityManager.connectionState == ServerConnectionState.remote &&
        _loginData.value?.remoteLoginData?.hasBasicAuth == true) {
      final username = _loginData.value!.remoteLoginData?.basicAuthUsername;
      final password = _loginData.value!.remoteLoginData?.basicAuthPassword;

      if (username == null || password == null) {
        return {};
      }

      final bytes = utf8.encode("$username:$password");
      final base64Str = base64.encode(bytes);
      return {"Authorization": "Basic $base64Str"};
    } else {
      return {};
    }
  }

  Map<String, String> get apiAuth {
    if (connectivityManager.connectionState != ServerConnectionState.offline &&
        _loginData.value?.apiLoginData != null) {
      final token = _loginData.value!.apiLoginData?.apiToken;
      if (token == null) {
        return {};
      }
      return {"X-OPENHAB-TOKEN": token};
    } else {
      return {};
    }
  }

  LocalLoginData? get localLoginData {
    return _loginData.value?.localLoginData;
  }

  bool get hasRemoteLoginData {
    return _loginData.valueOrNull?.remoteLoginData != null;
  }

  bool get hasCloudLoginData {
    return _loginData.valueOrNull?.cloudLoginData != null;
  }

  bool get hasApiLoginData {
    return _loginData.valueOrNull?.apiLoginData != null;
  }

  Future<bool> checkLogin() async {
    final loginDataString =
        (await _secureStorage.read(key: _secureStorageKey)) ?? "";
    final loginData = loginDataString.isNotEmpty
        ? LoginData.fromJson(jsonDecode(loginDataString))
        : null;
    if (loginData != null) {
      _loggedIn.add(true);
      _loginData.add(loginData);
      return true;
    } else {
      _loggedIn.add(false);
      _loginData.add(null);
      return false;
    }
  }

  // just for testing
  Future<bool> storeLoginData({
    required LoginData loginData,
  }) async {
    final loginDataString = jsonEncode(loginData.toJson());
    await _secureStorage.write(key: _secureStorageKey, value: loginDataString);
    _loggedIn.add(true);
    _loginData.add(loginData);
    return true;
  }

  Future<bool> storeLocalLogin({
    required LocalLoginData localLoginData,
  }) async {
    final loginData = LoginData(localLoginData);
    final loginDataString = jsonEncode(loginData.toJson());
    await _secureStorage.write(key: _secureStorageKey, value: loginDataString);
    _loggedIn.add(true);
    _loginData.add(loginData);
    return true;
  }

  Future<bool> storeCloudLogin({required CloudLoginData cloudLoginData}) async {
    final storedLoginData = _loginData.valueOrNull;
    if (storedLoginData == null) {
      // this should not happen -> step 1 is not completed
      return false;
    }

    final newLoginData =
        storedLoginData.copyWith(cloudLoginData: cloudLoginData);
    final loginDataString = jsonEncode(newLoginData.toJson());
    await _secureStorage.write(key: _secureStorageKey, value: loginDataString);
    _loggedIn.add(true);
    _loginData.add(newLoginData);
    return true;
  }

  Future<bool> storeRemoteLogin(
      {required RemoteLoginData remoteLoginData}) async {
    final storedLoginData = _loginData.valueOrNull;
    if (storedLoginData == null) {
      // this should not happen -> step 1 is not completed
      return false;
    }

    final newLoginData =
        storedLoginData.copyWith(remoteLoginData: remoteLoginData);
    final loginDataString = jsonEncode(newLoginData.toJson());
    await _secureStorage.write(key: _secureStorageKey, value: loginDataString);
    _loggedIn.add(true);
    _loginData.add(newLoginData);
    return true;
  }

  Future<bool> storeApiToken({required ApiLoginData apiLoginData}) async {
    final storedLoginData = _loginData.valueOrNull;
    if (storedLoginData == null) {
      // this should not happen -> step 1 is not completed
      return false;
    }

    final newLoginData = storedLoginData.copyWith(apiLoginData: apiLoginData);
    final loginDataString = jsonEncode(newLoginData.toJson());
    await _secureStorage.write(key: _secureStorageKey, value: loginDataString);
    _loggedIn.add(true);
    _loginData.add(newLoginData);
    return true;
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: _secureStorageKey);
    _loggedIn.add(false);
    _loginData.add(null);
    connectivityManager.reset();
  }
}
