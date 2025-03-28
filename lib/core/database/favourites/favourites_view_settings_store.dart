import 'dart:convert';

import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import '../../../locator.dart';
import 'favourites_view_settings.dart';

class FavouriteViewSettingsStore {
  static const key = "favourite_view_settings";
  final _prefs = locator<RxSharedPreferences>();

  FavouriteViewSettings? _cachedSettings;

  FavouriteViewSettings get settings => _cachedSettings ??= FavouriteViewSettings.defaultAutoSettings;

  FavouriteViewSettingsStore(){
    watchSettings().listen((settings) => _cachedSettings = settings);
  }

  Future<FavouriteViewSettings> getSettings() async {
    final data = await _prefs.getString(key);
    if (data != null) {
      return FavouriteViewSettings.fromJson(jsonDecode(data));
    }
    return FavouriteViewSettings.defaultAutoSettings;
  }

  Future<void> setSettings(FavouriteViewSettings settings) async {
    await _prefs.setString(key, jsonEncode(settings.toJson()));
  }

  Stream<FavouriteViewSettings> watchSettings() =>
      _prefs.getStringStream(key).map((data) => data == null
          ? FavouriteViewSettings.defaultAutoSettings
          : FavouriteViewSettings.fromJson(jsonDecode(data)));

  Future<void> removeSettings() async {
    await _prefs.remove(key);
  }
}
