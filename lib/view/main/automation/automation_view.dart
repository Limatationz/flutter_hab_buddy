import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/l10n.dart';
import '../../../util/icons/LineIconsV5_icons.dart';
import '../../util/constants.dart';
import '../../util/general/base_elevated_button.dart';
import 'automation_viewmodel.dart';
import 'edit/automation_edit_view.dart';
import 'rule_list_item.dart';

class AutomationView extends StatelessWidget {
  static const String routePath = '/automation';
  static const String routeName = 'AutomationView';

  const AutomationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AutomationViewModel>.reactive(
        viewModelBuilder: () => AutomationViewModel(),
        builder: (context, model, _) =>
            Scaffold(
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
                            return RuleListItem(rule: rule);
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              floatingActionButton: FloatingActionButton(
                  child: Icon(LineIconsV5.plus),
                  onPressed: () {
                    context.pushNamed(AutomationEditView.routeName);
                  }),
            ));
  }
}
