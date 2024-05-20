import 'package:rxdart/rxdart.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../locator.dart';

class WakelockService {
  static const prefsKey = "wakelockAutoEnabled";
  final StreamingSharedPreferences _prefs =
      locator<StreamingSharedPreferences>();
  final BehaviorSubject<bool> _enabledSubject = BehaviorSubject.seeded(false);
  Stream<bool> get enabledStream => _enabledSubject.stream;
  Stream<bool> get autoEnabledStream => _prefs
      .getBool(prefsKey, defaultValue: false);
  bool get autoEnabled => _prefs.getBool(prefsKey, defaultValue: false).getValue();

  Future enable() async {
    await WakelockPlus.enable();
    _enabledSubject.add(true);
  }

  Future disable() async {
    await WakelockPlus.disable();
    _enabledSubject.add(false);
  }

  Future<void> autoEnable() async {
    final value = _prefs.getBool(prefsKey, defaultValue: false).getValue();
    if (value) {
      await enable();
    }
  }

  Future<void> autoDisable() async {
    if(await getCurrentlyEnabled()){
      await disable();
    }
  }

  Future<void> setAutoEnabled(bool enabled) async {
    await _prefs.setBool(prefsKey, enabled);
  }

  Future<bool> getCurrentlyEnabled() {
    return WakelockPlus.enabled;
  }
}
