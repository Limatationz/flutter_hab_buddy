// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/l10n.dart';
import '../../util/icons/icons.dart';
import '../util/general/base_scaffold.dart';
import '../util/platform.dart';
import 'main_viewmodel.dart';

class MainView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainView({super.key, required this.navigationShell});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  final MainViewModel viewModel = MainViewModel();

  @override
  void initState() {
    FlutterNativeSplash.remove();

    viewModel.fetchData();

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    var brightness = View.of(context).platformDispatcher.platformBrightness;
    if (brightness == Brightness.dark) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // validates the token if necessary fetches Data on Resume
      viewModel.fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: isDesktop()
          ? null
          : isAndroid()
              ? _buildAndroidNavigationBar()
              : _buildIOSNavigationBar(),
      bodyBuilder: (context, isWallMountEnabled) =>
          isDesktop() && !isWallMountEnabled
              ? Row(children: [
                  _buildDesktopSideBar(context),
                  const VerticalDivider(thickness: 1, width: 1),
                  // This is the main content.
                  Expanded(child: _buildContent())
                ])
              : SizedBox.expand(
                  child: _buildContent(),
                ),
        showFloatingButtonOnEnabled: false,
    );
  }

  Widget _buildContent() => widget.navigationShell;

  NavigationBar _buildAndroidNavigationBar() => NavigationBar(
        destinations: [
          _buildAndroidBottomNavigationItem(
              context,
              S.of(context).navigationFavorites,
              0,
              LineIcons.star,
              LineIconsFilled.star),
          _buildAndroidBottomNavigationItem(
              context,
              S.of(context).navigationRooms,
              1,
              LineIconsLight.house_plan_alt_2,
              LineIcons.house_plan_alt_2),
          _buildAndroidBottomNavigationItem(
              context,
              S.current.navigationAutomation,
              2,
              LineIconsLight.automation,
              LineIcons.automation),
          _buildAndroidBottomNavigationItem(
              context,
              S.of(context).navigationSettings,
              3,
              LineIconsLight.cog,
              LineIcons.cog),
        ],
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => setState(
          () {
            _navigateToIndex(index);
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      );

  BottomNavigationBar _buildIOSNavigationBar() => BottomNavigationBar(
        items: [
          _buildIOSBottomNavigationItem(
              context,
              S.of(context).navigationFavorites,
              0,
              LineIcons.star,
              LineIconsFilled.star),
          _buildIOSBottomNavigationItem(context, S.of(context).navigationRooms,
              1, LineIconsLight.house_plan_alt_2, LineIcons.house_plan_alt_2),
          _buildIOSBottomNavigationItem(context, "Automation", 2,
              LineIconsLight.automation, LineIcons.house_plan_alt_2),
          _buildIOSBottomNavigationItem(
              context,
              S.of(context).navigationSettings,
              3,
              LineIconsLight.cog,
              LineIcons.cog),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => setState(
          () {
            _navigateToIndex(index);
          },
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
      );

  BottomNavigationBarItem _buildIOSBottomNavigationItem(BuildContext context,
          String title, int index, IconData icon, IconData selectedIcon,
          {Widget? widget}) =>
      BottomNavigationBarItem(
          icon: widget ??
              Icon(
                  index == _calculateSelectedIndex(context)
                      ? selectedIcon
                      : icon,
                  size: 20),
          label: title,
          tooltip: "");

  NavigationDestination _buildAndroidBottomNavigationItem(BuildContext context,
          String title, int index, IconData icon, IconData selectedIcon,
          {Widget? widget}) =>
      NavigationDestination(
        icon: widget ??
            Icon(
                index == _calculateSelectedIndex(context) ? selectedIcon : icon,
                size: 20),
        label: title,
        tooltip: "",
      );

  Widget _buildDesktopSideBar(BuildContext context) => NavigationRail(
      labelType: NavigationRailLabelType.all,
      leading: isMacOS()
          ? const SizedBox(
              height: 35,
            )
          : null,
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          icon: const Icon(
            LineIcons.star,
          ),
          selectedIcon: const Icon(
            LineIconsFilled.star,
          ),
          label: Text(S.current.navigationFavorites),
        ),
        NavigationRailDestination(
          icon: const Icon(
            LineIconsLight.house_plan_alt_2,
          ),
          selectedIcon: const Icon(
            LineIcons.house_plan_alt_2,
          ),
          label: Text(S.current.navigationRooms),
        ),
        NavigationRailDestination(
          icon: const Icon(
            LineIconsLight.automation,
          ),
          selectedIcon: const Icon(
            LineIcons.automation,
          ),
          label: Text(S.current.navigationAutomation),
        ),
        NavigationRailDestination(
          icon: const Icon(
            LineIconsLight.cog,
          ),
          selectedIcon: const Icon(
            LineIcons.cog,
          ),
          label: Text(S.current.navigationSettings),
        )
      ],
      selectedIndex: _calculateSelectedIndex(context),
      onDestinationSelected: (index) => setState(
            () {
              _navigateToIndex(index);
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ));

  Widget _buildWindowsSideBar() => Container();

  _navigateToIndex(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  int _calculateSelectedIndex(BuildContext context) {
    return widget.navigationShell.currentIndex;
  }

  @override
  void onPause() {
    // nothing
  }

  @override
  Future<AppExitResponse> didRequestAppExit() {
    return Future.value(AppExitResponse.exit);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
