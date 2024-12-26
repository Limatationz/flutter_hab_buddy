import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/item_type.dart';
import '../../../core/services/wakelock_service.dart';
import '../../../locator.dart';
import '../../../main.dart';
import '../../../repository/automation_repository.dart';
import '../../../repository/connectivity_manager.dart';
import '../../../repository/item_repository.dart';
import '../../../repository/login_repository.dart';
import '../../login/login_api_setup_view.dart';
import '../../login/login_remote_setup_view.dart';
import '../../login/login_start_view.dart';

class SettingsViewModel extends BaseViewModel {
  final _db = locator<AppDatabase>();
  final _itemsRepository = locator<ItemRepository>();
  final _automationRepository = locator<AutomationRepository>();
  final _loginRepository = locator<LoginRepository>();
  final wakelockService = locator<WakelockService>();

  Stream<ServerConnectionState> get connectionStatus =>
      _loginRepository.connectivityManager.connectionStateStream;

  Stream<DateTime?> get lastSSEConnectionStart =>
      _loginRepository.connectivityManager.sseLastConnection;

  Stream<DateTime?> get lastSSEUpdate => _loginRepository.connectivityManager.sseLastMessage;

  int getThemeIndex(BuildContext context) {
    return AdaptiveTheme
        .of(context)
        .mode
        .index;
  }

  bool get missingRemoteSetup => !_loginRepository.hasRemoteLoginData;
  bool get missingCloudSetup => !_loginRepository.hasCloudLoginData;
  bool get missingApiSetup => !_loginRepository.hasApiLoginData;

  SettingsViewModel() {
    _loginRepository.loginData.listen((event) {
      // update ui when login data changes -> user adds new login data like remote, cloud or api
      notifyListeners();
    });
  }

  void setTheme(BuildContext context, int index) {
    AdaptiveTheme.of(context).setThemeMode(AdaptiveThemeMode.values[index]);
    final theme = AdaptiveTheme
        .of(context)
        .theme;
    setSystemOverlay(theme);
  }

  void setWakeLockAutoEnabled(bool enabled) {
    wakelockService.setAutoEnabled(enabled);
    notifyListeners();
  }

  Future<void> addRemoteSetup(BuildContext context) async {
    context.pushNamed(LoginRemoteSetupView.routeName, queryParameters: {'type': "remote"});
  }

  Future<void> addCloudSetup(BuildContext context) async {
    context.pushNamed(LoginRemoteSetupView.routeName, queryParameters: {'type': "cloud"});
  }

  Future<void> addApiSetup(BuildContext context) async {
    final result = await context.pushNamed(LoginApiSetupView.routeName, queryParameters: {'type': "fromSettings"});
    _automationRepository.fetchData();
  }

  Future<void> logout(BuildContext context) async {
    await _db.deleteAllData();
    await _loginRepository.logout();
    context.replaceNamed(LoginStartView.routeName);
  }

  Future<void> clearDatabase() async {
    await _db.deleteAllData();
    await _itemsRepository.fetchData();
  }

  static Future<void> insertDummyDataMunich() async {
    final _itemsRepository = locator<ItemRepository>();
    final _db = locator<AppDatabase>();

    // create rooms
    final roomStore = _db.roomsStore;

    final rooms = [
      RoomsTableCompanion.insert(
          name: "Schlafzimmer", icon: Value(Icons.bed),
          color: Value("#CEFDFF"), sortKey: 0),
      RoomsTableCompanion.insert(
          name: "Küche", icon: Value(Icons.kitchen),
          color: Value("#EE964B"), sortKey: 1),
      RoomsTableCompanion.insert(
          name: "Flur", color: Value("#4062BB"), sortKey: 2),
      RoomsTableCompanion.insert(
          name: "Bad",
          icon: Value(Icons.bathtub),
          color: Value("#00FF00"),
          sortKey: 3),
    ];

    // bedRoom
    final bedRoom = await roomStore.insertOrUpdateSingleWithId(rooms[0]);

    // kitchen
    final kitchen = await roomStore.insertOrUpdateSingleWithId(rooms[1]);

    // hallway
    final hallway = await roomStore.insertOrUpdateSingleWithId(rooms[2]);

    // bathRoom
    final bathRoom = await roomStore.insertOrUpdateSingleWithId(rooms[3]);

    final inboxStore = _db.inboxStore;
    final inboxItemNames = (await inboxStore.all().get()).map((e) => e.name);

    // create items
    if (inboxItemNames.contains("Lampe_Bad")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Lampe_Bad",
          type: ItemType.light,
          roomId: bathRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Rollo_Tuer")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Rollo_Tuer",
          type: ItemType.rollerShutter,
          roomId: bedRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Rollos_Fenster")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Rollos_Fenster",
          type: ItemType.rollerShutter,
          roomId: bedRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Lampe_Wohnzimmer")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Lampe_Wohnzimmer",
          type: ItemType.light,
          roomId: bedRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Thermometer_Bad_Temperatur")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermometer_Bad_Temperatur",
          type: ItemType.temperature,
          roomId: bathRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Thermometer_Bad_Luftfeuchtigkeit")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermometer_Bad_Luftfeuchtigkeit",
          type: ItemType.humidity,
          roomId: bathRoom);
    }
    if (inboxItemNames.contains("Thermometer_Schlafzimmer_Temperatur")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermometer_Schlafzimmer_Temperatur",
          type: ItemType.temperature,
          roomId: bedRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("CO2Sensor_CO2")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "CO2Sensor_CO2",
          type: ItemType.airQuality,
          roomId: bedRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Szene_Tv")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Szene_Tv",
          type: ItemType.button,
          roomId: bedRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Lampe_Kueche")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Lampe_Kueche",
          type: ItemType.light,
          roomId: kitchen,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Bewegungsmelder_Kueche_Bewegung")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Bewegungsmelder_Kueche_Bewegung",
          type: ItemType.presence,
          roomId: kitchen,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Lampe_Flur")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Lampe_Flur",
          type: ItemType.light,
          roomId: hallway,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Bewegungsmelder_Flur_Bewegung")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Bewegungsmelder_Flur_Bewegung",
          type: ItemType.presence,
          roomId: hallway,
          isFavorite: true);
    }

    await _itemsRepository.fetchData();
  }


  static Future<void> insertDummyDataHof() async {
    final _itemsRepository = locator<ItemRepository>();
    final _db = locator<AppDatabase>();

    // create rooms
    final roomStore = locator<AppDatabase>().roomsStore;

    final rooms = [
      RoomsTableCompanion.insert(
          name: "Erik", icon: Value(Icons.bed),
          color: Value("#CEFDFF"), sortKey: 0),
      RoomsTableCompanion.insert(
          name: "Wohnzimmer", icon: Value(Icons.tv),
          color: Value("#EE964B"), sortKey: 1),
      RoomsTableCompanion.insert(
          name: "Malte", color: Value("#4062BB"), sortKey: 2),
      RoomsTableCompanion.insert(
          name: "Bad",
          icon: Value(Icons.bathtub),
          color: Value("#00FF00"),
          sortKey: 3),
    ];

    // Eriks Room
    final erikRoom = await roomStore.insertOrUpdateSingleWithId(rooms[0]);

    // living room
    final livingRoom = await roomStore.insertOrUpdateSingleWithId(rooms[1]);

    // Maltes Room
    final malteRoom = await roomStore.insertOrUpdateSingleWithId(rooms[2]);

    // bathRoom
    final bathRoom = await roomStore.insertOrUpdateSingleWithId(rooms[3]);

    final inboxStore = _db.inboxStore;
    final inboxItemNames = (await inboxStore.all().get()).map((e) => e.name);

    // create items
    // Erik
    if (inboxItemNames.contains("Erik_pos3")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Erik_pos3",
          type: ItemType.rollerShutter,
          roomId: erikRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("stripe_erik_brightness")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "stripe_erik_brightness",
          type: ItemType.light,
          roomId: erikRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Thermostat_Erik_Temperature")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermostat_Erik_Temperature",
          type: ItemType.temperature,
          roomId: erikRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Thermostat_Erik_Actual_Humidity")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermostat_Erik_Actual_Humidity",
          type: ItemType.humidity,
          roomId: erikRoom,
          isFavorite: true);
    }

    // Malte
    if (inboxItemNames.contains("Erik_pos3")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Erik_pos3",
          type: ItemType.rollerShutter,
          roomId: malteRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Lampe_Malte")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Lampe_Malte",
          type: ItemType.light,
          roomId: malteRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Thermostat_Malte_Temperature")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermostat_Malte_Temperature",
          type: ItemType.temperature,
          roomId: malteRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Thermostat_Malte_Actual_Humidity")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermostat_Malte_Actual_Humidity",
          type: ItemType.humidity,
          roomId: malteRoom,
          isFavorite: true);
    }

    // livingRoom
    if (inboxItemNames.contains("Thermostat_Wohnzimmer_Actual_Temperature")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermostat_Wohnzimmer_Actual_Temperature",
          type: ItemType.temperature,
          roomId: livingRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Thermostat_Wohnzimmer_Actual_Humidity")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermostat_Wohnzimmer_Actual_Humidity",
          type: ItemType.humidity,
          roomId: livingRoom);
    }

    // Bathroom
    if (inboxItemNames.contains("Thermostat_Bad_EG_Actual_Humidity")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermostat_Bad_EG_Actual_Humidity",
          type: ItemType.humidity,
          roomId: bathRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Thermostat_Bad_EG_Actual_Temperature")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Thermostat_Bad_EG_Actual_Temperature",
          type: ItemType.temperature,
          roomId: bathRoom,
          isFavorite: true);
    }
    if (inboxItemNames.contains("Fenster_Sensor_Bad_Fensterkontakt")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Fenster_Sensor_Bad_Fensterkontakt",
          type: ItemType.windowContact,
          roomId: bathRoom,
          isFavorite: true);
    }

    await _itemsRepository.fetchData();
  }
}
