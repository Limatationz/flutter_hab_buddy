import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/database/app_database.dart';
import '../../../../generated/l10n.dart';
import '../../../util/constants.dart';
import '../general/item_widget_factory.dart';

class SwitchItemControl extends StatelessWidget {
  final Item item;
  final ColorScheme colorScheme;

  final OnItemStateChanged onSwitchChanged;
  final dynamic value;
  final double iconSize;
  final bool withIcon;

  const SwitchItemControl(
      {super.key,
      required this.onSwitchChanged,
      required this.value,
      required this.item,
      required this.colorScheme,
      this.iconSize = 45,
      this.withIcon = true});

  @override
  Widget build(BuildContext context) {
    var isOn = false;

    if (value is String) {
      isOn = value == "ON";
    } else if (value is bool) {
      isOn = value;
    }

    return Row(mainAxisSize: MainAxisSize.min, children: [
      ToggleSwitch(
        minWidth: 90.0,
        minHeight: 55.0,
        initialLabelIndex: isOn ? 1 : 0,
        cornerRadius: borderRadiusContainer,
        activeFgColor: colorScheme.onPrimary,
        inactiveBgColor: colorScheme.surfaceContainerHigh,
        inactiveFgColor: colorScheme.onSurface,
        totalSwitches: 2,
        labels: [
          S.of(context).off,
          S.of(context).on,
        ],
        customTextStyles: [
          TextTheme.of(context).titleLarge?.copyWith(
              color: !isOn ? colorScheme.onPrimary : colorScheme.onSurface),
          TextTheme.of(context).titleLarge?.copyWith(
              color: isOn ? colorScheme.onPrimary : colorScheme.onSurface),
        ],
        activeBgColor: [colorScheme.primary, colorScheme.primary],
        animate: true,
        curve: Curves.bounceInOut,
        onToggle: (index) {
          if (index != null) {
            onSwitchChanged(index == 0 ? "OFF" : "ON");
          }
        },
      ),
      if (withIcon) const Gap(extraLargePadding),
      if (withIcon)
        Icon(
          item.icon ?? item.type.icon,
          color: isOn ? colorScheme.primary : Colors.grey,
          size: iconSize,
        )
    ]);
  }
}
