import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../locator.dart';
import '../../view/login/login_api_setup_view.dart';
import '../../view/login/login_local_setup_view.dart';
import '../../view/login/login_remote_setup_view.dart';
import '../../view/login/login_start_view.dart';
import '../../view/main/automation/automation_view.dart';
import '../../view/main/favourite/favourite_view.dart';
import '../../view/main/main_view.dart';
import '../../view/main/rooms/rooms_view.dart';
import '../../view/main/settings/settings_view.dart';
import '../services/wakelock_service.dart';
import 'error_view.dart';
import 'navigation_service.dart';

GoRouter router(bool isLoggedIn) => GoRouter(
        debugLogDiagnostics: kDebugMode,
        initialLocation:
            isLoggedIn ? FavouriteView.routePath : LoginStartView.routePath,
        navigatorKey: locator.get<NavigationService>().navigatorKey,
        errorBuilder: (context, state) => ErrorView(state: state),
        routes: [
          StatefulShellRoute.indexedStack(
              pageBuilder: (context, state, child) {
                return NoTransitionPage(
                    child: MainView(navigationShell: child));
              },
              branches: [
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: FavouriteView.routePath,
                      name: FavouriteView.routeName,
                      pageBuilder: (context, state) =>
                          const NoTransitionPage(child: FavouriteView()),
                      onExit: onExitMainView,
                      redirect: onEntryMainView,
                    ),
                  ],
                ),
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: RoomsView.routePath,
                      name: RoomsView.routeName,
                      pageBuilder: (context, state) {
                        final roomId = int.tryParse(
                            state.uri.queryParameters['roomId'] ?? '');
                        return NoTransitionPage(
                            child: RoomsView(initialRoomId: roomId));
                      },
                      onExit: onExitMainView,
                      redirect: onEntryMainView,
                    ),
                  ],
                ),
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: AutomationView.routePath,
                      name: AutomationView.routeName,
                      pageBuilder: (context, state) =>
                          const NoTransitionPage(child: AutomationView()),
                      onExit: onExitMainView,
                      redirect: onEntryMainView,
                    ),
                  ],
                ),
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: SettingsView.routePath,
                      name: SettingsView.routeName,
                      pageBuilder: (context, state) =>
                          const NoTransitionPage(child: SettingsView()),
                    ),
                  ],
                ),
              ]),
          GoRoute(
            path: LoginStartView.routePath,
            name: LoginStartView.routeName,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LoginStartView()),
            routes: [
              GoRoute(
                path: LoginLocalSetupView.routePath,
                name: LoginLocalSetupView.routeName,
                pageBuilder: (context, state) =>
                    const CupertinoPage(child: LoginLocalSetupView()),
              ),
              GoRoute(
                path: LoginRemoteSetupView.routePath,
                name: LoginRemoteSetupView.routeName,
                pageBuilder: (context, state) {
                  final type = state.uri.queryParameters['type'];
                  return CupertinoPage(
                      child: LoginRemoteSetupView(
                    type: type,
                  ));
                },
              ),
              GoRoute(
                path: LoginApiSetupView.routePath,
                name: LoginApiSetupView.routeName,
                pageBuilder: (context, state) {
                  final type = state.uri.queryParameters['type'];
                  return CupertinoPage(
                      child: LoginApiSetupView(
                        type: type,
                      ));
                },
              )
            ],
          ),
        ]);

FutureOr<bool> onExitMainView(BuildContext context, GoRouterState state) {
  // disable wakelock when leaving favourite view
  locator<WakelockService>().autoDisable();
  return true;
}

FutureOr<String?> onEntryMainView(BuildContext context, GoRouterState state) {
  // enable wakelock when entering favourite view
  Future.delayed(const Duration(milliseconds: 10), () {
    // delay because onEntry is triggered before on exit when switching between tabs
    locator<WakelockService>().autoEnable();
  });
  return null;
}
