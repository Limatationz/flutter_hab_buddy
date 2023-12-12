import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart' as stacked;

class SnackbarService {
  final _snackbarService = stacked.SnackbarService();

  SnackbarService() {
    _snackbarService.registerCustomSnackbarConfig(
      variant: SnackbarType.error,
      config: stacked.SnackbarConfig(
        backgroundColor: const Color(0xFFE57373),
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
      ),
    );

    _snackbarService.registerCustomSnackbarConfig(
      variant: SnackbarType.success,
      config: stacked.SnackbarConfig(
        backgroundColor: const Color(0xFF81C784),
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
      ),
    );

    _snackbarService.registerCustomSnackbarConfig(
      variant: SnackbarType.info,
      config: stacked.SnackbarConfig(
        backgroundColor: const Color(0xFF64B5F6),
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
      ),
    );

    _snackbarService.registerCustomSnackbarConfig(
      variant: SnackbarType.warning,
      config: stacked.SnackbarConfig(
        backgroundColor: const Color(0xFFFFB74D),
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showSnackbar({
    String? title,
    required String message,
    required SnackbarType type,
    Duration? duration,
  }) {
    _snackbarService.showCustomSnackBar(
      variant: type,
      title: title,
      message: message,
      duration: duration,
    );
  }
}

enum SnackbarType { error, success, info, warning }
