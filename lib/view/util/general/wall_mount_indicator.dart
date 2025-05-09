import 'package:flutter/material.dart';

import '../../../core/services/wall_mount_service.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../util/icons/icons.dart';

class WakelockIndicator extends StatelessWidget {
  final wallMountService = locator<WallMountService>();
  final snackBarService = locator<SnackbarService>();

  WakelockIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: wallMountService.enabledStream,
        builder: (context, snapshot) {
          final enabled = snapshot.data ?? false;
          if (enabled) {
            return Tooltip(
                message: S.of(context).disableWallMoundModeTooltip,
                child: IconButton(
                    onPressed: disableWallMount,
                    icon: const Icon(LineIconsFilled.locked_window)));
          } else {
            return Tooltip(
                message: S.of(context).enableWallMountModeTooltip,
                child: IconButton(
                    onPressed: enableWallMount,
                    icon: const Icon(LineIcons.locked_window)));
          }
        });
  }

  Future<void> enableWallMount() async {
    await locator<WallMountService>().enable();
    snackBarService.showSnackbar(
        message: S.current.wallMountModeEnabledSnackbar, type: SnackbarType.info);
  }

  Future<void> disableWallMount() async {
    await locator<WallMountService>().disable();
    snackBarService.showSnackbar(
        message: S.current.wallMountModeDisabledSnackbar, type: SnackbarType.info);
  }
}
