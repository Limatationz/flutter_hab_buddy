import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/l10n.dart';
import '../../../repository/connectivity_manager.dart';
import '../../../util/icons/icons.dart';
import '../../util/general/bar_bottom_sheet.dart';
import '../../util/general/list_picker_sheet_view.dart';
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
                SliverAppBar.medium(
                  title: Text(S.current.navigationSettings),
                )
              ];
            },
            body: SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground: Theme.of(context).colorScheme.surface,
                settingsSectionBackground: ElevationOverlay.applySurfaceTint(
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surfaceTint,
                    2),
                tileHighlightColor: Theme.of(context).colorScheme.primary,
                dividerColor: Theme.of(context).dividerTheme.color ??
                    Theme.of(context).dividerColor,
              ),
              darkTheme: SettingsThemeData(
                settingsListBackground: Theme.of(context).colorScheme.surface,
                settingsSectionBackground: ElevationOverlay.applySurfaceTint(
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surfaceTint,
                    2),
                dividerColor: Theme.of(context).dividerTheme.color ??
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
                            S.of(context).settings_connection_status_title),
                        description: Text(S
                            .of(context)
                            .settings_connection_status_description),
                        descriptionInlineIos: true,
                        trailing: StreamBuilder<ServerConnectionState>(
                          stream: model.connectionStatus,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Icon(
                                snapshot.data?.icon,
                                color: snapshot.data != ServerConnectionState.offline
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.error,
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      SettingsTile(
                        title:
                            Text(S.of(context).settings_connection_start_title),
                        description: Text(S
                            .of(context)
                            .settings_connection_start_description),
                        descriptionInlineIos: true,
                        trailing: StreamBuilder<DateTime?>(
                          stream: model.lastSSEConnectionStart,
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return Text(DateFormat.yMd()
                                  .add_Hms()
                                  .format(snapshot.data!));
                            } else {
                              return Text(S.of(context).never);
                            }
                          },
                        ),
                      ),
                      SettingsTile(
                        title: Text(
                            S.of(context).settings_connection_update_title),
                        description: Text(S
                            .of(context)
                            .settings_connection_update_description),
                        descriptionInlineIos: true,
                        trailing: StreamBuilder<DateTime?>(
                          stream: model.lastSSEUpdate,
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return Text(DateFormat.yMd()
                                  .add_Hms()
                                  .format(snapshot.data!));
                            } else {
                              return Text(S.of(context).never);
                            }
                          },
                        ),
                      ),
                      SettingsTile(
                        title: Text(S.of(context).logout),
                        onPressed: (context) => model.logout(context),
                        trailing: const SizedBox.shrink(),
                      ),
                    ]),
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
                            builder: (_) => ListPickerSheetView<String>(
                              options: [
                                S.current.themeLight,
                                S.current.themeDark,
                                S.current.themeSystem
                              ],
                              option: model.getThemeIndex(context),
                              onOptionChange: (index) {
                                model.setTheme(context, index);
                              },
                            ),
                          );
                        },
                      ),
                      SettingsTile.switchTile(
                        title: Text(S.of(context).settings_wakelock),
                        description:
                            Text(S.of(context).settings_wakelock_description),
                        descriptionInlineIos: true,
                        initialValue: model.wakelockService.autoEnabled,
                        onToggle: model.setWakeLockAutoEnabled,
                        activeSwitchColor:
                            Theme.of(context).colorScheme.primary,
                      ),
                    ]),
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
                            title: const Text("Insert Dummy Data"),
                            onPressed: (_) {
                              model.insertDummyData();
                            }),
                      ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
