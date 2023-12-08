import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'core/database/app_database.dart';
import 'core/network/AuthInterceptor.dart';
import 'core/network/generated/client_index.dart';
import 'core/routing/navigation_service.dart';
import 'repository/login_repository.dart';
import 'view/util/snackbar/snackbar_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // shared preferences
  locator.registerSingletonAsync<StreamingSharedPreferences>(
      () async => StreamingSharedPreferences.instance);

  // navigation service
  locator.registerSingleton(NavigationService());

  // snackbar service
  locator.registerSingleton(SnackbarService());

  // database
  locator.registerSingleton(AppDatabase());

  // repositories
  locator.registerSingleton(LoginRepository());

  // API
  locator.registerSingleton<OpenHAB>(OpenHAB.create(
      baseUrl: Uri.parse("https://myopenhab.org/rest"),
      interceptors: [
        AuthInterceptor(),
        kDebugMode ? HttpLoggingInterceptor() : null
      ]));
}
