import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import '../../../locator.dart';
import '../../../repository/login_repository.dart';

class ContentTypeInterceptor implements RequestInterceptor {
  ContentTypeInterceptor() {}

  @override
  FutureOr<Request> onRequest(Request request) async {
    if (request.url.toString().contains("rest/items/") &&
        request.method == "POST") {
      return applyHeader(request, 'Content-Type', 'text/plain');
    } else {
      return request;
    }
  }
}
