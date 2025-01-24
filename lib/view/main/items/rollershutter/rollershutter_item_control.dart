import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/state/item_states_table.dart';
import '../../../../generated/l10n.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../general/item_widget_factory.dart';

class RollershutterItemControl extends StatefulWidget {
  final OnItemStateChanged? onRollershutterChanged;
  final ItemState itemState;
  final ColorScheme colorScheme;
  final double initialValue;

  const RollershutterItemControl(
      {super.key,
       this.onRollershutterChanged,
      required this.itemState,
      required this.colorScheme,
      required this.initialValue});

  @override
  State<RollershutterItemControl> createState() =>
      _RollershutterItemControlState();
}

class _RollershutterItemControlState extends State<RollershutterItemControl> {
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Column(
        children: [
          IconButton(
              onPressed: !widget.itemState.isReadOnly
                  ? () => widget.onRollershutterChanged?.call("UP")
                  : null,
              color: widget.colorScheme.primary,
              tooltip: S.of(context).up,
              icon: const Icon(
                LineIconsV5.chevron_up,
                size: 36,
              )),
          IconButton(
              onPressed: !widget.itemState.isReadOnly
                  ? () => widget.onRollershutterChanged?.call("STOP")
                  : null,
              tooltip: S.of(context).stop,
              color: widget.colorScheme.primary,
              icon: const Icon(LineIconsV5.pause, size: 36)),
          IconButton(
              color: widget.colorScheme.primary,
              onPressed: !widget.itemState.isReadOnly
                  ? () => widget.onRollershutterChanged?.call("DOWN")
                  : null,
              tooltip: S.of(context).down,
              icon: const Icon(LineIconsV5.chevron_down, size: 36)),
        ],
      )),
      Expanded(
          child: IntrinsicHeight(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        RotatedBox(
            quarterTurns: 1,
            child: Slider(
              value: sliderValue,
              onChangeEnd: !widget.itemState.isReadOnly
                  ? widget.onRollershutterChanged
                  : null,
              onChanged: !widget.itemState.isReadOnly
                  ? (value) {
                      setState(() {
                        sliderValue = value;
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
            )),
        const Gap(smallPadding),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
              ],
            ))
      ])))
    ]);
  }
}
