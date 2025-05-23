import 'package:auto_size_text/auto_size_text.dart';
import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../generated/l10n.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/base_alphabet_list_view.dart';
import '../../util/general/headline_padding_box.dart';
import 'add/inbox_entry_add_view.dart';
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
              child: StreamBuilder<List<Item>>(
                stream: model.filteredInbox,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final list = snapshot.data ?? [];
                    final azGroups = getGroups(
                        list,
                        (item) => InboxListItem(
                              entry: item,
                              onTap: () => _onEntryTap(
                                  context, item, model.resetSearch, roomId),
                            ));
                    return BaseAlphabetListView(
                      items: azGroups,
                      scrollController: model.scrollController,
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

  List<AlphabetListViewItemGroup> getGroups(
      List<Item> items, Widget Function(Item item) buildItemWidget) {
    final groups = <String, List<Widget>>{};
    for (final item in items) {
      final alphabet = (item.ohLabel.isEmpty ? item.ohName : item.ohLabel)
          .substring(0, 1)
          .toUpperCase();
      if (!groups.keys.contains(alphabet)) {
        groups[alphabet] = [
          buildItemWidget(item),
        ];
      } else {
        groups[alphabet]!.add(buildItemWidget(item));
      }
    }

    // to az groups
    final azGroups = <AlphabetListViewItemGroup>[];
    for (final group in groups.entries) {
      azGroups.add(AlphabetListViewItemGroup(
        tag: group.key,
        children: group.value,
      ));
    }

    // sort az groups
    azGroups.sort((a, b) => a.tag.compareTo(b.tag));

    return azGroups;
  }

  void _onEntryTap(BuildContext context, Item entry, VoidCallback resetSearch,
      int? roomId) async {
    final result = await Navigator.push<bool>(
        context,
        CupertinoPageRoute(
            builder: (context) => InboxEntryAddView(
                  entry: entry,
                  roomId: roomId,
                )));
    if (result ?? false) {
      resetSearch();
    }
  }
}
