import 'package:dio/dio.dart';
import '../core/database/app_database.dart';
import '../core/network/converters/inbox.dart';
import '../core/network/generated/client_index.dart';
import '../core/snackbar/snackbar_service.dart';
import '../locator.dart';
import 'login_repository.dart';

class ItemRepository {
  final _loginRepository = locator<LoginRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<OpenHAB>();

  Future<void> switchAction(String itemName, bool on) async {
    final body = on ? "ON" : "OFF";
    return _sendAction(itemName, body);
  }

  Future<void> dimmerAction(String itemName, double value) async {
    return _sendAction(itemName, value.toInt().toString());
  }

  Future<void> _sendAction(String itemName, String body) async {
    final dio = await Dio().post("https://myopenhab.org/rest/items/$itemName",
        data: body,
        options: Options(headers: {
          "Authorization": "${_loginRepository.basicAuth}",
          "Content-Type": "text/plain",
        }));
    if (dio.statusCode != 200) {
      showActionErrorToast();
    }
    getStatusOfItem(itemName);
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

  void showActionErrorToast() {
    _snackbarService.showSnackbar(message: "Error", type: SnackbarType.error);
  }
}
