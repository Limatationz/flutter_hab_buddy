import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../item_widget_factory.dart';

class SwitchItemDialog extends StatefulWidget {
  final String itemName;

  const SwitchItemDialog({super.key, required this.itemName});

  @override
  State<SwitchItemDialog> createState() => _SwitchItemDialogState();
}

class _SwitchItemDialogState extends State<SwitchItemDialog> {
  final _itemRepository = locator<ItemRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Item?>(
        stream: _itemsStore.byName(widget.itemName).watchSingleOrNull(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          final item = snapshot.data!;
          final isOn = item.state == "ON";
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                    child: Text(
                  item.label,
                  style:
                      DynamicTheme.of(context)!.theme.textTheme.headlineMedium,
                )),
                const Gap(listSpacing),
                IconButton(
                    onPressed: () async {
                      ItemWidgetFactory.openEditSheet(context, item);
                    },
                    icon: const Icon(LineIconsFilled.pencil))
              ]),
              const Gap(4),
              Text(item.ohName),
              const Gap(12),
              Align(
                  child: IconButton(
                      onPressed: () => onAction(!isOn),
                      icon: Icon(
                        item.icon ?? item.type.icon,
                        color: isOn
                            ? DynamicTheme.of(context)!
                                .theme
                                .colorScheme
                                .primary
                            : Colors.grey,
                      ),
                      iconSize: 60)),
            ],
          );
        });
  }

  Future<void> onAction(bool on) async {
    await _itemRepository.switchAction(widget.itemName, on);
  }
}
