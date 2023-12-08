import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogAction extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const AlertDialogAction({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}
