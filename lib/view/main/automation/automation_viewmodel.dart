import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../generated/l10n.dart';
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

  Future<void> onRuleTriggered(BuildContext context, Rule rule, bool needsConfirm) async {
    final result = await _automationRepository.onRuleTriggered(context, rule, needsConfirm);
    if(result) {
      _snackbarService.showSnackbar(message: S.current.triggered_rule_success, type: SnackbarType.success);
    } else {
      _snackbarService.showSnackbar(message: S.current.triggered_rule_failure, type: SnackbarType.error);
    }
  }
}