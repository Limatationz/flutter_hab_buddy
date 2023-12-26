import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
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
                  SliverAppBar.medium(
                    title: const Text("Settings"),
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
