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
  final DecorationImage? backgroundImage;
  final ColorScheme? colorScheme;
  final double? width;
  final double? height;
  final bool disableTap;

  const WidgetContainer(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(paddingContainer),
      this.margin = const EdgeInsets.all(0),
      this.onTap,
      this.onLongTap,
      this.elevation = 2,
      this.backgroundColor,
      this.backgroundImage,
      this.colorScheme,
      this.width,
      this.height,
      this.disableTap = false});

  @override
  Widget build(BuildContext context) {
    final widget = Material(
        elevation: elevation,
        shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(borderRadiusContainer)),
        child: ClipRSuperellipse(
            borderRadius:
                const BorderRadius.all(Radius.circular(borderRadiusContainer)),
            child: Container(
                width: width,
                height: height,
                key: key,
                decoration: BoxDecoration(
                  image: backgroundImage,
                  color: backgroundColor ??
                      ElevationOverlay.applySurfaceTint(
                          colorScheme?.surface ??
                              Theme.of(context).colorScheme.surface,
                          colorScheme?.surfaceTint ??
                              Theme.of(context).colorScheme.surfaceTint,
                          1),
                ),
                padding: padding,
                child: child)));
    if ((onTap != null || onLongTap != null) && !disableTap) {
      return Padding(
          padding: margin,
          child: InkWell(
              borderRadius: const BorderRadius.all(
                  Radius.circular(borderRadiusContainer)),
              onTap: () => onTap?.call(),
              onLongPress: () => onLongTap?.call(),
              child: widget));
    } else {
      return Padding(padding: margin, child: widget);
    }
  }
}
