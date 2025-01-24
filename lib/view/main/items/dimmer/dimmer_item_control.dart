import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/state/item_states_table.dart';
import '../../../../generated/l10n.dart';
import '../../../util/constants.dart';
import '../general/item_widget_factory.dart';
import '../switch/switch_item_control.dart';

class DimmerItemControl extends StatefulWidget {
  final OnItemStateChanged? onDimmerChanged;
  final ItemState itemState;
  final Item item;
  final ColorScheme colorScheme;
  final num initialValue;

  const DimmerItemControl(
      {super.key,
      this.onDimmerChanged,
      required this.itemState,
      required this.colorScheme,
      required this.initialValue,
      required this.item});

  @override
  _DimmerItemControlState createState() => _DimmerItemControlState();
}

class _DimmerItemControlState extends State<DimmerItemControl> {
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SwitchItemControl(
          onSwitchChanged: widget.onDimmerChanged,
          value: sliderValue > 0,
          item: widget.item,
          colorScheme: widget.colorScheme),
      const Gap(largePadding),
      Column(children: [
        Slider(
          value: sliderValue,
          onChangeEnd:
              !widget.itemState.isReadOnly ? widget.onDimmerChanged : null,
          onChanged: !widget.itemState.isReadOnly
              ? (newValue) {
                  setState(() {
                    sliderValue = newValue;
                  });
                }
              : null,
          min: widget.itemState.stateDescription?.minimum ?? 0,
          max: widget.itemState.stateDescription?.maximum ?? 100,
          divisions: widget.itemState.stateDescription?.step != null
              ? (widget.itemState.stateDescription?.maximum ?? 100) ~/
                  widget.itemState.stateDescription!.step!
              : null,
          activeColor: widget.colorScheme.primary,
          inactiveColor: widget.colorScheme.primary.withValues(alpha: 0.24),
        ),
        const Gap(smallPadding),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Text(
                    widget.itemState.stateDescription?.minimum
                            ?.round()
                            .toString() ??
                        "0",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    S.of(context).sliderMinHint,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ]),
                Column(children: [
                  Text(
                    "${(sliderValue).round()}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    S.of(context).sliderCurrentHint,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ]),
                Column(children: [
                  Text(
                    widget.itemState.stateDescription?.maximum
                            ?.round()
                            .toString() ??
                        "100",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    S.of(context).sliderMaxHint,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ]),
              ],
            ))
      ])
    ]);
  }
}
