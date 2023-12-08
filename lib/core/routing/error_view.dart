import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../generated/l10n.dart';
import '../../view/util/general/base_elevated_button.dart';

class ErrorView extends StatelessWidget {
  final GoRouterState state;

  const ErrorView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(S.of(context).errorHeadline,
                    style: DynamicTheme.of(context)!.theme.textTheme.headlineLarge),
                if (kDebugMode) Text(state.error.toString()),
                const Gap(22),
                BaseElevatedButton(
                    text: S.of(context).errorButtonHome,
                    onPressed: () {
                      context.go('/');
                    }),
              ],
            )));
  }
}
