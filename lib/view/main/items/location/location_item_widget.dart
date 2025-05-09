import 'package:flutter/material.dart';

import '../../../../core/database/items/items_table.dart';
import '../../../util/constants.dart';
import '../../../util/general/widget_container.dart';
import '../general/item_state_injector.dart';
import '../general/item_widget.dart';
import '../general/item_widget_factory.dart';
import 'location_item_dialog.dart';
import 'location_util.dart';
import 'openhab_map_widget.dart';

class LocationItemWidget extends MediumItemWidget {
  final bool disableTap;
  LocationItemWidget(
      {super.key, required super.item, required super.colorScheme, this.disableTap = false})
      : assert(item != null);

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: item!.ohName,
        builder: (state) {
          final location =
              OpenhabLocation.fromItemState(state.state, item!.label, false);
          return WidgetContainer(
              key: ValueKey(location.hashCode),
              onLongTap: () => onLongTap(context, location),
              padding: const EdgeInsets.all(0),
              colorScheme: colorScheme,
              disableTap: disableTap,
              child: AbsorbPointer(
                  child: OpenhabMapWidget(
                location: location,
                colorScheme: colorScheme,
                popupBuilder: (context, marker) => Container(
                  padding: const EdgeInsets.all(smallPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(smallPadding),
                    color: colorScheme.surface,
                  ),
                  child: Text(location.itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: colorScheme.onSurface)),
                ),
              )));
        });
  }

  void onLongTap(BuildContext context, OpenhabLocation value) =>
      ItemWidgetFactory.openDialog(
          context,
          LocationItemDialog(
              itemName: item!.ohName,
              initialValue: value,
              colorScheme: colorScheme),
          item!,
          colorScheme);
}
