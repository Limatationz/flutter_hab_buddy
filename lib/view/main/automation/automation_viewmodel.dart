import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/routing/navigation_service.dart';
import '../../../locator.dart';
import '../../../repository/automation_repository.dart';

class AutomationViewModel extends BaseViewModel {
  final _automationRepository = locator<AutomationRepository>();

  Stream<List<Rule>> get rules => _automationRepository.rules;
}