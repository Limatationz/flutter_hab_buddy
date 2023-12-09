import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../locator.dart';

class FavouriteViewModel extends BaseViewModel {
  final _inboxStore = locator<AppDatabase>().inboxStore;

  Stream<int> get countInbox => _inboxStore.count();
}
