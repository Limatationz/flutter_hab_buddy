import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/l10n.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';
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
                  const SliverAppBar.medium(
                    title: Text("Settings"),
                  )
                ];
              },
              body: Theme(
                data: Theme.of(context).copyWith(
                    cardColor: ElevationOverlay.applySurfaceTint(
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.surfaceTint,
                        2)),
                child: ListView(
                  padding: const EdgeInsets.all(paddingScaffold),
                  children: [
                    SettingsGroup(
                        settingsGroupTitle: "Connection",
                        settingsGroupTitleStyle:
                            Theme.of(context).textTheme.titleMedium,
                        items: [
                          SettingsItem(
                            icons: LineIcons.wifi,
                            iconStyle: IconStyle(
                              backgroundColor: Colors.grey,),
                            title: "Connection Status",
                            trailing: StreamBuilder<bool>(
                              stream: model.connectionStatus,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Icon(
                                    snapshot.data!
                                        ? LineIcons.checkmark
                                        : LineIcons.minus,
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                          SettingsItem(
                            icons: LineIcons.wifi_alt_1,
                            iconStyle: IconStyle(
                              backgroundColor: Colors.grey,
                            ),
                            title: "Connection Start",
                            trailing: StreamBuilder<DateTime?>(
                              stream: model.lastConnectionStart,
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(DateFormat.yMd()
                                      .add_Hms()
                                      .format(snapshot.data!));
                                } else {
                                  return Text("Never");
                                }
                              },
                            ),
                          ),
                          SettingsItem(
                            icons: LineIcons.wifi_alt_2,
                            iconStyle: IconStyle(
                              backgroundColor: Colors.grey,),
                            title: "Last Update",
                            trailing: StreamBuilder<DateTime?>(
                              stream: model.lastUpdate,
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(DateFormat.yMd()
                                      .add_Hms()
                                      .format(snapshot.data!));
                                } else {
                                  return Text("Never");
                                }
                              },
                            ),
                          ),
                          SettingsItem(
                            icons: LineIcons.exit,
                            iconStyle: IconStyle(backgroundColor: Colors.red),
                            title: "Logout",
                            onTap: () => model.logout(context),
                            trailing: SizedBox.shrink(),
                          ),
                        ]),
                    SettingsGroup(
                        settingsGroupTitle: "App",
                        settingsGroupTitleStyle:
                            Theme.of(context).textTheme.titleMedium,
                        items: [
                          SettingsItem(
                            icons: LineIcons.sun,
                            iconStyle: IconStyle(),
                            title: "Theme",
                            onTap: () {
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
                          SettingsItem(
                            icons: LineIcons.locked_window,
                            iconStyle: IconStyle(),
                            title: "Wakelock",
                            subtitle: "Automatically enable wakelock",
                            trailing: StreamBuilder<bool>(
                              stream: model.wakelockService.autoEnabledStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Switch.adaptive(
                                    value: snapshot.data!,
                                    onChanged: (value) {
                                      model.wakelockService
                                          .toggleAutoEnabled();
                                    },
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ]),
                    SettingsGroup(
                        settingsGroupTitle: "Debug",
                        settingsGroupTitleStyle:
                            Theme.of(context).textTheme.titleMedium,
                        items: [
                          SettingsItem(
                            icons: LineIcons.database_11,
                            iconStyle: IconStyle(
                              backgroundColor: Colors.orange,
                            ),
                            title: "Clear Database",
                            onTap: model.clearDatabase,
                          ),
                          SettingsItem(
                              icons: LineIcons.database_10,
                              title: "Insert Dummy Data",
                              onTap: model.insertDummyData),
                        ]),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
