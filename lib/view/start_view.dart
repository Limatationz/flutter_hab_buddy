import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import '../../repository/login_repository.dart';
import '../locator.dart';
import 'login/login_start_view.dart';
import 'login/login_view.dart';
import 'main/favourite/favourite_view.dart';

class StartView extends StatefulWidget {
  static const routeName = 'start';
  static const routePath = '/';

  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  final loginRepository = locator.get<LoginRepository>();

  @override
  initState() {
    // login
    loginRepository.checkLogin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
        stream: loginRepository.loggedIn,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              FlutterNativeSplash.remove();
              final loggedIn = snapshot.data!;
              if (loggedIn) {
                context.goNamed(FavouriteView.routeName);
              } else {
                context.goNamed(LoginStartView.routeName);
              }
            });
          }

          return Scaffold(body: Container());
        });
  }
}
