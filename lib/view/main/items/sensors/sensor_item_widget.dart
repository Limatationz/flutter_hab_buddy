import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../util/constants.dart';
import '../../../util/general/pill_container.dart';
import '../general/item_state_injector.dart';
import '../general/item_widget_factory.dart';
import 'sensor_item_dialog.dart';

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
    return ItemStateInjector(
        itemName: widget.item.ohName,
        builder: (itemState) {
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
                              padding: const EdgeInsets.only(
                                  right: smallListSpacing),
                              child: Text("${widget.item.label}:",
                                  style: Theme.of(context).textTheme.bodyLarge))
                          : const SizedBox.shrink()),
                  Text(itemState.state,
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ));
        });
  }

  void toggleExpanded() {
    setState(() {
      expanded = !expanded;
    });
  }

  void onLongTap() {
    ItemWidgetFactory.openDialog(
        context,
        SensorItemDialog(
            itemName: widget.item.ohName, colorScheme: widget.colorScheme),
        widget.item,
        widget.colorScheme);
  }
}
