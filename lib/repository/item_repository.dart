import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:color_models/color_models.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../core/database/app_database.dart';
import '../core/database/items/item_type.dart';
import '../core/database/items/items_table.dart';
import '../core/database/items/oh_item_type.dart';
import '../core/hive/state/item_state.dart';
import '../core/network/converters/item.dart';
import '../core/network/generated/client_index.dart';
import '../core/services/snackbar_service.dart';
import '../locator.dart';
import 'chart_repository.dart';
import 'login_repository.dart';

class ItemRepository {
  final _logger = Logger();
  final _loginRepository = locator<LoginRepository>();
  final _chartRepository = locator<ChartRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _snackbarService = locator<SnackbarService>();

  Stream<DateTime> get clockStream =>
      Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());

  ItemRepository() {
    observeEvents();
  }

  Future<void> fetchData() async {
    await _loginRepository.firstConnectionComplete.future;
    final result = await locator<OpenHAB>().itemsGet();
    if (result.isSuccessful) {
      final List<ItemsTableCompanion> itemsToStore = [];
      final List<(String, ItemState)> itemStatesToInsert = [];
      final List<ItemsTableCompanion> itemsToUpdate = [];
      final List<(String, ItemState)> itemStatesToUpdate = [];
      final List<Item> itemsToDelete = [];

      final storedItems = await _itemsStore.all().get();

      for (final item in result.body!) {
        if (item.name == null){
          _logger.e("Item name is null");
          continue;
        }

        final itemName = item.name!;
        final storedItem = storedItems
            .firstWhereOrNull((element) => element.ohName == item.name);
        if (storedItem == null) {
          // Item is not stored yet
          final dbItem = item.asDatabaseModel();
          if (dbItem != null) {
            itemsToStore.add(dbItem);
          }

          final itemState = item.asItemState();
          if (itemState != null) {
            itemStatesToInsert.add((itemName, itemState));
          }
        } else {
          // Item is already stored -> update
          final update = item.asDatabaseModel();
          if (update != null && !storedItem.equalsDTO(item)) {
            itemsToUpdate.add(update);
          } else {
            // item did not change
          }

          // state update
          final stateUpdate = item.asItemState();
          if (stateUpdate != null) {
            itemStatesToUpdate.add((itemName, stateUpdate));
          }

          // get new chart data if item is readonly
          if (!storedItem.isInInbox &&
              (item.stateDescription?.readOnly ?? false) &&
              item.name != null &&
              storedItem.type != ItemType.complexComponent) {
            _chartRepository.fetchChartDataByName(item.name!);
          }

          storedItems.removeWhere((element) => element.ohName == item.name);
        }
      }

      // Insert new items
      if (itemsToStore.isNotEmpty) {
        await _itemsStore.insertOrUpdate(itemsToStore);
      }

      // Insert new item states
      if (itemStatesToInsert.isNotEmpty) {
        await _itemsStore.insertOrUpdateStates(itemStatesToInsert);
      }

      // Update items
      if (itemsToUpdate.isNotEmpty) {
        await _itemsStore.updateByName(itemsToUpdate);
      }

      // Update item states
      if (itemStatesToUpdate.isNotEmpty) {
        await _itemsStore.updateStatesByName(itemStatesToUpdate);
      }

      // Delete all items that are not available anymore if they are not complex
      if (itemsToDelete.isNotEmpty) {
        final validItems = itemsToDelete
            .where((element) => !ItemType.complexTypes.contains(element.type))
            .toList();
        await _itemsStore
            .deleteDataByNames(validItems.map((e) => e.ohName).toList());
      }
    } else {
      print(result.error);
    }
  }

  Future<void> fetchDataByName(String itemName) async {
    final result =
        await locator<OpenHAB>().itemsItemnameGet(itemname: itemName);
    if (result.isSuccessful && result.body != null) {
      final item = result.body!.asDatabaseModel();
      if (item != null) {
        await _itemsStore.insertOrUpdateSingle(item);
      }
    }
  }

  Future<List<String>> getItemNamesByOhType(OhItemType type) async {
    final items = await _itemsStore.byOhType(type).get();
    return items.map((e) => e.ohName).toList();
  }

  Future<List<Item>> getItemsByTypes(
    List<ItemType> types,
  ) {
    return _itemsStore.byTypes(types).get();
  }

  Future<bool> addItemFromInbox(
      {required Item item,
      required ItemType type,
      required int roomId,
      IconData? icon,
      String? customLabel,
      bool? isFavorite}) async {
    // get item from inbox
    if (!item.isInInbox) {
      // item is no more in inbox
      return false;
    }

    // update item
    final updatedItem = item
        .copyWith(
          type: Value(type),
          roomId: Value(roomId),
          icon: icon != null ? Value(icon) : const Value.absent(),
          customLabel:
              customLabel != null ? Value(customLabel) : const Value.absent(),
          isFavorite: isFavorite ?? false,
        )
        .toCompanion(false);

    // db things
    await _itemsStore.updateByNameSingle(updatedItem);

    // fetch chart data
    _chartRepository.fetchChartDataByName(item.ohName);

    return true;
  }

  Future<bool> addItem(ItemsTableCompanion item) async {
    await _itemsStore.insertOrUpdateSingle(item);
    return true;
  }

  Future<bool> removeItems(List<String> itemNames) async {
    for (final itemName in itemNames) {
      final result = await removeItem(itemName);
      if (!result) {
        return false;
      }
    }

    return true;
  }

  Future<bool> removeItem(String itemName) async {
    final storedItem = await _itemsStore.byName(itemName).getSingleOrNull();
    if (storedItem == null) {
      return false;
    }

    await Future.wait([
      // remove item
      _itemsStore.deleteDataByName(itemName),

      // remove state
      _itemsStore.deleteStateDataByName(itemName),

      // remove chart data
      _chartRepository.deleteChartDataByName(itemName),

      // re add to inbox
      fetchDataByName(itemName),
    ]);

    return true;
  }

  Future<void> dimmerAction(String itemName, double value) async {
    return _sendAction(itemName, value.toInt().toString());
  }

  Future<void> stringAction(String itemName, String value) async {
    return _sendAction(itemName, value.toString());
  }

  Future<void> colorAction(String itemName, HsbColor value) async {
    return _sendAction(
        itemName, "${value.hue},${value.saturation},${value.brightness}");
  }

  Future<void> rollershutterAction(String itemName, bool up) async {
    final body = up ? "UP" : "DOWN";
    return _sendAction(itemName, body);
  }

  Future<void> locationAction(
      String itemName, double latitude, double longitude) async {
    return _sendAction(itemName, "$latitude,$longitude");
  }

  Future<void> _sendAction(String itemName, String body) async {
    // increment score of item
    _itemsStore.incrementScoreByName(itemName);

    try {
      final dio = await Dio().post(
          "${_loginRepository.connectivityManager.baseUrl}/items/$itemName",
          data: body,
          options: Options(headers: {
            ..._loginRepository.basicAuth,
            ..._loginRepository.apiAuth,
            "Content-Type": "text/plain",
          }));
      if (dio.statusCode != 200) {
        showActionErrorToast();
      }
    } catch (e, s) {
      Logger().e(
          "Error on Item Action. Name: $itemName, Body: $body, Error: $e",
          stackTrace: s);
      showActionErrorToast();
    }
  }

  Future<void> getStatusOfItem(String itemName) async {
    final result =
        await locator<OpenHAB>().itemsItemnameGet(itemname: itemName);
    if (result.isSuccessful && result.body != null) {
      final update = result.body!.asDatabaseModel();
      if (update != null) {
        _itemsStore.updateByNameSingle(update);
      }
    }
  }

  Future<String?> fetchStatusOfItem(String itemName) async {
    final result =
        await locator<OpenHAB>().itemsItemnameGet(itemname: itemName);
    if (result.isSuccessful && result.body != null) {
      return result.body!.state;
    }
    return null;
  }

  // TODO!!!!
  Future<void> observeEvents() async {
    await _loginRepository.loginComplete.future;
    _loginRepository.connectivityManager.sseStateStream
        .withLatestFrom(_itemsStore.watchAllOhNames(),
            (event, names) => Tuple2(event, names))
        .listen(
      (tuple) {
        final event = tuple.item1;
        final names = tuple.item2;

        // Alive
        if (event.event == "alive") {
          // just ignore
          return;
        }

        // Message
        if (event.data != null && event.event == "message") {
          final jsonData = json.decode(event.data!);
          final topic = jsonData["topic"] as String;
          final itemName = topic.split("/")[2];
          if (jsonData["type"] == "ItemStateChangedEvent" &&
              names.contains(itemName)) {
            final payload = jsonData["payload"];
            final payloadJson = json.decode(payload);
            final state = payloadJson["value"].toString();
            _itemsStore.updateStateValueByName(itemName, state);
          }
        }
      },
    );
  }

  Future<void> showActionErrorToast() async {
    await _snackbarService.showSnackbar(
        message: "Error", type: SnackbarType.error);
  }

  Future<void> updateFavoriteByName(String name, bool favorite) =>
      _itemsStore.updateFavoriteByName(name, favorite);

  Future<void> insertOrUpdateState(String name, ItemState state) =>
      _itemsStore.insertOrUpdateStateSingle(name, state);
}
