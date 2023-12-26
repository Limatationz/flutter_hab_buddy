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

  final BehaviorSubject<Tuple2<String, String>?> _loginData =
      BehaviorSubject.seeded(null);

  Stream<Tuple2<String, String>?> get loginData => _loginData.stream;

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
      final username = _loginData.value!.item1;
      final password = _loginData.value!.item2;
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
    if (username != null && password != null) {
      _loggedIn.add(true);
      _loginData.add(Tuple2(username, password));
    } else {
      _loggedIn.add(false);
    }
  }

  Future<bool> storeLogin(
      {required String username, required String password}) async {
    await _secureStorage.write(key: 'username', value: username);
    await _secureStorage.write(key: 'password', value: password);

    // TODO: check login
    final api = OpenHAB.create(
        baseUrl: Uri.parse("https://myopenhab.org/rest"),
        interceptors: [
          LoginInterceptor(username, password),
        ]);
    final result = await api.get();
    if (result.isSuccessful) {
      _loggedIn.add(true);
      _loginData.add(Tuple2(username, password));
      return true;
    } else {
      _loggedIn.add(false);
      _loginData.add(null);
      return false;
    }
  }
}
