import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class WidgetContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final double elevation;
  final Color? backgroundColor;
  final double? width;

  const WidgetContainer(
      {super.key,
      required this.child,
      this.padding,
      this.margin = const EdgeInsets.all(0),
      this.onTap,
      this.onLongTap,
      this.elevation = 2,
      this.backgroundColor,
      this.width});

  @override
  Widget build(BuildContext context) {
    final widget = Material(
        elevation: elevation,
        borderRadius:
            const BorderRadius.all(Radius.circular(borderRadiusContainer)),
        child: ClipRRect(
            borderRadius:
                const BorderRadius.all(Radius.circular(borderRadiusContainer)),
            child: Container(
                width: width,
                key: key,
                decoration: BoxDecoration(
                  color: backgroundColor ??
                      ElevationOverlay.applySurfaceTint(
                          DynamicTheme.of(context)!
                              .theme
                              .colorScheme
                              .background,
                          DynamicTheme.of(context)!
                              .theme
                              .colorScheme
                              .surfaceTint,
                          1),
                ),
                padding: padding,
                child: child)));
    if (onTap != null || onLongTap != null) {
      return Padding(
          padding: margin,
          child: InkWell(
              borderRadius: const BorderRadius.all(
                  Radius.circular(borderRadiusContainer)),
              onTap: () => onTap?.call(),
              onLongPress: () => onLongTap?.call(),
              child: widget));
    }
    return Padding(padding: margin, child: widget);
  }
}
