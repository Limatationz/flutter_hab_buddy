import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import '../../../locator.dart';
import '../../../repository/login_repository.dart';
import '../../database/login/login_data.dart';

class RemoteBasisAuthInterceptor implements Interceptor {
  String? _username;
  String? _password;

  RemoteBasisAuthInterceptor(Stream<LoginData?> loginDataStream) {
    loginDataStream.listen((tuple) {
      _username = tuple?.remoteLoginData?.basicAuthUsername;
      _password = tuple?.remoteLoginData?.basicAuthPassword;
    });
  }

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;

    // first we check if the request is to the openhab cloud
    if (!request.url.toString().contains("myopenhab.org")) {
      if (_username != null && _password != null) {
        final bytes = utf8.encode("$_username:$_password");
        final base64Str = base64.encode(bytes);
        return chain.proceed(applyHeaders(request, {
          'Authorization': 'Basic $base64Str',
        }));
      } else {
        return chain.proceed(request);
      }
    } else {
      // if the request is not to the openhab cloud we just return the request
      return chain.proceed(request);
    }
  }
}
