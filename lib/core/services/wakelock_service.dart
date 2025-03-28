import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../locator.dart';

class WakelockService {
  static const prefsKey = "wakelockAutoEnabled";
  final RxSharedPreferences _prefs = locator<RxSharedPreferences>();
  final BehaviorSubject<bool> _enabledSubject = BehaviorSubject.seeded(false);

  Stream<bool> get enabledStream => _enabledSubject.stream;

  Stream<bool> get autoEnabledStream =>
      _prefs.getBoolStream(prefsKey).map((e) => e ?? false);

  bool _autoEnabled = false;
  bool get autoEnabled =>
      _autoEnabled;

  WakelockService() {
    autoEnabledStream.listen((value) {
      _autoEnabled = value;
    });
  }

  Future enable() async {
    await WakelockPlus.enable();
    _enabledSubject.add(true);
  }

  Future disable() async {
    await WakelockPlus.disable();
    _enabledSubject.add(false);
  }

  Future<void> autoEnable() async {
    final value = await autoEnabled;
    if (value) {
      await enable();
    }
  }

  Future<void> autoDisable() async {
    if (await getCurrentlyEnabled()) {
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
