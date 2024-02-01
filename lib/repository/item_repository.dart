import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../core/database/app_database.dart';
import '../core/database/items/item_type.dart';
import '../core/database/items/oh_item_type.dart';
import '../core/network/converters/inbox.dart';
import '../core/network/generated/client_index.dart';
import '../core/services/snackbar_service.dart';
import '../locator.dart';
import 'chart_repository.dart';
import 'login_repository.dart';

class ItemRepository {
  final _loginRepository = locator<LoginRepository>();
  final _chartRepository = locator<ChartRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<OpenHAB>();

  // SSE Connection
  final BehaviorSubject<bool?> _sseConnection = BehaviorSubject.seeded(null);

  Stream<bool?> get sseConnection => _sseConnection.stream;
  final BehaviorSubject<DateTime?> _sseLastConnection =
      BehaviorSubject.seeded(null);

  Stream<DateTime?> get sseLastConnection => _sseLastConnection.stream;

  final BehaviorSubject<DateTime?> _sseLastMessage =
      BehaviorSubject.seeded(null);

  Stream<DateTime?> get sseLastMessage => _sseLastMessage.stream;

  Stream<DateTime> get clockStream =>
      Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());

  ItemRepository() {
    observeEvents();
  }

  Future<void> fetchData({bool insertToInbox = true}) async {
    final result = await _api.itemsGet();
    if (result.isSuccessful) {
      final storedItems = await _itemsStore.all().get();
      if (insertToInbox) {
        await _inboxStore.deleteData();
      }
      final addToInbox = <InboxEntry>[];

      for (final item in result.body!) {
        final storedItem = storedItems
            .firstWhereOrNull((element) => element.ohName == item.name);
        if (storedItem == null) {
          // Item is not stored yet
          final dbItem = item.asDatabaseModel();
          if (dbItem != null && insertToInbox) {
            addToInbox.add(dbItem);
          }
        } else {
          // Item is already stored -> update
          final update = item.asItemUpdate();
          if (update != null) {
            await _itemsStore.updateByName(update);
          }

          // state update
          final stateUpdate = item.asItemStateUpdate();
          if (stateUpdate != null) {
            await _itemsStore.updateStateByName(stateUpdate);
          }

          // get new chart data if item is readonly
          if ((item.stateDescription?.readOnly ?? false) &&
              item.name != null &&
              storedItem.type != ItemType.complexComponent) {
            _chartRepository.fetchChartDataByName(item.name!);
          }

          storedItems.removeWhere((element) => element.ohName == item.name);
        }
      }

      // Delete all items that are not available anymore if they are not complex
      for (final item in storedItems) {
        if (!ItemType.complexTypes.contains(item.type)) {
          await _itemsStore.deleteDataByName(item.ohName);
        }
      }

      if (insertToInbox) {
        await _inboxStore.insertOrUpdate(addToInbox);
      }
    } else {
      print(result.error);
    }
  }

  Future<void> fetchDataByName(String itemName) async {
    final result = await _api.itemsItemnameGet(itemname: itemName);
    if (result.isSuccessful && result.body != null) {
      final item = result.body!.asDatabaseModel();
      if (item != null) {
        await _inboxStore.insertOrUpdateSingle(item);
      }
    }
  }

  Future<List<String>> getItemNamesByOhType(OhItemType type,
      {bool onlyInbox = false}) async {
    final inboxItems = await _inboxStore.byType(type).get();
    if (!onlyInbox) {
      final items = await _itemsStore.byOhType(type).get();
      return [...inboxItems.map((e) => e.name), ...items.map((e) => e.ohName)];
    } else {
      return inboxItems.map((e) => e.name).toList();
    }
  }

  Future<List<Item>> getItemsByTypes(
    List<ItemType> types,
  ) {
    return _itemsStore.byTypes(types).get();
  }

  Future<bool> addItemFromInbox(
      {required String itemName,
      required ItemType type,
      required int roomId,
      IconData? icon,
      String? customLabel,
      bool? isFavorite}) async {
    // get item from inbox
    final inboxItem = await _inboxStore.byName(itemName).getSingleOrNull();
    if (inboxItem == null) {
      return false;
    }

    // create item
    final item = ItemsTableCompanion.insert(
      type: type,
      ohType: inboxItem.type,
      ohName: inboxItem.name,
      ohLabel: inboxItem.label,
      ohCategory: inboxItem.category != null
          ? Value(inboxItem.category!)
          : const Value.absent(),
      ohTags: inboxItem.tags != null
          ? Value(inboxItem.tags!)
          : const Value.absent(),
      ohGroups: inboxItem.groups != null
          ? Value(inboxItem.groups!)
          : const Value.absent(),
      roomId: roomId,
      icon: icon != null ? Value(icon) : const Value.absent(),
      customLabel:
          customLabel != null ? Value(customLabel) : const Value.absent(),
      isFavorite: Value(isFavorite ?? false),
    );

    // create state
    final state = ItemStatesTableCompanion.insert(
      ohName: inboxItem.name,
      state: inboxItem.state,
      stateDescription: inboxItem.stateDescription != null
          ? Value(inboxItem.stateDescription!)
          : const Value.absent(),
      commandDescription: inboxItem.commandDescription != null
          ? Value(inboxItem.commandDescription!)
          : const Value.absent(),
      transformedState: inboxItem.transformedState != null
          ? Value(inboxItem.transformedState!)
          : const Value.absent(),
      ohUnitSymbol: inboxItem.unitSymbol != null
          ? Value(inboxItem.unitSymbol!)
          : const Value.absent(),
    );

    // db things
    await _itemsStore.insertOrUpdateSingle(item);
    await _itemsStore.insertOrUpdateState(state);
    await _inboxStore.deleteDataByName(item.ohName.value);

    // fetch chart data
    _chartRepository.fetchChartDataByName(item.ohName.value);

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

  Future<void> switchAction(String itemName, bool on) async {
    final body = on ? "ON" : "OFF";
    return _sendAction(itemName, body);
  }

  Future<void> dimmerAction(String itemName, double value) async {
    return _sendAction(itemName, value.toInt().toString());
  }

  Future<void> rollershutterAction(String itemName, bool up) async {
    final body = up ? "UP" : "DOWN";
    return _sendAction(itemName, body);
  }

  Future<void> rollershutterStringAction(String itemName, String body) async {
    return _sendAction(itemName, body);
  }

  Future<void> playerStringAction(String itemName, String body) async {
    return _sendAction(itemName, body);
  }

  Future<void> _sendAction(String itemName, String body) async {
    // increment score of item
    _itemsStore.incrementScoreByName(itemName);

    try {
      final dio = await Dio().post("https://myopenhab.org/rest/items/$itemName",
          data: body,
          options: Options(headers: {
            "Authorization": "${_loginRepository.basicAuth}",
            "Content-Type": "text/plain",
          }));
      if (dio.statusCode != 200) {
        showActionErrorToast();
      }
      await fetchData(insertToInbox: false);
    } catch (e, s) {
      Logger().e(
          "Error on Item Action. Name: $itemName, Body: $body, Error: $e",
          stackTrace: s);
      showActionErrorToast();
    }
  }

  Future<void> getStatusOfItem(String itemName) async {
    final result = await _api.itemsItemnameGet(itemname: itemName);
    if (result.isSuccessful && result.body != null) {
      final update = result.body!.asItemUpdate();
      if (update != null) {
        _itemsStore.updateByName(update);
      }
    }
  }

  Future<String?> fetchStatusOfItem(String itemName) async {
    final result = await _api.itemsItemnameGet(itemname: itemName);
    if (result.isSuccessful && result.body != null) {
      return result.body!.state;
    }
    return null;
  }

  // TODO!!!!
  Future<void> observeEvents() async {
    await _loginRepository.loginComplete.future;
    SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: 'https://myopenhab.org/rest/events?topics=*/items/*/statechanged',
      header: {
        "Authorization": "${_loginRepository.basicAuth}",
      },
    )
        .withLatestFrom(_itemsStore.watchAllOhNames(),
            (event, names) => Tuple2(event, names))
        .listen(
      (tuple) {
        // Connection
        if (_sseConnection.value != true) {
          _sseConnection.add(true);
        }
        if (_sseLastConnection.value == null) {
          _sseLastConnection.add(DateTime.now());
        }
        _sseLastMessage.add(DateTime.now());

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

  Future<void> insertOrUpdateState(ItemStatesTableCompanion state) =>
      _itemsStore.insertOrUpdateState(state);
}
