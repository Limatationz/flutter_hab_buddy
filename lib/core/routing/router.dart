import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../locator.dart';
import '../../view/login/login_view.dart';
import '../../view/main/favourite/favourite_view.dart';
import '../../view/main/main_view.dart';
import '../../view/main/rooms/rooms_view.dart';
import '../../view/main/settings/settings_view.dart';
import '../../view/start_view.dart';
import '../services/wakelock_service.dart';
import 'error_view.dart';
import 'navigation_service.dart';

final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: StartView.routePath,
    navigatorKey: locator.get<NavigationService>().navigatorKey,
    errorBuilder: (context, state) => ErrorView(state: state),
    routes: [
      StatefulShellRoute.indexedStack(
          pageBuilder: (context, state, child) {
            return NoTransitionPage(child: MainView(navigationShell: child));
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
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: RoomsView()),
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
        path: StartView.routePath,
        name: StartView.routeName,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: StartView()),
      ),
      GoRoute(
        path: LoginView.routePath,
        name: LoginView.routeName,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginView()),
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
