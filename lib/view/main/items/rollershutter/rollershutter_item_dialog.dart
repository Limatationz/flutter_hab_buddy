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

class RollershutterItemDialog extends StatefulWidget {
  final String itemName;
  final double initialValue;

  const RollershutterItemDialog(
      {super.key, required this.itemName, required this.initialValue});

  @override
  State<RollershutterItemDialog> createState() =>
      _RollershutterItemDialogState();
}

class _RollershutterItemDialogState extends State<RollershutterItemDialog> {
  final _itemRepository = locator<ItemRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Item?>(
        stream: _itemsStore.byName(widget.itemName).watchSingleOrNull(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          final item = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () => onAction("UP"),
                        icon: const Icon(LineIcons.chevron_up)),
                    IconButton(
                        onPressed: () => onAction("STOP"),
                        icon: const Icon(LineIcons.pause)),
                    IconButton(
                        onPressed: () => onAction("DOWN"),
                        icon: const Icon(LineIcons.chevron_down)),
                  ],
                )),
                Expanded(
                    child: IntrinsicHeight(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                      RotatedBox(
                          quarterTurns: 1,
                          child: Slider(
                            value: sliderValue,
                            onChangeEnd: onDragDone,
                            onChanged: (value) {
                              setState(() {
                                sliderValue = value;
                              });
                            },
                            min: item.stateDescription?.minimum ?? 0,
                            max: item.stateDescription?.maximum ?? 100,
                            divisions: item.stateDescription?.step != null
                                ? (item.stateDescription?.maximum ?? 100) ~/
                                    item.stateDescription!.step!
                                : null,
                          )),
                      const Gap(8),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                item.stateDescription?.maximum?.toString() ??
                                    "100",
                                style: DynamicTheme.of(context)!
                                    .theme
                                    .textTheme
                                    .bodyLarge,
                              ),
                              Text(
                                "${(sliderValue).round()}",
                                style: DynamicTheme.of(context)!
                                    .theme
                                    .textTheme
                                    .bodyLarge,
                              ),
                              Text(
                                item.stateDescription?.minimum?.toString() ??
                                    "0",
                                style: DynamicTheme.of(context)!
                                    .theme
                                    .textTheme
                                    .bodyLarge,
                              ),
                            ],
                          ))
                    ])))
              ])
            ],
          );
        });
  }

  Future<void> onAction(String body) async {
    await _itemRepository.rollershutterStringAction(widget.itemName, body);
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(widget.itemName, value);
  }
}
