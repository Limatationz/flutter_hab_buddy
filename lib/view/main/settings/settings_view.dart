import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/face_recognition_service.dart';
import '../../../generated/l10n.dart';
import '../../../repository/connectivity_manager.dart';
import '../../../util/icons/icons.dart';
import '../../util/general/alert_dialog_action.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/list_picker_sheet_view.dart';
import 'licences/licences_view.dart';
import 'settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  static const String routePath = '/settings';
  static const String routeName = 'SettingsView';

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => SettingsViewModel(),
        builder: (context, model, child) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar.medium(title: Text(S.current.navigationSettings)),
              ];
            },
            body: SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground: Theme.of(context).colorScheme.surface,
                settingsSectionBackground: ElevationOverlay.applySurfaceTint(
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surfaceTint,
                  2,
                ),
                tileHighlightColor: Theme.of(context).colorScheme.primary,
                dividerColor:
                    Theme.of(context).dividerTheme.color ??
                    Theme.of(context).dividerColor,
              ),
              darkTheme: SettingsThemeData(
                settingsListBackground: Theme.of(context).colorScheme.surface,
                settingsSectionBackground: ElevationOverlay.applySurfaceTint(
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surfaceTint,
                  2,
                ),
                dividerColor:
                    Theme.of(context).dividerTheme.color ??
                    Theme.of(context).dividerColor,
              ),
              sections: [
                SettingsSection(
                  title: Text(
                    S.of(context).settings_connection,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  tiles: [
                    SettingsTile(
                      title: Text(
                        S.of(context).settings_connection_status_title,
                      ),
                      description: Text(
                        S.of(context).settings_connection_status_description,
                      ),
                      descriptionInlineIos: true,
                      trailing: StreamBuilder<ServerConnectionState>(
                        stream: model.connectionStatus,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data?.name ?? "-");
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                    SettingsTile(
                      title: Text(
                        S.of(context).settings_connection_start_title,
                      ),
                      description: Text(
                        S.of(context).settings_connection_start_description,
                      ),
                      descriptionInlineIos: true,
                      trailing: StreamBuilder<DateTime?>(
                        stream: model.lastSSEConnectionStart,
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Text(
                              DateFormat.yMd().add_Hms().format(snapshot.data!),
                            );
                          } else {
                            return Text(S.of(context).never);
                          }
                        },
                      ),
                    ),
                    SettingsTile(
                      title: Text(
                        S.of(context).settings_connection_update_title,
                      ),
                      description: Text(
                        S.of(context).settings_connection_update_description,
                      ),
                      descriptionInlineIos: true,
                      trailing: StreamBuilder<DateTime?>(
                        stream: model.lastSSEUpdate,
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Text(
                              snapshot.data!.timeago(
                                locale: S.of(context).localeName,
                              ),
                            );
                          } else {
                            return Text(S.of(context).never);
                          }
                        },
                      ),
                    ),
                    if (model.missingRemoteSetup)
                      SettingsTile(
                        title: Text(S.of(context).settingsAddRemoteAccess),
                        onPressed: (context) => model.addRemoteSetup(context),
                        trailing: const SizedBox.shrink(),
                      ),
                    if (model.missingCloudSetup)
                      SettingsTile(
                        title: Text(S.of(context).settingsAddCloudAccess),
                        onPressed: (context) => model.addCloudSetup(context),
                        trailing: const SizedBox.shrink(),
                      ),
                    if (model.missingApiSetup)
                      SettingsTile(
                        title: Text(S.of(context).settingsAddApiAccess),
                        onPressed: (context) => model.addApiSetup(context),
                        trailing: const SizedBox.shrink(),
                      ),
                    SettingsTile(
                      title: Text(S.of(context).logout),
                      onPressed: (context) => model.logout(context),
                      trailing: const SizedBox.shrink(),
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    S.of(context).settings_app,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  tiles: [
                    SettingsTile(
                      title: Text(S.of(context).settings_theme),
                      trailing: const Icon(LineIcons.chevron_right),
                      onPressed: (context) {
                        showBarModalBottomSheet<int?>(
                          context: context,
                          builder: (_) =>
                              ListPickerSheetView<AdaptiveThemeMode>(
                                options: AdaptiveThemeMode.values,
                                optionToString: (mode) {
                                  switch (mode) {
                                    case AdaptiveThemeMode.light:
                                      return S.current.themeLight;
                                    case AdaptiveThemeMode.dark:
                                      return S.current.themeDark;
                                    case AdaptiveThemeMode.system:
                                      return S.current.themeSystem;
                                  }
                                },
                                option: model.getThemeMode(context),
                                onOptionChange: (newMode) {
                                  model.setTheme(context, newMode!);
                                },
                              ),
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      title: Text(S.of(context).licences),
                      onPressed: (context) =>
                          context.goNamed(LicencesView.routeName),
                    ),
                    SettingsTile.navigation(
                      title: Text(S.of(context).feedback),
                      onPressed: (context) {
                        showAdaptiveDialog<AppFeedbackType?>(
                          context: context,
                          builder: (context) => AlertDialog.adaptive(
                            content: Text(
                              S.of(context).feedback_choose_type_dialog,
                            ),
                            actions: [
                              ...AppFeedbackType.values.map(
                                (e) => AlertDialogAction(
                                  onPressed: () => Navigator.of(context).pop(e),
                                  child: Text(e.description),
                                ),
                              ),
                              AlertDialogAction(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(S.current.cancel),
                              ),
                            ],
                          ),
                        ).then((type) {
                          if (type != null) {
                            model.sendFeedback(context: context, type: type);
                          }
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text(S.of(context).settings_send_crash_reports),
                      initialValue: model.isCrashlyticsEnabled,
                      onToggle: model.onCrashlyticsSwitchToggled,
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    S.of(context).settings_wall_mount_mode,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  tiles: [
                    SettingsTile.switchTile(
                      title: Text(S.of(context).settings_wall_mount_mode),
                      description: Text(
                        S.of(context).settings_wall_mount_mode_description,
                      ),
                      descriptionInlineIos: true,
                      initialValue: model.wallMountService.autoEnabled,
                      onToggle: model.setWallMountModeAutoEnabled,
                      activeSwitchColor: Theme.of(context).colorScheme.primary,
                    ),
                    SettingsTile.switchTile(
                      title: Text(S.of(context).settings_face_recognition),
                      description: Text(
                        S.of(context).settings_face_recognition_description,
                      ),
                      descriptionInlineIos: true,
                      initialValue: model
                          .wallMountService
                          .faceRecognitionService
                          .isEnabled,
                      onToggle: model.setWallMountModeFaceRecognitionEnabled,
                      enabled:
                          model.wallMountService.faceRecognitionService.error ==
                          null,
                      activeSwitchColor: Theme.of(context).colorScheme.primary,
                    ),
                    if (model.wallMountService.faceRecognitionService.error !=
                        null)
                      _buildWallMountModeFaceRecognitionError(
                        context,
                        model.wallMountService.faceRecognitionService.error!,
                        model,
                      ),
                  ],
                ),
                if (kDebugMode)
                  SettingsSection(
                    title: Text(
                      "Debug",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    tiles: [
                      SettingsTile(
                        title: const Text("Clear Database"),
                        onPressed: (_) {
                          model.clearDatabase();
                        },
                      ),
                      SettingsTile(
                        title: const Text("Insert Dummy Data München"),
                        onPressed: (_) {
                          SettingsViewModel.insertDummyDataMunich();
                        },
                      ),
                      SettingsTile(
                        title: const Text("Insert Dummy Data Hof"),
                        onPressed: (_) {
                          SettingsViewModel.insertDummyDataHof();
                        },
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  AbstractSettingsTile _buildWallMountModeFaceRecognitionError(
    BuildContext context,
    FaceRecognitionServiceError error,
    SettingsViewModel model,
  ) {
    switch (error) {
      case FaceRecognitionServiceError.cameraPermissionNotRequested:
        return SettingsTile.navigation(
          title: Text("Camera permission not requested"),
          onPressed: (context) {
            model.requestWallMountModeFaceRecognitionCameraPermission();
          },
        );
      case FaceRecognitionServiceError.cameraPermissionDenied:
        return SettingsTile.navigation(
          title: Text("Camera permission denied"),
          description: Text(
            "Please grant camera permission in the system settings.",
          ),
          onPressed: (context) {
            model.wallMountModeFaceRecognitionCameraPermissionOpenSettings();
          },
        );
      case FaceRecognitionServiceError.faceRecognitionNotSupported:
        return SettingsTile(title: Text("Face recognition not supported"));
      case FaceRecognitionServiceError.noFrontCamera:
        return SettingsTile(title: Text("No front camera found"));
      case FaceRecognitionServiceError.imageStreamNotSupported:
        return SettingsTile(title: Text("Image stream not supported"));
    }
  }
}
