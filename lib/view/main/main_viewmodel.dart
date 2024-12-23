import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../repository/automation_repository.dart';
import '../../repository/item_repository.dart';
import '../../repository/login_repository.dart';

class MainViewModel extends BaseViewModel {
  final _itemsRepository = locator<ItemRepository>();
  final _automationsRepository = locator<AutomationRepository>();

  Future<void> fetchData() {
    return Future.wait(
        [_itemsRepository.fetchData(), _automationsRepository.fetchData()]);
  }
}
