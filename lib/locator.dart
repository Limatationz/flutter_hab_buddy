import 'package:get_it/get_it.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import 'core/database/app_database.dart';
import 'core/database/favourites/favourites_view_settings_store.dart';
import 'core/routing/navigation_service.dart';
import 'core/services/wall_mount_service.dart';
import 'core/services/snackbar_service.dart';
import 'repository/automation_repository.dart';
import 'repository/chart_repository.dart';
import 'repository/item_repository.dart';
import 'repository/login_repository.dart';
import 'repository/weather_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // shared preferences
  locator.registerSingleton<RxSharedPreferences>(
      RxSharedPreferences.getInstance());

  // navigation service
  locator.registerSingleton(NavigationService());

  // snackbar service
  locator.registerSingleton(SnackbarService());

  // other services
  locator.registerLazySingleton(() => WallMountService());

  // database
  locator.registerLazySingleton(() => AppDatabase.defaults());
  locator.registerLazySingleton(() => FavouriteViewSettingsStore());

  locator.registerSingleton(LoginRepository());

  // repositories
  locator.registerSingleton(ChartRepository());
  locator.registerSingleton(
    ItemRepository(),
  );
  locator.registerSingleton(WeatherRepository());
  locator.registerSingleton(AutomationRepository());
}
