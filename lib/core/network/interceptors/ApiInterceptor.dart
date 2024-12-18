import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

class ApiInterceptor implements Interceptor {
  final String _apiToken;

  ApiInterceptor(this._apiToken);

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    return chain.proceed(applyHeader(request, 'X-OPENHAB-TOKEN', _apiToken));
  }
}
