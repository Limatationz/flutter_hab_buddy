
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/favourites/favourites_view_settings.dart';
import '../../../core/database/favourites/favourites_view_settings_store.dart';
import '../../../core/database/items/items_table.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../locator.dart';
import '../../../repository/item_repository.dart';
import '../../../util/color.dart';
import '../items/general/item_widget.dart';
import '../items/general/item_widget_factory.dart';
import '../items/sensors/sensor_item_widget.dart';
import '../rooms/rooms_view.dart';

class FavouriteViewModel extends BaseViewModel {
  final _log = Logger();
  final _settingsStore = locator<FavouriteViewSettingsStore>();
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _itemsRepository = locator<ItemRepository>();

  Stream<int> get countInboxStream => _itemsStore.watchInboxItemsCount();

  Stream<bool> get hasItemsStream => _itemsStore.hasFavorites();

  final BehaviorSubject<Map<int, List<Item>>> _itemsByRoomIdSubject =
      BehaviorSubject.seeded({});

  Stream<Map<int, List<Item>>> get itemsByRoomIdStream =>
      _itemsByRoomIdSubject.stream;

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch();

  FavouriteViewSettings get viewSettings => _settingsStore.settings;

  bool _reorderEnabled = false;

  bool get reorderEnabled => _reorderEnabled;

  FavouriteViewModel() {
    _log.i("FavouriteViewModel created");

    // fetch items
    _itemsStore.watchGroupedByRoomId(onlyFavorites: true).listen((map) {
      final roomScores = map.map((key, value) => MapEntry(
            key,
            value.fold<double>(
                0, (previousValue, element) => previousValue + element.score),
          ));

      // sort by score
      final sortedRoomScores = roomScores.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // get room ids
      final sortedRoomIds = sortedRoomScores.map((e) => e.key).toList();

      // sort items by room id
      final itemsByRoomId = Map.fromEntries(sortedRoomIds.map((roomId) {
        final items = map[roomId]!;
        return MapEntry(roomId, items);
      }));

      // add to subject
      _itemsByRoomIdSubject.add(itemsByRoomId);
    });

    // check if manual sorting is enabled and there is a sort order
    if (_settingsStore.settings.viewType == FavouriteViewType.manual) {
      if (_settingsStore.settings.manualRoomsSortOrder.isEmpty) {
        onSettingsViewTypeChanged(FavouriteViewType.manual, force: true);
        _log.i(
            "Manual View is selected but there is no sort order -> created the default one");
      }
    }
  }

  Future<void> onRefresh() => _itemsRepository.fetchData();

  List<ItemWidget> buildItemWidgets(
          List<Item> items, ColorScheme colorScheme) =>
      items
          .map((e) => ItemWidgetFactory.buildItem(
              item: e, colorScheme: colorScheme, disableTap: reorderEnabled))
          .toList();

  List<SensorItemWidget> buildSensorItemWidgets(
          List<Item> items, ColorScheme colorScheme) =>
      items
          .map((e) => SensorItemWidget(
                item: e,
                colorScheme: colorScheme,
                disableTap: reorderEnabled,
              ))
          .toList();

  Map<int, Tuple2<List<ItemWidget>, List<SensorItemWidget>>>
      buildItemWidgetsByRoomIdForAuto(
              Map<int, List<Item>> itemsByRoomId,
              List<Room> rooms,
              ColorScheme defaultColorScheme,
              Brightness brightness) =>
          itemsByRoomId.map((key, value) {
            final room = rooms.firstWhere((element) => element.id == key);
            final realItems =
                value.where((element) => !element.isSensor).toList();
            final sensorItems =
                value.where((element) => element.isSensor).toList();
            final colorScheme = room.color != null
                ? ColorScheme.fromSeed(
                    seedColor: fromHex(room.color!), brightness: brightness)
                : defaultColorScheme;
            final itemWidgets = buildItemWidgets(realItems, colorScheme);
            final sensorItemWidgets =
                buildSensorItemWidgets(sensorItems, colorScheme);
            return MapEntry(key, Tuple2(itemWidgets, sensorItemWidgets));
          });

  Map<int, Tuple2<List<ItemWidget>, List<SensorItemWidget>>>
      buildItemWidgetsByRoomIdForManual(
          Map<int, List<Item>> itemsByRoomId,
          List<Room> rooms,
          List<FavouriteViewManualSortOrder> manualRoomsSortOrder,
          ColorScheme defaultColorScheme,
          Brightness brightness) {
    try {
      final widgets = itemsByRoomId.map((key, value) {
        final room = rooms.firstWhere((element) => element.id == key);

        final realItems = value.where((element) => !element.isSensor).toList();

        // sort sensors by room id
        final itemsSortOrder = manualRoomsSortOrder
            .firstWhere((element) => element.roomId == key)
            .itemNames;
        realItems.sort((a, b) =>
        itemsSortOrder.indexOf(a.ohName) - itemsSortOrder.indexOf(b.ohName));

        final sensorItems = value.where((element) => element.isSensor).toList();

        // sort items by name
        final sensorsSortOrder = manualRoomsSortOrder
            .firstWhere((element) => element.roomId == key)
            .sensorNames;
        sensorItems.sort((a, b) =>
        sensorsSortOrder.indexOf(a.ohName) -
            sensorsSortOrder.indexOf(b.ohName));

        final colorScheme = room.color != null
            ? ColorScheme.fromSeed(
            seedColor: fromHex(room.color!), brightness: brightness)
            : defaultColorScheme;
        final itemWidgets = buildItemWidgets(realItems, colorScheme);
        final sensorItemWidgets =
        buildSensorItemWidgets(sensorItems, colorScheme);
        return MapEntry(key, Tuple2(itemWidgets, sensorItemWidgets));
      });

      // sort rooms
      final roomsSortOrder = manualRoomsSortOrder.map((e) => e.roomId).toList();
      final sortedRooms =
      Map<int, Tuple2<List<ItemWidget>, List<SensorItemWidget>>>.new();
      for (final roomId in roomsSortOrder) {
        if (widgets.containsKey(roomId)) {
          sortedRooms[roomId] = widgets[roomId]!;
        } else {
          _log.w("Could not find room with id $roomId");
        }
      }

      return sortedRooms;
    } catch (e, s) {
      _log.e("Error on buildItemWidgetsByRoomIdForManual", error: e, stackTrace: s);
      // we switch back to auto mode
      onSettingsViewTypeChanged(FavouriteViewType.auto);
      return {};
    }
  }

  void navigateToRoom(BuildContext context, Room room) {
    context.goNamed(RoomsView.routeName,
        queryParameters: {'roomId': room.id.toString()});
  }

  Future<void> onSettingsViewModeChanged(FavouriteViewMode viewMode) async {
    await _settingsStore.setSettings(viewSettings.copyWith(viewMode: viewMode));
    notifyListeners();
  }

  Future<void> onSettingsViewTypeChanged(FavouriteViewType viewType,
      {bool force = false}) async {
    // check for change from auto to manual
    if (viewSettings.viewType == FavouriteViewType.auto &&
            viewType == FavouriteViewType.manual ||
        (force && viewType == FavouriteViewType.manual)) {
      // we have to set the current order
      final itemsByRoomId = _itemsByRoomIdSubject.valueOrNull;
      final splittedItemsByRoomId = itemsByRoomId?.map((roomId, itemsOfRoom) {
        final sensors = itemsOfRoom
            .where((element) => element.isSensor)
            .map((e) => e.ohName)
            .toList();
        final items = itemsOfRoom
            .where((element) => !element.isSensor)
            .map((e) => e.ohName)
            .toList();
        return MapEntry(roomId, Tuple2(sensors, items));
      });

      if (splittedItemsByRoomId == null) {
        locator<SnackbarService>().showSnackbar(
          message: "Could not save favourite view settings. Please try again.",
          type: SnackbarType.error,
        );
        return;
      } else {
        await _settingsStore.setSettings(
            FavouriteViewSettings.getDefaultManualSettings(
                splittedItemsByRoomId, viewSettings));
      }
    } else {
      await _settingsStore
          .setSettings(FavouriteViewSettings.defaultAutoSettings);
    }
    notifyListeners();
  }

  void toggleReorder() {
    _reorderEnabled = !_reorderEnabled;
    notifyListeners();
  }

  void reorderRooms(int oldIndex, int newIndex) {}

  void reorderSensors(int oldIndex, int newIndex) {}

  Future<void> onReorderRooms(List<String> list) async {
    final parsedList = list
        .map((e) => int.parse(e.replaceAll("[<", "").replaceAll(">]", "")))
        .toList();

    final oldSort = viewSettings.manualRoomsSortOrder;

    // now sort the list
    final newSort = <FavouriteViewManualSortOrder>[];
    for (var i = 0; i < parsedList.length; i++) {
      final roomId = parsedList[i];
      final items =
          oldSort.firstWhere((element) => element.roomId == roomId).itemNames;
      final sensors =
          oldSort.firstWhere((element) => element.roomId == roomId).sensorNames;
      newSort.add(FavouriteViewManualSortOrder(roomId, items, sensors));
    }

    await _settingsStore
        .setSettings(viewSettings.copyWith(manualRoomsSortOrder: newSort));
    notifyListeners();

    // _itemsStore.reorderRooms(parsedList);
  }
}
