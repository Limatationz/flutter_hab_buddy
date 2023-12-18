import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/items/oh_item_type.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/base_item_dialog.dart';
import 'dimmer/dimmer_item_widget.dart';
import 'edit/item_edit_view.dart';
import 'general/item_widget.dart';
import 'rollershutter/rollershutter_item_widget.dart';
import 'switch/switch_item_widget.dart';
import 'text/text_item_widget.dart';

class ItemWidgetFactory {
  static ItemWidget buildItem(
      {required Item item, required ColorScheme colorScheme}) {
    switch (item.ohType) {
      case OhItemType.button:
        return SwitchItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
      case OhItemType.dimmer:
        return DimmerItemWidget(item: item, colorScheme: colorScheme);
      case OhItemType.rollershutter:
        return RollershutterItemWidget(item: item, colorScheme: colorScheme);
      case OhItemType.string:
      case OhItemType.number:
        return TextItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
      default:
        return TextItemWidget(
          item: item,
          colorScheme: colorScheme,
        );
    }
  }

  static Future<void> openEditSheet(BuildContext context, Item item) {
    return showBarModalBottomSheet<Item>(
        context: context, builder: (context) => ItemEditView(item: item));
  }

  static Future<void> openDialog(
      BuildContext context, Widget child, Item item) async {
    showDialog(
        context: context,
        builder: (_) =>
            Dialog(child: BaseItemDialog(item: item, child: child)));
  }
}
