import 'package:flutter/services.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../locator.dart';
import 'face_recognition_service.dart';

class WallMountService {
  static const prefsKey = "wallMountAutoEnabled";
  final RxSharedPreferences _prefs = locator<RxSharedPreferences>();
  final FaceRecognitionService faceRecognitionService = FaceRecognitionService();

  final BehaviorSubject<bool> _enabledSubject = BehaviorSubject.seeded(false);

  Stream<bool> get enabledStream => _enabledSubject.stream;

  Stream<bool> get autoEnabledStream =>
      _prefs.getBoolStream(prefsKey).map((e) => e ?? false);

  bool _autoEnabled = false;

  bool get autoEnabled => _autoEnabled;

  WallMountService() {
    autoEnabledStream.listen((value) {
      _autoEnabled = value;
    });
  }

  Future enable() async {
    // we enable the wakelock to keep the screen on
    await WakelockPlus.enable();

    // we hide the status bar and navigation bar
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);

    await faceRecognitionService.enable();

    _enabledSubject.add(true);
  }

  Future disable() async {
    // we disable the wakelock
    await WakelockPlus.disable();

    // we show the status bar and navigation bar
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    await faceRecognitionService.disable();

    _enabledSubject.add(false);
  }

  Future<void> autoEnable() async {
    final value = autoEnabled;
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
