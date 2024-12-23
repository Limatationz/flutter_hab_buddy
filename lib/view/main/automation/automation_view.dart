import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/rules/rules_table.dart';
import '../../../generated/l10n.dart';
import '../../../util/icons/LineIconsV5_icons.dart';
import '../../../util/icons/line_icons_icons.dart';
import '../../util/constants.dart';
import '../../util/general/alert_dialog_action.dart';
import '../../util/general/base_elevated_button.dart';
import 'automation_viewmodel.dart';

class AutomationView extends StatelessWidget {
  static const String routePath = '/automation';
  static const String routeName = 'AutomationView';

  const AutomationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AutomationViewModel>.reactive(
        viewModelBuilder: () => AutomationViewModel(),
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(title: Text(S.current.navigationAutomation)),
              body: StreamBuilder2(
                  streams: StreamTuple2(model.hasApiAccess, model.rules),
                  builder: (context, snapshot) {
                    if (snapshot.snapshot1.hasData &&
                        snapshot.snapshot1.data == false) {
                      // user has no api token set
                      return Center(
                          child: Padding(
                              padding: const EdgeInsets.all(paddingScaffold),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        'Api Token is necessary to use this feature'),
                                    const Gap(extraLargePadding),
                                    BaseElevatedButton(
                                      text: 'Setup Api Token',
                                      maxWidth: 350,
                                      onPressed: () =>
                                          model.addApiSetup(context),
                                    )
                                  ])));
                    } else if (snapshot.snapshot2.hasData &&
                        snapshot.snapshot2.data != null) {
                      if (snapshot.snapshot2.data!.isEmpty) {
                        return const Center(child: Text('No rules available'));
                      }
                      return ListView.builder(
                          itemCount: snapshot.snapshot2.data!.length,
                          padding: const EdgeInsets.all(paddingScaffold),
                          itemBuilder: (context, index) {
                            final rule = snapshot.snapshot2.data![index];
                            return ListTile(
                              title: Text(rule.name ?? 'No name'),
                              subtitle: Text(rule.uid),
                              contentPadding: const EdgeInsets.all(0),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (!rule.fromApp)
                                      const Icon(LineIconsV5.locked_3),
                                    if (!rule.fromApp) const Gap(smallPadding),
                                    GestureDetector(
                                      onLongPress: () {
                                        // This handles the long press.
                                        _onRuleTriggered(
                                            context, rule, model, false);
                                      },
                                      child: IconButton(
                                        onPressed: () {
                                          // This handles the normal tap.
                                          _onRuleTriggered(
                                              context, rule, model, true);
                                        },
                                        icon: const Icon(
                                            LineIconsV5.variantfreeplay),
                                      ),
                                    ),
                                  ]),
                            );
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ));
  }

  Future<void> _onRuleTriggered(BuildContext context, Rule rule,
      AutomationViewModel model, bool needsConfirm) async {
    final confirmed = !needsConfirm
        ? false
        : await showAdaptiveDialog<bool?>(
            context: context,
            builder: (context) => AlertDialog.adaptive(
                  content: Text.rich(TextSpan(children: [
                    TextSpan(text: S.of(context).confirmTriggerRuleAlertText1),
                    TextSpan(
                        text: " ${rule.name ?? rule.uid} ",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: S.of(context).confirmTriggerRuleAlertText2,
                    ),
                  ])),
                  actions: [
                    AlertDialogAction(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(S.of(context).cancel)),
                    AlertDialogAction(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(S.of(context).confirm))
                  ],
                ));
    if (confirmed == true) {
      model.triggerRule(rule.uid);
    }
  }
}
