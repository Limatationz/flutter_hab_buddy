import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../../../util/general/bar_bottom_sheet.dart';
import '../../../util/general/base_alphabet_list_view.dart';
import '../../../util/general/base_elevated_button.dart';

// TODO: add search

typedef ItemSelectCallback = void Function(Item? item);
typedef ItemWithStateSelectCallback = void Function(
    ItemWithState? itemWithState);

class ItemSelectView extends StatefulWidget {
  final ItemSelectCallback? onItemSelect;
  final ItemWithStateSelectCallback? onItemWithStateSelect;
  final Item? initialSelected;

  const ItemSelectView(
      {super.key,
      this.onItemSelect,
      this.onItemWithStateSelect,
      this.initialSelected})
      : assert(onItemSelect != null || onItemWithStateSelect != null);

  @override
  State<ItemSelectView> createState() => _ItemSelectViewState();

  static Future<void> showSheet(
    BuildContext context, {
    ItemSelectCallback? onItemSelect,
    ItemWithStateSelectCallback? onItemWithStateSelect,
  }) {
    if (onItemSelect == null && onItemWithStateSelect == null) {
      throw ArgumentError(
          'Either onItemSelect or onItemWithStateSelect must be provided');
    } else if (onItemSelect != null && onItemWithStateSelect != null) {
      throw ArgumentError(
        'Only one of onItemSelect or onItemWithStateSelect can be provided',
      );
    }

    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) {
        return ItemSelectView(
          onItemSelect: onItemSelect != null
              ? (item) {
                  onItemSelect.call(item);
                  Navigator.of(context).pop();
                }
              : null,
          onItemWithStateSelect: onItemWithStateSelect != null
              ? (itemWithState) {
                  onItemWithStateSelect.call(itemWithState);
                  Navigator.of(context).pop();
                }
              : null,
        );
      },
    );
  }
}

class _ItemSelectViewState extends State<ItemSelectView> {
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final textEditingController = TextEditingController();
  final searchFocusNode = FocusNode();

  ItemWithState? selectedItem;
  List<Item>? items;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelected != null) {
      _itemsStore.getByNameWithState(widget.initialSelected!.ohName).then(
            (itemWithState) => setState(() => selectedItem = itemWithState),
          );
    }
    _itemsStore
        .nonInbox()
        .get()
        .then((items) => setState(() => this.items = items));
  }

  @override
  Widget build(BuildContext context) {
    if (items == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (items!.isEmpty) {
      return Center(
          child: Text(
        S.of(context).addAnItemFirst,
      ));
    } else {
      final entries = getGroups(
          items!,
          (item) => ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(item.label),
                subtitle: Text(item.ohName),
                leading: Icon(item.icon),
                trailing: selectedItem?.item.ohName == item.ohName
                    ? const Icon(LineIconsV5.check)
                    : null,
                onTap: () {
                  _itemsStore.getByNameWithState(item.ohName).then(
                        (itemWithState) =>
                            setState(() => selectedItem = itemWithState),
                      );
                },
              ));
      return Column(children: [
        TextField(
          controller: textEditingController,
          focusNode: searchFocusNode,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            labelText: S.of(context).search,
            suffix: IconButton(
                onPressed: () {
                  textEditingController.clear();
                },
                iconSize: 18,
                visualDensity: VisualDensity.compact,
                icon: const Icon(LineIconsV5.xmark)),
          ),
        ),
        const Gap(mediumPadding),
        Expanded(
            child: BaseAlphabetListView(
          items: entries,
        )),
        const Gap(largePadding),
        BaseElevatedButton(
          text: selectedItem != null
              ? S.of(context).select
              : S.of(context).cancel,
          fullWidth: true,
          onPressed: () {
            widget.onItemSelect?.call(selectedItem?.item);
            widget.onItemWithStateSelect?.call(selectedItem);
          },
        ),
      ]);
    }
  }
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
