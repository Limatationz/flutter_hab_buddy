import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../repository/item_repository.dart';

class MainViewModel extends BaseViewModel {
  final itemsRepository = locator<ItemRepository>();

  Future<void> fetchData() => itemsRepository.fetchData();
}
