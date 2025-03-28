import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../core/database/items/oh_item_type.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../../../util/general/bar_bottom_sheet.dart';
import '../../../util/general/base_elevated_button.dart';

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
    _itemsStore.nonInbox().get().then((items) => setState(() => this.items = items));
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
      final entries =
          items!.map((item) => ItemSelectEntry(item)).toList(growable: false);
      SuspensionUtil.sortListBySuspensionTag(entries);
      SuspensionUtil.setShowSuspensionStatus(entries);
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
            child: AzListView(
          hapticFeedback: true,
          data: entries,
          itemCount: entries.length,
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
          itemBuilder: (context, index) {
            final item = entries[index];
            return Padding(
                padding: const EdgeInsets.only(right: 26),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(item.label),
                  subtitle: Text(item.name),
                  leading: Icon(item.icon),
                  trailing: selectedItem?.item.ohName == item.item.ohName
                      ? const Icon(LineIconsV5.check)
                      : null,
                  onTap: () {
                    _itemsStore.getByNameWithState(item.name).then(
                          (itemWithState) =>
                              setState(() => selectedItem = itemWithState),
                        );
                  },
                ));
          },
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

class ItemSelectEntry extends ISuspensionBean {
  final Item item;

  String get name => item.ohName;

  String get label => item.label;

  ItemType get type => item.type!;

  IconData get icon => item.icon ?? type.icon;

  ItemSelectEntry(this.item);

  @override
  String getSuspensionTag() => name[0];
}
