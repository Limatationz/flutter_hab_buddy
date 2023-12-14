import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/inbox/inbox_table.dart';
import '../../util/constants.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/base_item_dialog.dart';
import 'dimmer/dimmer_item_widget.dart';
import 'edit/item_edit_view.dart';
import 'rollershutter/rollershutter_item_widget.dart';
import 'switch/switch_item_widget.dart';
import 'text/text_item_widget.dart';

class ItemWidgetFactory extends StatelessWidget {
  final Item item;
  final double parentWidth;

  const ItemWidgetFactory(
      {super.key, required this.item, required this.parentWidth});

  @override
  Widget build(BuildContext context) {
    switch (item.ohType) {
      case InboxEntryType.button:
        return SwitchItemWidget(
          item: item,
          width: widthSmallWidget,
        );
      case InboxEntryType.dimmer:
        return DimmerItemWidget(item: item, width: widthSmallWidget);
      case InboxEntryType.rollershutter:
        return RollershutterItemWidget(item: item, width: widthSmallWidget);
      case InboxEntryType.string:
      case InboxEntryType.number:
        return TextItemWidget(item: item, width: widthSmallWidget);
      default:
        return Text(item.ohName);
    }
  }

  double get widthSmallWidget {
    final rows = (parentWidth / smallWidgetMaxWidthBreakpoint).ceil();
    return (parentWidth / rows) - ((listSpacing / 2) * ((rows - 1)));
  }

  static Future<void> openEditSheet(BuildContext context, Item item) {
    return showBarModalBottomSheet<Item>(
        context: context, builder: (context) => ItemEditView(item: item));
  }

  static Future<void> openDialog(
      BuildContext context, Widget child, Item item) async {
    showDialog(
        context: context,
        builder: (_) => Dialog(child: BaseItemDialog(item: item,
        child: child)));
  }
}
