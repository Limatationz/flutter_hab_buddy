import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import '../../../locator.dart';
import '../../../repository/login_repository.dart';

class AuthInterceptor implements Interceptor {
  final _loginRepository = locator.get<LoginRepository>();
  String? _username;
  String? _password;

  AuthInterceptor() {
    _loginRepository.loginData.listen((tuple) {
      _username = tuple?.item1;
      _password = tuple?.item2;
    });
  }

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    if (_username != null && _password != null) {
      final bytes = utf8.encode("$_username:$_password");
      final base64Str = base64.encode(bytes);
      return chain.proceed(applyHeader(
          request, 'Authorization', 'Basic $base64Str'));
    } else {
      return chain.proceed(request);
    }
  }
}
