import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BaseItemDialog extends StatelessWidget {
  final Widget child;

  const BaseItemDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: DynamicTheme.of(context)!.theme.colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(paddingScaffold),
        child: child);
  }
}
