import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/rules/rules_table.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../repository/automation_repository.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';

class RuleListItem extends StatelessWidget {
  final _snackbarService = locator<SnackbarService>();
  final _automationRepository = locator<AutomationRepository>();

  final Rule rule;

  RuleListItem({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(rule.name ?? 'No name'),
      subtitle: SelectableText(rule.uid),
      contentPadding: const EdgeInsets.all(0),
      leading: rule.triggerType != null ? Icon(rule.triggerType!.icon) : null,
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        if (!rule.fromApp) const Icon(LineIconsV5.locked_3),
        if (!rule.fromApp) const Gap(smallPadding),
        PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    onTap: () => _onRuleDelete(context, rule),
                    child: Row(children: [
                      const Icon(LineIconsV5.trash_1),
                      const Gap(smallPadding),
                      Text(S.of(context).delete)
                    ]),
                  ),
                  PopupMenuItem(
                    value: 'run',
                    onTap: () => _onRuleTriggered(context, rule),
                    child: Row(children: [
                      const Icon(LineIconsV5.play),
                      const Gap(smallPadding),
                      Text(S.of(context).run)
                    ]),
                  )
                ]),
      ]),
    );
  }

  Future<void> _onRuleTriggered(BuildContext context, Rule rule) async {
    final result =
        await _automationRepository.onRuleTriggered(context, rule, true);
    if (result) {
      _snackbarService.showSnackbar(
          message: S.current.triggered_rule_success,
          type: SnackbarType.success);
    } else {
      _snackbarService.showSnackbar(
          message: S.current.triggered_rule_failure, type: SnackbarType.error);
    }
  }

  Future<void> _onRuleDelete(BuildContext context, Rule rule) async {
    final result =
        await _automationRepository.onRuleDelete(context, rule, true);
    if (result) {
      _snackbarService.showSnackbar(
          message: S.current.deletedRuleSuccess, type: SnackbarType.success);
    } else {
      _snackbarService.showSnackbar(
          message: S.current.deletedRuleFailure, type: SnackbarType.error);
    }
  }
}
