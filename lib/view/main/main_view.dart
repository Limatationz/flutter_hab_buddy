// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/l10n.dart';
import '../../util/icons/icons.dart';
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
    viewModel.fetchData();

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    var brightness = View.of(context).platformDispatcher.platformBrightness;
    DynamicTheme.of(context)!.setTheme(brightness == Brightness.dark ? 1 : 0);
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
    return Scaffold(
      bottomNavigationBar: Platform.isAndroid
          ? _buildAndroidNavigationBar()
          : _buildIOSNavigationBar(),
      body: SizedBox.expand(
        child: _buildContent(),
      ),
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
              LineIcons.house_plan_alt_2,
              LineIconsFilled.house_plan_alt_2),
          _buildAndroidBottomNavigationItem(
              context,
              S.of(context).navigationInbox,
              2,
              LineIcons.inbox,
              LineIconsFilled.inbox),
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
              1, LineIcons.house_plan_alt_2, LineIconsFilled.house_plan_alt_2),
          _buildIOSBottomNavigationItem(context, S.of(context).navigationInbox,
              2, LineIcons.inbox, LineIconsFilled.inbox),
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
