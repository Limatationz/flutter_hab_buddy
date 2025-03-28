import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
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

  final int? roomId;

  const InboxView({super.key, this.roomId});

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
                        icon: const Icon(LineIconsV5.xmark))
                  ],
                )),
            const HeadlinePaddingBox(),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: paddingScaffold),
                child: TextField(
                  controller: model.textEditingController,
                  focusNode: model.searchFocusNode,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    labelText: S.of(context).search,
                    suffix: IconButton(
                        onPressed: () {
                          model.textEditingController.clear();
                        },
                        iconSize: 18,
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(LineIconsV5.xmark)),
                  ),
                )),
            const Gap(mediumPadding),
            Expanded(
              child: StreamBuilder<List<InboxItemEntry>>(
                stream: model.filteredInbox,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final list = snapshot.data ?? [];
                    SuspensionUtil.sortListBySuspensionTag(list);
                    SuspensionUtil.setShowSuspensionStatus(list);
                    return AzListView(
                      data: list,
                      padding: const EdgeInsets.fromLTRB(
                          paddingScaffold, 0, paddingScaffold, paddingScaffold),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final entry = snapshot.data![index].entry;
                        return InboxListItem(
                          entry: entry,
                          onTap: () => _onEntryTap(
                              context, entry, model.resetSearch, roomId),
                        );
                      },
                      hapticFeedback: true,
                      indexBarMargin: const EdgeInsets.only(right: 8),
                      indexBarOptions: IndexBarOptions(
                        downColor: Colors.green,
                        textStyle: TextTheme.of(context).bodyMedium!,
                        indexHintDecoration: BoxDecoration(
                          color: ColorScheme.of(context).secondaryContainer,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(borderRadiusContainer)),
                        ),
                        indexHintTextStyle: TextStyle(
                          fontSize: 24,
                          color: ColorScheme.of(context).onSecondaryContainer,
                        ),
                      ),
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

  void _onEntryTap(BuildContext context, Item entry,
      VoidCallback resetSearch, int? roomId) async {
    final result = await showBarModalBottomSheet<bool>(
        context: context,
        builder: (context) => InboxEntryAddSheet(
              entry: entry,
              roomId: roomId,
            ));
    if (result ?? false) {
      resetSearch();
    }
  }
}
