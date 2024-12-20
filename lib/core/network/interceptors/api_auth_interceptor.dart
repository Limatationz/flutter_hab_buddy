import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import '../../../locator.dart';
import '../../../repository/login_repository.dart';
import '../../database/login/login_data.dart';

class ApiAuthInterceptor implements Interceptor {
  String? _apiToken;

  ApiAuthInterceptor(Stream<LoginData?> loginDataStream) {
    loginDataStream.listen((loginData) {
      _apiToken = loginData?.apiLoginData?.apiToken;
    });
  }

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;

    if (_apiToken != null) {
      return chain
          .proceed(applyHeaders(request, {'X-OPENHAB-TOKEN': _apiToken ?? ''}));
    } else {
      return chain.proceed(request);
    }
  }
}
