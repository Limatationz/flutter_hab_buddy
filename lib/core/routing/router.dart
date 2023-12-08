import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../locator.dart';
import '../../view/login/login_view.dart';
import '../../view/main/favourite/favourite_view.dart';
import '../../view/main/inbox/inbox_view.dart';
import '../../view/main/main_view.dart';
import '../../view/main/rooms/rooms_view.dart';
import '../../view/start_view.dart';
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
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: InboxView.routePath,
                  name: InboxView.routeName,
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(child: InboxView()),
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
