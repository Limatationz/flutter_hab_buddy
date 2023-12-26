
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../../util/icons/icons.dart';
import '../general/item_state_injector.dart';

class RollerShutterItemDialog extends StatefulWidget {
  final String itemName;
  final double initialValue;
  final ColorScheme colorScheme;

  const RollerShutterItemDialog(
      {super.key,
      required this.itemName,
      required this.initialValue,
      required this.colorScheme});

  @override
  State<RollerShutterItemDialog> createState() =>
      _RollerShutterItemDialogState();
}

class _RollerShutterItemDialogState extends State<RollerShutterItemDialog> {
  final _itemRepository = locator<ItemRepository>();
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: widget.itemName,
        builder: (itemState) {
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
                            min: itemState.stateDescription?.minimum ?? 0,
                            max: itemState.stateDescription?.maximum ?? 100,
                            divisions: itemState.stateDescription?.step != null
                                ? (itemState.stateDescription?.maximum ??
                                        100) ~/
                                    itemState.stateDescription!.step!
                                : null,
                            activeColor: widget.colorScheme.primary,
                            inactiveColor:
                                widget.colorScheme.primary.withOpacity(0.24),
                          )),
                      const Gap(8),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                itemState.stateDescription?.maximum
                                        ?.round()
                                        .toString() ??
                                    "100",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge,
                              ),
                              Text(
                                "${(sliderValue).round()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge,
                              ),
                              Text(
                                itemState.stateDescription?.minimum
                                        ?.round()
                                        .toString() ??
                                    "0",
                                style: Theme.of(context)
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
