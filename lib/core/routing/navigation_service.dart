
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked_services/stacked_services.dart';


class NavigationService {
  final GlobalKey<NavigatorState>? navigatorKey = StackedService.navigatorKey;
  final GlobalKey<NavigatorState> shellNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'shell');

  dynamic navigateTo(String routeName,
      {Map<String, String>? arguments, Map<String, String>? params}) {
    return navigatorKey!.currentContext!.goNamed(routeName,
        queryParameters: arguments ?? const <String, String>{},
        pathParameters: params ?? const <String, String>{});
  }

  dynamic navigateToReplacement(String routeName,
      {Map<String, String>? arguments, Object? extra}) {
    return navigatorKey!.currentContext!.pushNamed(routeName,
        queryParameters: arguments ?? const <String, String>{}, extra: extra);
  }

  void pop() {
    return navigatorKey!.currentContext!.pop();
  }

/*void popWithResult<T extends Object>([T? result]) {
    return navigatorKey!.currentContext!.po pop(result);
  }*/
}
