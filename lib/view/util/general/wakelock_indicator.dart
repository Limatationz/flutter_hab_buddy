import 'package:flutter/material.dart';

import '../../../core/services/wakelock_service.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../util/icons/icons.dart';

class WakelockIndicator extends StatelessWidget {
  final wakelockService = locator<WakelockService>();
  final snackBarService = locator<SnackbarService>();

  WakelockIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: wakelockService.enabledStream,
        builder: (context, snapshot) {
          final enabled = snapshot.data ?? false;
          if (enabled) {
            return Tooltip(
                message: S.of(context).disableWakelockTooltip,
                child: IconButton(
                    onPressed: disableWakelock,
                    icon: const Icon(LineIconsFilled.locked_window)));
          } else {
            return Tooltip(
                message: S.of(context).enableWakelockTooltip,
                child: IconButton(
                    onPressed: enableWakelock,
                    icon: const Icon(LineIcons.locked_window)));
          }
        });
  }

  Future<void> enableWakelock() async {
    await locator<WakelockService>().enable();
    snackBarService.showSnackbar(
        message: S.current.wakelockEnabledSnackbar, type: SnackbarType.info);
  }

  Future<void> disableWakelock() async {
    await locator<WakelockService>().disable();
    snackBarService.showSnackbar(
        message: S.current.wakelockDisabledSnackbar, type: SnackbarType.info);
  }
}
