import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/inbox/inbox_list_entry.dart';
import '../../../generated/l10n.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/headline_padding_box.dart';
import 'add/inbox_entry_add_sheet.dart';
import 'inbox_list_item.dart';
import 'inbox_viewmodel.dart';

class InboxView extends StatelessWidget {
  static const routeName = 'InboxView';
  static const routePath = '/inbox';

  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InboxViewModel>.reactive(
      viewModelBuilder: () => InboxViewModel(),
      builder: (context, model, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(
                    paddingScaffold, paddingScaffold, paddingScaffold, 0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(S.current.navigationInbox,
                            style: Theme.of(context).textTheme.headlineMedium)),
                    const Gap(12),
                    IconButton.filled(
                        iconSize: 18,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(LineIcons.close))
                  ],
                )),
            const HeadlinePaddingBox(),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: paddingScaffold),
                child: Autocomplete<InboxEntry>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text == '') {
                    return const Iterable<InboxEntry>.empty();
                  }
                  return model.autoComplete(textEditingValue.text);
                }, onSelected: (InboxEntry selection) {
                  _onEntryTap(context, selection);
                }, fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onSubmitted: (String value) {
                      onFieldSubmitted();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      labelText: S.of(context).search,
                      suffix: IconButton(
                          onPressed: () {
                            textEditingController.clear();
                          },
                          iconSize: 18,
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(LineIcons.close)),
                    ),
                  );
                }, optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<InboxEntry> onSelected,
                        Iterable<InboxEntry> options) {
                  return Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: paddingScaffold * 2),
                        child: Material(
                          elevation: 4.0,
                          color: DynamicTheme.of(context)!
                              .theme
                              .colorScheme
                              .surfaceVariant,
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final InboxEntry option =
                                    options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: InboxListItem(entry: option),
                                );
                              },
                            ),
                          ),
                        ),
                      ));
                }, displayStringForOption: (InboxEntry option) {
                  return option.label;
                })),
            const Gap(12),
            Expanded(
              child: StreamBuilder<List<InboxListEntry>>(
                stream: model.inbox,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final list = snapshot.data ?? [];
                    SuspensionUtil.sortListBySuspensionTag(list);
                    SuspensionUtil.setShowSuspensionStatus(list);
                    return AzListView(
                      data: list,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingScaffold),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final entry = snapshot.data![index].entry;
                        return InboxListItem(
                          entry: entry,
                          onTap: () => _onEntryTap(context, entry),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _onEntryTap(BuildContext context, InboxEntry entry) {
    showBarModalBottomSheet(
        context: context,
        builder: (context) => InboxEntryAddSheet(entry: entry));
  }
}
