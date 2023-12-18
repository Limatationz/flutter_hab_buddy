import 'package:get_it/get_it.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'core/database/app_database.dart';
import 'core/network/generated/client_index.dart';
import 'core/network/interceptors/AuthInterceptor.dart';
import 'core/routing/navigation_service.dart';
import 'core/snackbar/snackbar_service.dart';
import 'repository/chart_repository.dart';
import 'repository/item_repository.dart';
import 'repository/login_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // shared preferences
  locator.registerSingletonAsync<StreamingSharedPreferences>(
      () async => StreamingSharedPreferences.instance);

  // navigation service
  locator.registerSingleton(NavigationService());

  // snackbar service
  locator.registerSingleton(SnackbarService());

  // database
  locator.registerLazySingleton(() => AppDatabase());

  locator.registerSingleton(LoginRepository());

  // API
  locator.registerSingleton<OpenHAB>(OpenHAB.create(
      baseUrl: Uri.parse("https://myopenhab.org/rest"),
      interceptors: [
        AuthInterceptor(),
        // kDebugMode ? HttpLoggingInterceptor() : null
      ]));

  // repositories
  locator.registerSingleton(ChartRepository());
  locator.registerSingleton(
    ItemRepository(),
  );
}
