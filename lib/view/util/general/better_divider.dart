import 'package:flutter/material.dart';

class BetterDivider extends Divider {
  BetterDivider(
      {super.key,
      required BuildContext context,
      bool padding = true,
      double super.indent = 0})
      : super(
          thickness: 1,
          height: padding ? null : 1,
          color: Theme.of(context).dividerColor,
        );
}

class BetterVerticalDivider extends VerticalDivider {
  BetterVerticalDivider({super.key, required BuildContext context})
      : super(
          thickness: 1,
          color: Theme.of(context).dividerColor,
        );
}

class TimeLineDivider extends VerticalDivider {
  TimeLineDivider({super.key, required BuildContext context})
      : super(
          thickness: 2,
          color: Theme.of(context).colorScheme.inverseSurface,
        );
}
