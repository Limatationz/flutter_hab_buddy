import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/routing/navigation_service.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../locator.dart';
import '../../../repository/automation_repository.dart';
import '../../../repository/login_repository.dart';
import '../../login/login_api_setup_view.dart';

class AutomationViewModel extends BaseViewModel {
  final _automationRepository = locator<AutomationRepository>();
  final _loginRepository = locator<LoginRepository>();
  final _snackbarService = locator<SnackbarService>();

  Stream<List<Rule>> get rules => _automationRepository.rules;

  Stream<bool> get hasApiAccess => _loginRepository.hasApiAccessStream;

  Future<void> addApiSetup(BuildContext context) async {
    final result = await context.pushNamed(LoginApiSetupView.routeName, queryParameters: {'type': "fromSettings"});
    _automationRepository.fetchData();
  }

  Future<void> triggerRule(String ruleId) async {
    final result = await _automationRepository.triggerRule(ruleId);
    if(result) {
      _snackbarService.showSnackbar(message: "Successfully triggered the rule", type: SnackbarType.success);
    } else {
      _snackbarService.showSnackbar(message: "Failed to trigger the rule", type: SnackbarType.error);
    }
  }
}