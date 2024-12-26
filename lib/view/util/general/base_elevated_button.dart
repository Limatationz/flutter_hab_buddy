import 'package:flutter/material.dart';

import '../platform.dart';

class BaseElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? maxWidth;
  final bool fullWidth;

  const BaseElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.maxWidth,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        width: maxWidth != null
            ? null
            : fullWidth
                ? double.infinity
                : null,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ?? Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
                vertical: isDesktop() ? 14 : 8, horizontal: 16),
            minimumSize: const Size(0, 0),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: onPressed != null
                    ? (textColor ??
                        Theme.of(context).colorScheme.onInverseSurface)
                    : Colors.white),
          ),
        ));
  }
}
