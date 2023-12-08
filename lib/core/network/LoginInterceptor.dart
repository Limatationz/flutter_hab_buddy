import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

class LoginInterceptor implements RequestInterceptor {
  final String _username;
  final String _password;

  LoginInterceptor(this._username, this._password);

  @override
  FutureOr<Request> onRequest(Request request) async {
    final bytes = utf8.encode("$_username:$_password");
    final base64Str = base64.encode(bytes);
    return applyHeader(request, 'Authorization', 'Basic $base64Str');
  }
}
