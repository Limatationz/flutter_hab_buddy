import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/rules/rule_trigger.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../util/constants.dart';
import '../../../util/general/bar_bottom_sheet.dart';
import '../../../util/general/base_elevated_button.dart';
import '../../../util/general/better_divider.dart';
import '../../../util/general/widget_container.dart';
import 'automation_edit_view_arguments.dart';
import 'automation_edit_viewmodel.dart';
import 'form_elements/action/automation_edit_form_element_action_general.dart';
import 'form_elements/trigger/automation_edit_form_element_trigger_general.dart';

// TODO: Condition: only if
// TODO: just look at the rule if user cannot edit -> what if the items are not in the database?
// TODO: add error indicators for triggers/actions/conditions

class AutomationEditView extends StatelessWidget {
  static const routeName = 'AutomationEditView';
  static const routePath = '/automation-edit';

  final AutomationEditViewArguments? args;
  final AutomationEditViewExtraArguments? extra;

  const AutomationEditView({super.key, this.args, this.extra});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AutomationEditViewModel>.reactive(
      viewModelBuilder: () => AutomationEditViewModel(args, extra),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: Text(!model.canEdit
              ? S.of(context).viewRule
              : !model.isNew
                  ? S.of(context).editRule
                  : S.of(context).newRule),
        ),
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(paddingScaffold),
                children: [
                  WidgetContainer(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          S.current.triggers,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                        if (model.triggers?.isNotEmpty ?? false)
                          const Gap(mediumPadding),
                        if (model.triggers?.isNotEmpty ?? false)
                          ReorderableListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              buildDefaultDragHandles: false,
                              proxyDecorator: (child, index, animation) {
                                final trigger = model.triggers![index];

                                return AnimatedBuilder(
                                    animation: animation,
                                    builder: (context, child) {
                                      final double animValue = Curves.easeInOut
                                          .transform(animation.value);
                                      final double elevation =
                                          lerpDouble(0, 6, animValue)!;
                                      return Material(
                                          elevation: elevation,
                                          color: ColorScheme.of(context)
                                              .primaryContainer,
                                          borderRadius: BorderRadius.circular(
                                              smallPadding),
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  smallPadding),
                                              child:
                                                  AutomationEditFormElementTriggerGeneral(
                                                configuration:
                                                    trigger.configuration,
                                                onChanged: (newConfiguration) =>
                                                    model
                                                        .updateTriggerConfigurationAtIndex(
                                                            index,
                                                            newConfiguration),
                                                onDelete: () => model
                                                    .deleteTriggerConfigurationAtIndex(
                                                        index),
                                                enabled: model.canEdit,
                                              )));
                                    });
                              },
                              itemBuilder: (context, index) {
                                final trigger = model.triggers![index];
                                return Column(
                                    key: ValueKey(trigger.hashCode),
                                    children: [
                                      AutomationEditFormElementTriggerGeneral(
                                          listIndex:
                                              (model.triggers?.length ?? 0) > 1
                                                  ? index
                                                  : null,
                                          enabled: model.canEdit,
                                          configuration: trigger.configuration,
                                          onChanged: (newConfiguration) => model
                                              .updateTriggerConfigurationAtIndex(
                                                  index, newConfiguration),
                                          onDelete: () => model
                                              .deleteTriggerConfigurationAtIndex(
                                                  index)),
                                      if (index != model.triggers!.length - 1)
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: smallPadding),
                                            child: Row(children: [
                                              Expanded(
                                                  child: BetterDivider(
                                                      context: context)),
                                              const Gap(mediumPadding),
                                              Text(S.of(context).or,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .dividerColor)),
                                              const Gap(mediumPadding),
                                              Expanded(
                                                  child: BetterDivider(
                                                      context: context))
                                            ]))
                                    ]);
                              },
                              onReorder: model.reorderTriggers,
                              itemCount: model.triggers?.length ?? 0),
                        const Gap(largePadding),
                        if (model.triggers?.isNotEmpty ?? false)
                          const Gap(largePadding),
                        if (model.canEdit)
                          BaseElevatedButton(
                              fullWidth: true,
                              text: S.of(context).addTrigger,
                              onPressed: () {
                                _showAddTriggerSheet(context, model);
                              })
                      ])),
                  const Gap(largePadding),
                  WidgetContainer(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          S.of(context).actions,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                        if (model.actions!.isNotEmpty) const Gap(mediumPadding),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final action = model.actions![index];
                              return AutomationEditFormElementActionGeneral(
                                  action: action,
                                  onChanged: (newAction) {
                                    model.updateAction(index, newAction);
                                  },
                                  onDelete: () => model.deleteAction(index));
                            },
                            separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.only(top: smallPadding),
                                child: Row(children: [
                                  Expanded(
                                      child: BetterDivider(context: context)),
                                  const Gap(mediumPadding),
                                  Text(S.of(context).and,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .dividerColor)),
                                  const Gap(mediumPadding),
                                  Expanded(
                                      child: BetterDivider(context: context))
                                ])),
                            itemCount: model.actions?.length ?? 0),
                        const Gap(largePadding),
                        if (model.actions!.isNotEmpty) const Gap(largePadding),
                        if (model.canEdit)
                          BaseElevatedButton(
                              fullWidth: true,
                              text: S.of(context).addItemAction,
                              onPressed: () {
                                model.addEmptyItemAction();
                              }),
                        if (model.canEdit) const Gap(mediumPadding),
                        if (model.canEdit)
                          BaseElevatedButton(
                              fullWidth: true,
                              text: "Add Script",
                              onPressed: () {
                                model.addEmptyScriptAction();
                              })
                      ])),
                  const Gap(largePadding),
                  WidgetContainer(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          S.of(context).options,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                        const Gap(mediumPadding),
                        FormBuilderTextField(
                            name: "name",
                            enabled: model.canEdit,
                            initialValue: model.initialRule?.name,
                            decoration: InputDecoration(
                              label: Text(S.of(context).ruleName),
                            ),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                model.changeRuleName(newValue);
                              }
                            }),
                        const Gap(mediumPadding),
                        SwitchListTile.adaptive(
                            value: model.options.autoDelete,
                            title: Text(S.of(context).ruleAutoDeleteTitle),
                            subtitle: Text(S.of(context).ruleAutoDeleteHint),
                            contentPadding: EdgeInsets.zero,
                            activeColor: ColorScheme.of(context).primary,
                            onChanged:
                                model.canEdit && model.autoDeleteOptionEnabled
                                    ? (newValue) {
                                        model.changeAutoDeleteOption(newValue);
                                      }
                                    : null),
                      ])),
                  const Gap(largePadding),
                  BaseElevatedButton(
                      onPressed: model.canEdit
                          ? () async {
                              var result = false;
                              if (model.isNew) {
                                result = await model.createRule();
                              } else {
                                result = await model.updateRule();
                              }

                              if (result) {
                                context.pop();
                              }
                            }
                          : null,
                      text: model.isNew ? "Create" : "Update"),
                ],
              ),
      ),
    );
  }

  _showAddTriggerSheet(BuildContext context, AutomationEditViewModel model) {
    showBarModalBottomSheet(
        context: context,
        builder: (context) =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(S.of(context).triggers,
                  style: TextTheme.of(context).headlineSmall),
              const Gap(largePadding),
              ...RuleTriggerType.regularTypes.map((e) => ListTile(
                    title: Text(e.localized),
                    leading: Icon(e.icon),
                    onTap: () {
                      final trigger = e.defaultTrigger(model.itemOpenedBy);
                      if (trigger != null) {
                        model.addTrigger(trigger);
                        context.pop();
                      } else {
                        locator<SnackbarService>().showSnackbar(
                            message: S.of(context).couldNotAddTrigger,
                            type: SnackbarType.error);
                      }
                    },
                  )),
            ]));
  }
}

class AutomationEditViewArguments {
  final String? initialRuleUid;
  final String? itemNameOpenedBy;

  AutomationEditViewArguments({this.initialRuleUid, this.itemNameOpenedBy});
}
