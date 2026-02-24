import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../repository/item_repository.dart';
import '../../repository/login_repository.dart';
import '../../util/secrets.dart';
import '../main/favourite/favourite_view.dart';
import '../main/settings/settings_viewmodel.dart';
import '../util/constants.dart';
import '../util/general/base_elevated_button.dart';
import 'login_local_setup_view.dart';

class LoginStartView extends StatefulWidget {
  static const String routePath = '/login-start';
  static const String routeName = 'LoginStartView';

  const LoginStartView({super.key});

  @override
  _LoginStartViewState createState() => _LoginStartViewState();
}

class _LoginStartViewState extends State<LoginStartView> {
  final _log = Logger();

  int pressesForDemo = 0;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(paddingScaffold),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250, maxHeight: 250),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(32),
                  clipBehavior: .hardEdge,
                  child: Image.asset("res/images/logo.png"),
                ),
              ),
            ),
            largeGap,
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 180),
                child: GestureDetector(
                  onTap: _increasePressesForDemo,
                  child: Image.asset(
                    "res/images/workswith-openHAB-logo/openHAB_workswith.png",
                  ),
                ),
              ),
            ),
            extraLargeGap,
            Text(
              S.of(context).welcome,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(largePadding),
            Text(
              S.of(context).welcomeDescription,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(extraLargePadding),
            BaseElevatedButton(
              onPressed: () {
                context.pushReplacementNamed(LoginLocalSetupView.routeName);
              },
              text: S.of(context).startSetup,
            ),
            if (kDebugMode) ...[
              const Gap(extraLargePadding),
              const Text("Demos in Debug Mode"),
              const Gap(largePadding),
              BaseElevatedButton(onPressed: () => _demo(context), text: 'Demo'),
              const Gap(mediumPadding),
              BaseElevatedButton(
                onPressed: () => _demoMunich(context),
                text: 'Demo Munich',
              ),
              const Gap(mediumPadding),
              BaseElevatedButton(
                onPressed: () => _demoHof(context),
                text: 'Demo Hof',
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _increasePressesForDemo() {
    setState(() {
      pressesForDemo++;
    });

    if (pressesForDemo >= 5) {
      _demo(context);
      setState(() {
        pressesForDemo = 0;
      });
    }
  }

  Future<void> _demo(BuildContext context) async {
    // login
    final loginRepository = locator<LoginRepository>();

    final result = await loginRepository.storeLoginData(
      loginData: demoLoginData,
    );

    if (!result) {
      _log.e("Login failed for demo login");
      return;
    }

    // wait for connection
    await loginRepository.firstConnectionComplete.future;

    // fetch data
    await locator<ItemRepository>().fetchData();

    // add dummy data
    await SettingsViewModel.insertDummyDataDemo();

    // navigate
    context.pushReplacementNamed(FavouriteView.routeName);
  }

  Future<void> _demoMunich(BuildContext context) async {
    // login
    final loginRepository = locator<LoginRepository>();

    final result = await loginRepository.storeLoginData(
      loginData: munichLoginData,
    );

    if (!result) {
      _log.e("Login failed for munich demo login");
      return;
    }

    // wait for connection
    await loginRepository.firstConnectionComplete.future;

    // fetch data
    await locator<ItemRepository>().fetchData();

    // add dummy data
    await SettingsViewModel.insertDummyDataMunich();

    // navigate
    context.pushReplacementNamed(FavouriteView.routeName);
  }

  Future<void> _demoHof(BuildContext context) async {
    // login
    final loginRepository = locator<LoginRepository>();

    final result = await loginRepository.storeLoginData(
      loginData: hofLoginData,
    );

    if (!result) {
      _log.e("Login failed for hof demo login");
      return;
    }

    // wait for connection
    await loginRepository.firstConnectionComplete.future;

    // fetch data
    await locator<ItemRepository>().fetchData();

    // add dummy data
    await SettingsViewModel.insertDummyDataHof();

    // navigate
    context.pushReplacementNamed(FavouriteView.routeName);
  }
}
