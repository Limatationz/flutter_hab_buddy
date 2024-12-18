import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import '../core/network/generated/openHAB.swagger.dart';
import '../core/network/interceptors/LoginInterceptor.dart';

class LoginRepository {
  final _secureStorage = const FlutterSecureStorage();
  final BehaviorSubject<bool?> _loggedIn = BehaviorSubject.seeded(null);

  Stream<bool?> get loggedIn => _loggedIn.stream;

  final BehaviorSubject<RemoteLoginData?> _loginData = BehaviorSubject.seeded(null);

  Stream<RemoteLoginData?> get loginData => _loginData.stream;

  Completer<bool> loginComplete = Completer();

  LoginRepository() {
    _loginData.listen((event) {
      if (event != null) {
        loginComplete.complete(true);
      }
    });
  }

  String? get basicAuth {
    if (_loginData.value != null) {
      final username = _loginData.value!.username;
      final password = _loginData.value!.password;
      final bytes = utf8.encode("$username:$password");
      final base64Str = base64.encode(bytes);
      return "Basic $base64Str";
    } else {
      return null;
    }
  }

  Future<void> checkLogin() async {
    final username = await _secureStorage.read(key: 'username');
    final password = await _secureStorage.read(key: 'password');
    final apiToken = await _secureStorage.read(key: 'apiToken');
    if (username != null && password != null && apiToken != null) {
      _loggedIn.add(true);
      _loginData.add(RemoteLoginData(username, password));
    } else {
      _loggedIn.add(false);
    }
  }

  /// checks if login is valid and stores it in secure storage
  /// returns true if login is valid
  /// returns false if login is invalid or server is not reachable
  Future<bool> storeLogin(
      {required String username,
      required String password,
      required String apiToken}) async {
    // check login
    // TODO: Test APi Token!!
    final api = OpenHAB.create(
        baseUrl: Uri.parse("https://myopenhab.org/rest"),
        interceptors: [
          LoginInterceptor(username, password),
        ]);
    final result = await api.get();
    if (result.isSuccessful) {
      await _secureStorage.write(key: 'username', value: username);
      await _secureStorage.write(key: 'password', value: password);
      await _secureStorage.write(key: 'apiToken', value: apiToken);

      _loggedIn.add(true);
      _loginData.add(RemoteLoginData(username, password));
      return true;
    } else {
      _loggedIn.add(false);
      _loginData.add(null);
      return false;
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'password');
    await _secureStorage.delete(key: 'apiToken');
    _loggedIn.add(false);
    _loginData.add(null);
  }
}

// Login Data for Local OpenHAB Server
class LocalLoginData {
  final String host;
  final String port;

  LocalLoginData(this.host, this.port);
}

// Login Data for MyOpenHAB
class RemoteLoginData {
  final String username;
  final String password;

  RemoteLoginData(this.username, this.password);
}

class ApiLoginData {
  final String apiToken;

  ApiLoginData(this.apiToken);
}
