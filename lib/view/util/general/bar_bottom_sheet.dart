import 'dart:io';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'bottom_sheet_container.dart';

class BarModal extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool expand;

  const BarModal(
      {super.key,
      required this.child,
      this.backgroundColor,
      this.expand = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 6,
          width: 40,
          decoration: BoxDecoration(
              color: DynamicTheme.of(context)!.theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(6)),
        ),
        const SizedBox(height: 8),
        if (expand)
          Expanded(
            child: Material(
              color: backgroundColor,
              clipBehavior: Clip.antiAlias,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Padding(
                  padding: EdgeInsets.only(bottom: Platform.isIOS ? 12 : 0),
                  child: child),
            ),
          )
        else
          Material(
            color: backgroundColor,
            clipBehavior: Clip.antiAlias,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Padding(
                padding: EdgeInsets.only(bottom: Platform.isIOS ? 12 : 0),
                child: child),
          ),
      ],
    );
  }
}

Future<T> showBarModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool expand = false,
}) async {
  return await showCustomModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: builder,
      containerWidget: (_, animation, child) => BarModal(
          backgroundColor: DynamicTheme.of(context)!.theme.colorScheme.surface,
          child: BottomSheetContainer(
            child: child,
          ),
          expand: expand),
      expand: expand);
}
