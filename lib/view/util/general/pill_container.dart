import 'package:flutter/material.dart';

import '../constants.dart';

class PillContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final double elevation;
  final Color? backgroundColor;
  final ColorScheme? colorScheme;
  final double? width;
  final double? height;

  const PillContainer(
      {super.key,
      required this.child,
      this.padding,
      this.margin = const EdgeInsets.all(0),
      this.onTap,
      this.onLongTap,
      this.elevation = 2,
      this.backgroundColor,
      this.colorScheme,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    final widget = Material(
        elevation: elevation,
        borderRadius:
            const BorderRadius.all(Radius.circular(borderRadiusPillContainer)),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(
                Radius.circular(borderRadiusPillContainer)),
            child: Container(
                width: width,
                height: height,
                key: key,
                decoration: BoxDecoration(
                  color: backgroundColor ??
                      ElevationOverlay.applySurfaceTint(
                          colorScheme?.background ??
                              Theme.of(context)
                                  .colorScheme
                                  .background,
                          colorScheme?.surfaceTint ??
                              Theme.of(context)
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
