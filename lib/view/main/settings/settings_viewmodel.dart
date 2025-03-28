import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/item_type.dart';
import '../../../core/database/rooms/rooms_table.dart';
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

  Stream<DateTime?> get lastSSEUpdate =>
      _loginRepository.connectivityManager.sseLastMessage;

  AdaptiveThemeMode getThemeMode(BuildContext context) {
    return AdaptiveTheme.of(context).mode;
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

  void setTheme(BuildContext context, AdaptiveThemeMode newMode) {
    AdaptiveTheme.of(context).setThemeMode(newMode);
    final theme = AdaptiveTheme.of(context).theme;
    setSystemOverlay(theme);
  }

  void setWakeLockAutoEnabled(bool enabled) {
    wakelockService.setAutoEnabled(enabled);
    notifyListeners();
  }

  Future<void> addRemoteSetup(BuildContext context) async {
    context.pushNamed(LoginRemoteSetupView.routeName,
        queryParameters: {'type': "remote"});
  }

  Future<void> addCloudSetup(BuildContext context) async {
    context.pushNamed(LoginRemoteSetupView.routeName,
        queryParameters: {'type': "cloud"});
  }

  Future<void> addApiSetup(BuildContext context) async {
    final result = await context.pushNamed(LoginApiSetupView.routeName,
        queryParameters: {'type': "fromSettings"});
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
    final itemsRepository = locator<ItemRepository>();
    final db = locator<AppDatabase>();
    await itemsRepository.fetchData();

    // create rooms
    final roomStore = db.roomsStore;

    final rooms = [
      RoomsTableCompanion.insert(
          name: "Schlafzimmer",
          description: Value("Sorted by Score"),
          icon: Value(Icons.bed),
          color: Value("#CEFDFF"),
          sortKey: 0,
          itemsSortOption: RoomItemsSortOption.manual),
      RoomsTableCompanion.insert(
          name: "Küche",
          description: Value("Sorted by Score"),
          icon: Value(Icons.kitchen),
          color: Value("#EE964B"),
          sortKey: 1,
          itemsSortOption: RoomItemsSortOption.manual),
      RoomsTableCompanion.insert(
          name: "Flur",
          description: Value("Sorted by Score"),
          color: Value("#4062BB"),
          sortKey: 2,
          itemsSortOption: RoomItemsSortOption.byScore),
      RoomsTableCompanion.insert(
          name: "Bad",
          description: Value("Sorted Manual"),
          icon: Value(Icons.bathtub),
          color: Value("#00FF00"),
          sortKey: 3,
          itemsSortOption: RoomItemsSortOption.manual),
    ];

    // bedRoom
    final bedRoom = await roomStore.insertOrUpdateSingleWithId(rooms[0]);

    // kitchen
    final kitchen = await roomStore.insertOrUpdateSingleWithId(rooms[1]);

    // hallway
    final hallway = await roomStore.insertOrUpdateSingleWithId(rooms[2]);

    // bathRoom
    final bathRoom = await roomStore.insertOrUpdateSingleWithId(rooms[3]);

    final itemsStore = db.itemsStore;
    final items = await itemsStore.inbox().get();

    // create items
    final lampeBadItem = items.firstWhereOrNull((element) => element.ohName == "Lampe_Bad");
    if (lampeBadItem != null) {
      await itemsRepository.addItemFromInbox(
          item: lampeBadItem,
          type: ItemType.light,
          roomId: bathRoom,
          isFavorite: true);
    }

    final rolloTuerItem = items.firstWhereOrNull((element) => element.ohName == "Rollo_Tuer");
    if (rolloTuerItem != null) {
      await itemsRepository.addItemFromInbox(
          item: rolloTuerItem,
          type: ItemType.rollerShutter,
          roomId: bedRoom,
          isFavorite: true);
    }

    final rollosFensterItem = items.firstWhereOrNull((element) => element.ohName == "Rollos_Fenster");
    if (rollosFensterItem != null) {
      await itemsRepository.addItemFromInbox(
          item: rollosFensterItem,
          type: ItemType.rollerShutter,
          roomId: bedRoom,
          isFavorite: true);
    }

    final lampeWohnzimmerItem = items.firstWhereOrNull((element) => element.ohName == "Lampe_Wohnzimmer");
    if (lampeWohnzimmerItem != null) {
      await itemsRepository.addItemFromInbox(
          item: lampeWohnzimmerItem,
          type: ItemType.light,
          roomId: bedRoom,
          isFavorite: true);
    }

    final thermometerBadTemperaturItem = items.firstWhereOrNull((element) => element.ohName == "Thermometer_Bad_Temperatur");
    if (thermometerBadTemperaturItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermometerBadTemperaturItem,
          type: ItemType.temperature,
          roomId: bathRoom,
          isFavorite: true);
    }

    final thermometerBadLuftfeuchtigkeitItem = items.firstWhereOrNull((element) => element.ohName == "Thermometer_Bad_Luftfeuchtigkeit");
    if (thermometerBadLuftfeuchtigkeitItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermometerBadLuftfeuchtigkeitItem,
          type: ItemType.humidity,
          roomId: bathRoom);
    }

    final thermometerSchlafzimmerTemperaturItem = items.firstWhereOrNull((element) => element.ohName == "Thermometer_Schlafzimmer_Temperatur");
    if (thermometerSchlafzimmerTemperaturItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermometerSchlafzimmerTemperaturItem,
          type: ItemType.temperature,
          roomId: bedRoom,
          isFavorite: true);
    }

    final co2SensorCo2Item = items.firstWhereOrNull((element) => element.ohName == "CO2Sensor_CO2");
    if (co2SensorCo2Item != null) {
      await itemsRepository.addItemFromInbox(
          item: co2SensorCo2Item,
          type: ItemType.airQuality,
          roomId: bedRoom,
          isFavorite: true);
    }

    final szeneTvItem = items.firstWhereOrNull((element) => element.ohName == "Szene_Tv");
    if (szeneTvItem != null) {
      await itemsRepository.addItemFromInbox(
          item: szeneTvItem,
          type: ItemType.button,
          roomId: bedRoom,
          isFavorite: true);
    }

    final lampeKuecheItem = items.firstWhereOrNull((element) => element.ohName == "Lampe_Kueche");
    if (lampeKuecheItem != null) {
      await itemsRepository.addItemFromInbox(
          item: lampeKuecheItem,
          type: ItemType.light,
          roomId: kitchen,
          isFavorite: true);
    }

    final bewegungsmelderKuecheBewegungItem = items.firstWhereOrNull((element) => element.ohName == "Bewegungsmelder_Kueche_Bewegung");
    if (bewegungsmelderKuecheBewegungItem != null) {
      await itemsRepository.addItemFromInbox(
          item: bewegungsmelderKuecheBewegungItem,
          type: ItemType.presence,
          roomId: kitchen,
          isFavorite: true);
    }

    final lampeFlurItem = items.firstWhereOrNull((element) => element.ohName == "Lampe_Flur");
    if (lampeFlurItem != null) {
      await itemsRepository.addItemFromInbox(
          item: lampeFlurItem,
          type: ItemType.light,
          roomId: hallway,
          isFavorite: true);
    }

    final bewegungsmelderFlurBewegungItem = items.firstWhereOrNull((element) => element.ohName == "Bewegungsmelder_Flur_Bewegung");
    if (bewegungsmelderFlurBewegungItem != null) {
      await itemsRepository.addItemFromInbox(
          item: bewegungsmelderFlurBewegungItem,
          type: ItemType.presence,
          roomId: hallway,
          isFavorite: true);
    }

  }

  static Future<void> insertDummyDataHof() async {
    final itemsRepository = locator<ItemRepository>();
    final db = locator<AppDatabase>();
    await itemsRepository.fetchData();

    // create rooms
    final roomStore = locator<AppDatabase>().roomsStore;

    final rooms = [
      RoomsTableCompanion.insert(
          name: "Erik",
          icon: Value(Icons.bed),
          color: Value("#CEFDFF"),
          sortKey: 0,
          itemsSortOption: RoomItemsSortOption.byScore),
      RoomsTableCompanion.insert(
          name: "Wohnzimmer",
          icon: Value(Icons.tv),
          color: Value("#EE964B"),
          sortKey: 1,
          itemsSortOption: RoomItemsSortOption.manual),
      RoomsTableCompanion.insert(
          name: "Malte",
          color: Value("#4062BB"),
          sortKey: 2,
          itemsSortOption: RoomItemsSortOption.byScore),
      RoomsTableCompanion.insert(
          name: "Bad",
          icon: Value(Icons.bathtub),
          color: Value("#00FF00"),
          sortKey: 3,
          itemsSortOption: RoomItemsSortOption.manual),
    ];

    // Eriks Room
    final erikRoom = await roomStore.insertOrUpdateSingleWithId(rooms[0]);

    // living room
    final livingRoom = await roomStore.insertOrUpdateSingleWithId(rooms[1]);

    // Maltes Room
    final malteRoom = await roomStore.insertOrUpdateSingleWithId(rooms[2]);

    // bathRoom
    final bathRoom = await roomStore.insertOrUpdateSingleWithId(rooms[3]);

    final itemsStore = db.itemsStore;
    final items = await itemsStore.inbox().get();

    // create items
    // Erik
    final erikPos3Item = items.firstWhereOrNull((element) => element.ohName == "Erik_pos3");
    if (erikPos3Item != null) {
      await itemsRepository.addItemFromInbox(
          item: erikPos3Item,
          type: ItemType.rollerShutter,
          roomId: erikRoom,
          isFavorite: true);
    }

    final stripeErikBrightnessItem = items.firstWhereOrNull((element) => element.ohName == "stripe_erik_brightness");
    if (stripeErikBrightnessItem != null) {
      await itemsRepository.addItemFromInbox(
          item: stripeErikBrightnessItem,
          type: ItemType.light,
          roomId: erikRoom,
          isFavorite: true);
    }

    final thermostatErikTemperatureItem = items.firstWhereOrNull((element) => element.ohName == "Thermostat_Erik_Temperature");
    if (thermostatErikTemperatureItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermostatErikTemperatureItem,
          type: ItemType.temperature,
          roomId: erikRoom,
          isFavorite: true);
    }

    final thermostatErikActualHumidityItem = items.firstWhereOrNull((element) => element.ohName == "Thermostat_Erik_Actual_Humidity");
    if (thermostatErikActualHumidityItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermostatErikActualHumidityItem,
          type: ItemType.humidity,
          roomId: erikRoom,
          isFavorite: true);
    }

    // Malte
    final erikPos3Item2 = items.firstWhereOrNull((element) => element.ohName == "Erik_pos3");
    if (erikPos3Item2 != null) {
      await itemsRepository.addItemFromInbox(
          item: erikPos3Item2,
          type: ItemType.rollerShutter,
          roomId: malteRoom,
          isFavorite: true);
    }

    final lampeMalteItem = items.firstWhereOrNull((element) => element.ohName == "Lampe_Malte");
    if (lampeMalteItem != null) {
      await itemsRepository.addItemFromInbox(
          item: lampeMalteItem,
          type: ItemType.light,
          roomId: malteRoom,
          isFavorite: true);
    }

    final thermostatMalteTemperatureItem = items.firstWhereOrNull((element) => element.ohName == "Thermostat_Malte_Temperature");
    if (thermostatMalteTemperatureItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermostatMalteTemperatureItem,
          type: ItemType.temperature,
          roomId: malteRoom,
          isFavorite: true);
    }

    final thermostatMalteActualHumidityItem = items.firstWhereOrNull((element) => element.ohName == "Thermostat_Malte_Actual_Humidity");
    if (thermostatMalteActualHumidityItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermostatMalteActualHumidityItem,
          type: ItemType.humidity,
          roomId: malteRoom,
          isFavorite: true);
    }

    // livingRoom
    final thermostatWohnzimmerActualTemperatureItem = items.firstWhereOrNull((element) => element.ohName == "Thermostat_Wohnzimmer_Actual_Temperature");
    if (thermostatWohnzimmerActualTemperatureItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermostatWohnzimmerActualTemperatureItem,
          type: ItemType.temperature,
          roomId: livingRoom,
          isFavorite: true);
    }

    final thermostatWohnzimmerActualHumidityItem = items.firstWhereOrNull((element) => element.ohName == "Thermostat_Wohnzimmer_Actual_Humidity");
    if (thermostatWohnzimmerActualHumidityItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermostatWohnzimmerActualHumidityItem,
          type: ItemType.humidity,
          roomId: livingRoom);
    }

    // Bathroom
    final thermostatBadEgActualHumidityItem = items.firstWhereOrNull((element) => element.ohName == "Thermostat_Bad_EG_Actual_Humidity");
    if (thermostatBadEgActualHumidityItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermostatBadEgActualHumidityItem,
          type: ItemType.humidity,
          roomId: bathRoom,
          isFavorite: true);
    }

    final thermostatBadEgActualTemperatureItem = items.firstWhereOrNull((element) => element.ohName == "Thermostat_Bad_EG_Actual_Temperature");
    if (thermostatBadEgActualTemperatureItem != null) {
      await itemsRepository.addItemFromInbox(
          item: thermostatBadEgActualTemperatureItem,
          type: ItemType.temperature,
          roomId: bathRoom,
          isFavorite: true);
    }

    final fensterSensorBadFensterkontaktItem = items.firstWhereOrNull((element) => element.ohName == "Fenster_Sensor_Bad_Fensterkontakt");
    if (fensterSensorBadFensterkontaktItem != null) {
      await itemsRepository.addItemFromInbox(
          item: fensterSensorBadFensterkontaktItem,
          type: ItemType.windowContact,
          roomId: bathRoom,
          isFavorite: true);
    }
  }
}
