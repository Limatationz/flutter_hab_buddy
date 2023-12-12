import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/snackbar/snackbar_service.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../repository/login_repository.dart';
import '../main/favourite/favourite_view.dart';
import '../util/constants.dart';
import '../util/general/base_elevated_button.dart';

class LoginView extends StatefulWidget {
  static const String routePath = '/login';
  static const String routeName = 'LoginView';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginRepository = locator.get<LoginRepository>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(paddingScaffold),
            child: Center(
                child: FormBuilder(
                    key: _fbKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FormBuilderTextField(
                          name: "username",
                          decoration: InputDecoration(
                            label: Text(S.of(context).username),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const Gap(12),
                        FormBuilderTextField(
                          name: "password",
                          decoration: InputDecoration(
                            label: Text(S.of(context).password),
                          ),
                          obscureText: true,
                        ),
                        const Gap(16),
                        BaseElevatedButton(
                            text: S.of(context).login,
                            onPressed: () {
                              if (_fbKey.currentState!.saveAndValidate()) {
                                loginRepository
                                    .storeLogin(
                                        username: _fbKey
                                            .currentState!.value['username'],
                                        password: _fbKey
                                            .currentState!.value['password'])
                                    .then((success) {
                                  if (success) {
                                    context.goNamed(FavouriteView.routeName);
                                  } else {
                                    locator.get<SnackbarService>().showSnackbar(
                                          type: SnackbarType.error,
                                          title: S.of(context).loginFailedTitle,
                                          message:
                                              S.of(context).loginFailedMessage,
                                        );
                                  }
                                });
                              }
                            }),
                      ],
                    )))));
  }
}
