import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../util/constants.dart';
import '../../../util/general/pill_container.dart';
import '../item_widget_factory.dart';
import '../text/text_item_dialog.dart';

class SensorItemWidget extends StatefulWidget {
  final Item item;
  final ColorScheme colorScheme;

  const SensorItemWidget(
      {super.key, required this.item, required this.colorScheme});

  @override
  State<SensorItemWidget> createState() => _SensorItemWidgetState();
}

class _SensorItemWidgetState extends State<SensorItemWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return PillContainer(
        padding: const EdgeInsets.symmetric(
            vertical: paddingPillContainer, horizontal: paddingContainer),
        onTap: toggleExpanded,
        onLongTap: onLongTap,
        colorScheme: widget.colorScheme,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.item.icon ?? widget.item.type.icon, size: 24),
            const Gap(smallListSpacing),
            AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: expanded
                    ? Padding(
                        padding: const EdgeInsets.only(right: smallListSpacing),
                        child: Text("${widget.item.label}:",
                            style: Theme.of(context).textTheme.bodyLarge))
                    : const SizedBox.shrink()),
            Text(widget.item.itemState,
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ));
  }

  void toggleExpanded() {
    setState(() {
      expanded = !expanded;
    });
  }

  void onLongTap() {
    ItemWidgetFactory.openDialog(
        context, TextItemDialog(itemName: widget.item.ohName), widget.item);
  }
}
