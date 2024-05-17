import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

class LoginInterceptor implements Interceptor {
  final String _username;
  final String _password;

  LoginInterceptor(this._username, this._password);

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    final bytes = utf8.encode("$_username:$_password");
    final base64Str = base64.encode(bytes);
    return chain.proceed(applyHeader(request, 'Authorization', 'Basic $base64Str'));
  }
}
