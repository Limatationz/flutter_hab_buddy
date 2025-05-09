import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../core/database/rules/rule_trigger.dart';
import '../../../../generated/l10n.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../edit/automation_edit_view.dart';
import '../edit/automation_edit_view_arguments.dart';
import '../rule_list_item.dart';
import 'automations_by_item_viewmodel.dart';

class AutomationsByItemView extends StatelessWidget {
  static const String routePath = '/item/:itemName/automations';
  static const String routeName = 'AutomationsByItemView';

  final String itemName;

  AutomationsByItemView({super.key, required this.itemName});

  final _expandableFabKey = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AutomationsByItemViewModel>.reactive(
      viewModelBuilder: () => AutomationsByItemViewModel(itemName),
      builder: (context, model, child) => Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    expandedHeight: 140, // Adjust height as needed
                    pinned: true,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate whether the app bar is collapsed
                        final isCollapsed =
                            constraints.maxHeight <= kToolbarHeight;

                        return FlexibleSpaceBar(
                          title: Visibility(
                              maintainState: true,
                              maintainSize: true,
                              maintainAnimation: true,
                              visible: isCollapsed,
                              child: Text(
                                model.item != null
                                    ? S.current
                                        .automationsWith(model.item!.label)
                                    : S.current
                                        .automations, // Only title when collapsed
                              )),
                          background: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S
                                      .of(context)
                                      .automations, // Title in expanded state
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Builder(builder: (context) {
                                  if (model.item != null) {
                                    return Text(
                                      model.item!.label,
                                      // Subtitle in expanded state
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                })
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
            body: StreamBuilder(
                stream: model.rules,
                builder: (context, snapshot) => snapshot.data?.isNotEmpty ??
                        false
                    ? ListView(
                        padding: const EdgeInsets.all(paddingScaffold),
                        children: [
                            ...snapshot.data!.map((rule) =>
                RuleListItem(rule: rule)),
                          ])
                    : Center(child: Text(S.of(context).noRulesFound)))),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
            key: _expandableFabKey,
            type: ExpandableFabType.up,
            childrenAnimation: ExpandableFabAnimation.none,
            distance: 70,
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(LineIconsV5.plus),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              foregroundColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            closeButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(LineIconsV5.xmark),
              fabSize: ExpandableFabSize.small,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              foregroundColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            children: RuleTriggerType.regularTypes
                .map((e) => GestureDetector(
                      onTap: () {
                        _handleOnAddAutomationTap(context, e, model.item);
                      },
                      child: Row(
                        children: [
                          Text(e.localized),
                          const Gap(largePadding),
                          FloatingActionButton.small(
                            heroTag: null,
                            onPressed: null,
                            child: Icon(e.icon),
                          ),
                        ],
                      ),
                    ))
                .toList()),
      ),
    );
  }

  Future<void> _handleOnAddAutomationTap(
      BuildContext context, RuleTriggerType type, Item? item) async {
    final initialTrigger = type.defaultTrigger(item);
    await context.pushNamed(AutomationEditView.routeName,
        queryParameters: {"itemNameOpenedBy": itemName},
        extra: AutomationEditViewExtraArguments(
            initialTriggers: initialTrigger != null ? [initialTrigger] : null));
  }
}
