import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../core/database/app_database.dart';
import '../core/network/converters/inbox.dart';
import '../core/network/generated/client_index.dart';
import '../core/snackbar/snackbar_service.dart';
import '../locator.dart';
import 'login_repository.dart';

class ItemRepository {
  final _loginRepository = locator<LoginRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<OpenHAB>();

  Future<void> fetchData({bool insertToInbox = true}) async {
    final result = await _api.itemsGet();
    if (result.isSuccessful) {
      final storedItems = await _itemsStore.getAll();
      await _inboxStore.deleteData();
      final addToInbox = <InboxEntry>[];

      for (final item in result.body!) {
        if (storedItems
                .firstWhereOrNull((element) => element.ohName == item.name) ==
            null) {
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
          storedItems.removeWhere((element) => element.ohName == item.name);
        }
      }

      // Delete all items that are not available anymore
      for (final item in storedItems) {
        await _itemsStore.deleteDataByName(item.ohName);
      }

      if (insertToInbox) {
        await _inboxStore.insertOrUpdate(addToInbox);
      }
    } else {
      print(result.error);
    }
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

  Future<void> _sendAction(String itemName, String body) async {
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

  Future<void> showActionErrorToast() async {
    await _snackbarService.showSnackbar(
        message: "Error", type: SnackbarType.error);
  }
}
