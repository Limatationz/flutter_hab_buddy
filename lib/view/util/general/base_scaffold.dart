import 'package:flutter/material.dart';

import '../../../core/services/wall_mount_service.dart';
import '../../../locator.dart';
import '../../../util/icons/line_icons_icons.dart';

typedef BaseScaffoldBodyBuilder = Widget Function(
    BuildContext context, bool isWallMountEnabled);

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final BaseScaffoldBodyBuilder? bodyBuilder;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? bottomNavigationBar;

  final ColorScheme? colorScheme;
  final bool showFloatingButtonOnEnabled;

  final wallMountService = locator<WallMountService>();

  BaseScaffold({
    super.key,
    this.appBar,
    this.body,
    this.bodyBuilder,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.bottomNavigationBar,
    this.colorScheme,
    this.showFloatingButtonOnEnabled = true,
  }) : assert(bodyBuilder == null || body == null);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: wallMountService.enabledStream,
        builder: (context, snapshot) {
          final isEnabled = snapshot.data ?? false;
          return Theme(
              data: colorScheme != null && isEnabled
                  ? Theme.of(context).copyWith(
                      colorScheme: colorScheme!,
                      scaffoldBackgroundColor: colorScheme!.surface)
                  : Theme.of(context),
              child: Scaffold(
                appBar: !isEnabled ? appBar : null,
                body: isEnabled && showFloatingButtonOnEnabled
                    ? SafeArea(
                        child: body ?? bodyBuilder!.call(context, isEnabled))
                    : body ?? bodyBuilder?.call(context, isEnabled),
                bottomNavigationBar: !isEnabled ? bottomNavigationBar : null,
                floatingActionButton: isEnabled && showFloatingButtonOnEnabled
                    ? FloatingActionButton.small(
                        onPressed: () {
                          wallMountService.disable();
                        },
                        child: const Icon(LineIcons.locked_window))
                    : floatingActionButton,
                floatingActionButtonLocation:
                    isEnabled ? null : floatingActionButtonLocation,
                floatingActionButtonAnimator:
                    isEnabled ? null : floatingActionButtonAnimator,
              ));
        });
  }
}
