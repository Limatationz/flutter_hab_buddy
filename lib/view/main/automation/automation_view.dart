import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../util/icons/line_icons_icons.dart';
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
              appBar: AppBar(title: const Text('Automation')),
              body: StreamBuilder(
                  stream: model.rules,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: Text('No rules available'));
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final rule = snapshot.data![index];
                            return ListTile(
                              title: Text(rule.name ?? 'No name'),
                              subtitle: Text(rule.uid),
                              trailing:
                                  rule.editable ? null : const Icon(LineIcons.lock),
                            );
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ));
  }
}
