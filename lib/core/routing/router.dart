import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../locator.dart';
import '../../oss_licenses.dart';
import '../../view/login/login_api_setup_view.dart';
import '../../view/login/login_local_setup_view.dart';
import '../../view/login/login_remote_setup_view.dart';
import '../../view/login/login_start_view.dart';
import '../../view/main/automation/automation_view.dart';
import '../../view/main/automation/by_item/automations_by_item_view.dart';
import '../../view/main/automation/edit/automation_edit_view.dart';
import '../../view/main/automation/edit/automation_edit_view_arguments.dart';
import '../../view/main/favourite/favourite_view.dart';
import '../../view/main/main_view.dart';
import '../../view/main/rooms/rooms_view.dart';
import '../../view/main/settings/licences/licences_view.dart';
import '../../view/main/settings/licences/single_licence_view.dart';
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
                  pageBuilder: (context, state) {
                    final roomId =
                        int.tryParse(state.uri.queryParameters['roomId'] ?? '');
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
                    routes: [
                      GoRoute(
                          path: LicencesView.routePath,
                          name: LicencesView.routeName,
                          pageBuilder: (context, state) =>
                              const CupertinoPage(child: LicencesView()),
                          routes: [
                            GoRoute(
                              path: SingleLicenceView.routePath,
                              name: SingleLicenceView.routeName,
                              pageBuilder: (context, state) {
                                final packageName = state.pathParameters["name"] as String;
                                final package = allDependencies.firstWhereOrNull((element) => element.name == packageName);
                                return CupertinoPage(
                                    child: SingleLicenceView(package: package, packageName: packageName,));
                              },
                            )
                          ])
                    ]),
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
      GoRoute(
          path: AutomationsByItemView.routePath,
          name: AutomationsByItemView.routeName,
          pageBuilder: (context, state) {
            final itemName = state.pathParameters['itemName']!;
            return CupertinoPage(
                child: AutomationsByItemView(
              itemName: itemName,
            ));
          }),
      GoRoute(
        path: AutomationEditView.routePath,
        name: AutomationEditView.routeName,
        pageBuilder: (context, state) {
          final initialRuleUid = state.uri.queryParameters['initialRuleUid'];
          final itemName = state.uri.queryParameters['itemNameOpenedBy'];
          final extra = state.extra as AutomationEditViewExtraArguments?;
          return CupertinoPage(
              child: AutomationEditView(
            args: AutomationEditViewArguments(
              initialRuleUid: initialRuleUid,
              itemNameOpenedBy: itemName,
            ),
            extra: extra,
          ));
        },
      ),
    ],
    extraCodec: const MyExtraCodec());

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

class MyExtraCodec extends Codec<Object?, Object?> {
  /// Create a codec.
  const MyExtraCodec();

  @override
  Converter<Object?, Object?> get decoder => const _MyExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _MyExtraEncoder();
}

class _MyExtraDecoder extends Converter<Object?, Object?> {
  const _MyExtraDecoder();

  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    final List<Object?> inputAsList = input as List<Object?>;
    if (inputAsList[0] == 'AutomationEditViewExtraArguments') {
      return AutomationEditViewExtraArguments.fromJson(
          jsonDecode(inputAsList[1]! as String));
    }

    throw FormatException('Unable to parse input: $input');
  }
}

class _MyExtraEncoder extends Converter<Object?, Object?> {
  const _MyExtraEncoder();

  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    switch (input) {
      case AutomationEditViewExtraArguments _:
        return <Object?>[
          'AutomationEditViewExtraArguments',
          jsonEncode(input.toJson())
        ];
      default:
        throw FormatException('Cannot encode type ${input.runtimeType}');
    }
  }
}
