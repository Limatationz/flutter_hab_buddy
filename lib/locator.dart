import 'package:get_it/get_it.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'core/network/client/http_client_factory.dart'
  if (dart.library.js_interop) 'core/network/client/http_client_factory_web.dart';

import 'core/database/app_database.dart';
import 'core/network/generated/client_index.dart';
import 'core/network/interceptors/AuthInterceptor.dart';
import 'core/routing/navigation_service.dart';
import 'core/services/wakelock_service.dart';
import 'core/services/snackbar_service.dart';
import 'repository/automation_repository.dart';
import 'repository/chart_repository.dart';
import 'repository/item_repository.dart';
import 'repository/login_repository.dart';
import 'repository/weather_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // shared preferences
  locator.registerSingletonAsync<StreamingSharedPreferences>(
      () async => StreamingSharedPreferences.instance);

  // navigation service
  locator.registerSingleton(NavigationService());

  // snackbar service
  locator.registerSingleton(SnackbarService());

  // other services
  locator.registerSingletonWithDependencies(() => WakelockService(),
      dependsOn: [StreamingSharedPreferences]);

  // database
  locator.registerLazySingleton(() => AppDatabase());

  locator.registerSingleton(LoginRepository());

  // API
  locator.registerSingleton<OpenHAB>(OpenHAB.create(
      baseUrl: Uri.parse("https://myopenhab.org/rest"),
      httpClient: getHttpClient(),
      interceptors: [
        AuthInterceptor(),
        // kDebugMode ? HttpLoggingInterceptor() : null
      ]));

  // repositories
  locator.registerSingleton(ChartRepository());
  locator.registerSingleton(
    ItemRepository(),
  );
  locator.registerSingleton(WeatherRepository());
  locator.registerSingleton(AutomationRepository());
}
