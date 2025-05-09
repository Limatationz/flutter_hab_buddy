import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../repository/automation_repository.dart';

class AutomationsByItemViewModel extends BaseViewModel {
  final _automationRepository = locator<AutomationRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _snackbarService = locator<SnackbarService>();

  final String itemName;

  Stream<List<Rule>> get rules => _automationRepository.rulesForItemNameStream(itemName);
  Item? item;

  AutomationsByItemViewModel(this.itemName) {
    _itemsStore.byName(itemName).watchSingleOrNull().listen((item) {
      this.item = item;
      notifyListeners();
    });
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