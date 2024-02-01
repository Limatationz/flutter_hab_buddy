import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/item_type.dart';
import '../../../core/services/wakelock_service.dart';
import '../../../locator.dart';
import '../../../main.dart';
import '../../../repository/item_repository.dart';
import '../../../repository/login_repository.dart';
import '../../login/login_view.dart';

class SettingsViewModel extends BaseViewModel {
  final _db = locator<AppDatabase>();
  final _itemsRepository = locator<ItemRepository>();
  final _loginRepository = locator<LoginRepository>();
  final wakelockService = locator<WakelockService>();

  Stream<bool> get connectionStatus =>
      _itemsRepository.sseConnection.map((event) => event ?? false);

  Stream<DateTime?> get lastConnectionStart =>
      _itemsRepository.sseLastConnection;

  Stream<DateTime?> get lastUpdate => _itemsRepository.sseLastMessage;

  int getThemeIndex(BuildContext context) {
    return AdaptiveTheme.of(context).mode.index;
  }

  void setTheme(BuildContext context, int index) {
    AdaptiveTheme.of(context).setThemeMode(AdaptiveThemeMode.values[index]);
    final theme = AdaptiveTheme.of(context).theme;
    setSystemOverlay(theme);
  }

  Future<void> logout(BuildContext context) async {
    await _db.deleteAllData();
    await _loginRepository.logout();
    context.goNamed(LoginView.routeName);
  }

  Future<void> clearDatabase() async {
    await _db.deleteAllData();
    await _itemsRepository.fetchData();
  }

  Future<void> insertDummyData() async {
    // create rooms
    final roomStore = _db.roomsStore;

    final rooms = [
      RoomsTableCompanion.insert(name: "Schlafzimmer", icon: Value(Icons.bed)),
      RoomsTableCompanion.insert(name: "Küche", icon: Value(Icons.kitchen)),
      RoomsTableCompanion.insert(name: "Flur", color: Value("#FF0000")),
      RoomsTableCompanion.insert(
          name: "Bad", icon: Value(Icons.bathtub), color: Value("#00FF00")),
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
    if (inboxItemNames.contains("Lampe_Wohnzimmer_Helligkeit")) {
      await _itemsRepository.addItemFromInbox(
          itemName: "Lampe_Wohnzimmer_Helligkeit",
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

    await _itemsRepository.fetchData();
  }
}
