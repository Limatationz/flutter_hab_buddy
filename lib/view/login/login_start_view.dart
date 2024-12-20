import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(paddingScaffold),
      child: (Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: Image.asset("res/images/logo.png")),
        Gap(40),
        Text("Login Start View",
            style: Theme.of(context).textTheme.headlineLarge),
        Gap(20),
        Text(
          "This is the start view for the login process. Hier kommt Fancy Text hin. Vielleicht noch eine coole Animation.",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        Gap(20),
        BaseElevatedButton(onPressed: () {
          context.pushReplacementNamed(LoginLocalSetupView.routeName);
        }, text: 'Beginne mit dem Setup')
      ]))),
    ));
  }
}
