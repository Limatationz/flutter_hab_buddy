import 'dart:async';

import 'package:chopper/chopper.dart';

class ContentTypeInterceptor implements Interceptor {
  ContentTypeInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    if (request.url.toString().contains("rest/items/") &&
        request.method == "POST") {
      return chain.proceed(applyHeader(request, 'Content-Type', 'text/plain'));
    } else {
      return chain.proceed(request);
    }
  }
}
