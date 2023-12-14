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
  final double? maxValue;
  final double? minValue;
  final Function(double)? onDragDone;
  final bool reversed;

  const DimmableWidgetContainer(
      {super.key,
      required this.child,
      required this.value,
      this.maxValue = 100,
      this.minValue = 0,
      this.onDragDone,
      this.padding,
      this.margin = const EdgeInsets.all(0),
      this.onTap,
      this.onLongTap,
      this.elevation = 2,
      this.backgroundColor,
      this.accentBackgroundColor,
      this.width,
      this.reversed = false});

  @override
  State<DimmableWidgetContainer> createState() =>
      _DimmableWidgetContainerState();
}

class _DimmableWidgetContainerState extends State<DimmableWidgetContainer> {
  double dragAmount = 0;
  double value = 0;

  double get currentValue => value + (dragAmount / 100);

  bool get isDragEnabled => widget.onDragDone != null;

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
                        stops: widget.reversed
                            ? [0, 1 - currentValue, 1 - currentValue]
                            : [0, currentValue, currentValue],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: !widget.reversed
                            ? [
                                widget.accentBackgroundColor ??
                                    getAccentBackgroundColor(context),
                                widget.accentBackgroundColor ??
                                    getAccentBackgroundColor(context),
                                widget.backgroundColor ??
                                    getBackgroundColor(context)
                              ]
                            : [
                                widget.backgroundColor ??
                                    getBackgroundColor(context),
                                widget.backgroundColor ??
                                    getBackgroundColor(context),
                                widget.accentBackgroundColor ??
                                    getAccentBackgroundColor(context)
                              ]),
                    color:
                        widget.backgroundColor ?? getBackgroundColor(context)),
                padding: widget.padding,
                child: widget.child)));
    if (widget.onTap != null || widget.onLongTap != null) {
      return Padding(
          padding: widget.margin,
          child: GestureDetector(
              onVerticalDragEnd: isDragEnabled
                  ? (details) {
                      setState(() {
                        print(currentValue);
                        if (widget.maxValue != null &&
                            currentValue > widget.maxValue! / 100) {
                          value = widget.maxValue! / 100;
                        } else if (widget.minValue != null &&
                            currentValue < widget.minValue! / 100) {
                          value = widget.minValue! / 100;
                        } else {
                          value = currentValue;
                        }
                        dragAmount = 0;
                        widget.onDragDone!.call(value * 100);
                      });
                    }
                  : null,
              onVerticalDragUpdate: isDragEnabled
                  ? (details) {
                      setState(() {
                        if (widget.reversed) {
                          dragAmount += details.delta.dy;
                        } else {
                          dragAmount -= details.delta.dy;
                        }
                      });
                    }
                  : null,
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
