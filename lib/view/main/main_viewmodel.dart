import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../repository/automation_repository.dart';
import '../../repository/item_repository.dart';

class MainViewModel extends BaseViewModel {
  final itemsRepository = locator<ItemRepository>();
  final automationsRepository = locator<AutomationRepository>();

  Future<void> fetchData() {
    return Future.wait(
        [itemsRepository.fetchData(), automationsRepository.fetchData()]);
  }
}
