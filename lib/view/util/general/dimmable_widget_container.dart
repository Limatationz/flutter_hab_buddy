import 'dart:ffi';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DimmableWidgetContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final double elevation;
  final Color? backgroundColor;
  final Color? accentBackgroundColor;
  final double? width;
  final double value;
  final Function(double) onDragDone;

  const DimmableWidgetContainer(
      {super.key,
      required this.child,
      required this.value,
      required this.onDragDone,
      this.padding,
      this.margin = const EdgeInsets.all(0),
      this.onTap,
      this.onLongTap,
      this.elevation = 2,
      this.backgroundColor,
      this.accentBackgroundColor,
      this.width});

  @override
  State<DimmableWidgetContainer> createState() =>
      _DimmableWidgetContainerState();
}

class _DimmableWidgetContainerState extends State<DimmableWidgetContainer> {
  double dragAmount = 0;
  double value = 0;

  double get currentValue => value + (dragAmount / 100);

  @override
  void initState() {
    super.initState();
    value = widget.value / 100;
  }

  @override
  Widget build(BuildContext context) {
    final child = Material(
        elevation: widget.elevation,
        borderRadius:
            const BorderRadius.all(Radius.circular(borderRadiusContainer)),
        child: ClipRRect(
            borderRadius:
                const BorderRadius.all(Radius.circular(borderRadiusContainer)),
            child: Container(
                width: widget.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0, currentValue, currentValue],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        widget.accentBackgroundColor ??
                            getAccentBackgroundColor(context),
                        widget.accentBackgroundColor ??
                            getAccentBackgroundColor(context),
                        widget.backgroundColor ?? getBackgroundColor(context)
                      ],
                    ),
                    color:
                        widget.backgroundColor ?? getBackgroundColor(context)),
                padding: widget.padding,
                child: widget.child)));
    if (widget.onTap != null || widget.onLongTap != null) {
      return Padding(
          padding: widget.margin,
          child: GestureDetector(
              onVerticalDragEnd: (details) {
                widget.onDragDone.call(dragAmount);
                setState(() {
                  value = currentValue;
                  dragAmount = 0;
                });
              },
              onVerticalDragUpdate: (details) {
                setState(() {
                  dragAmount -= details.delta.dy;
                });
              },
              onTap: () => widget.onTap?.call(),
              onLongPress: () => widget.onLongTap?.call(),
              child: child));
    }
    return Padding(padding: widget.margin, child: child);
  }

  Color getBackgroundColor(BuildContext context) =>
      widget.backgroundColor ??
      ElevationOverlay.applySurfaceTint(
          DynamicTheme.of(context)!.theme.colorScheme.background,
          DynamicTheme.of(context)!.theme.colorScheme.surfaceTint,
          1);

  Color getAccentBackgroundColor(BuildContext context) =>
      DynamicTheme.of(context)!.theme.colorScheme.secondaryContainer;
}
