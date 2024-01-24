import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/snackbar/snackbar_service.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../repository/login_repository.dart';
import '../../util/icons/icons.dart';
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
  bool obscureText = true;

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
                        const Gap(42),
                        Flexible(
                            child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 200, maxHeight: 200),
                                child: Image.asset(
                                    "res/images/logo_smarthome.png"))),
                        const Gap(42),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(S.of(context).loginInfo,
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        const Gap(18),
                        FormBuilderTextField(
                          name: "username",
                          decoration: InputDecoration(
                            label: Text(S.of(context).username),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                          textInputAction: TextInputAction.next,
                        ),
                        const Gap(12),
                        FormBuilderTextField(
                          name: "password",
                          decoration: InputDecoration(
                            label: Text(S.of(context).password),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  obscureText
                                      ? LineIconsFilled.eye
                                      : LineIconsFilled.eye_slash,
                                  size: 22,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                          obscureText: obscureText,
                          validator: FormBuilderValidators.required(),
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _login(),
                        ),
                        const Gap(16),
                        BaseElevatedButton(
                            text: S.of(context).login, onPressed: _login),
                      ],
                    )))));
  }

  void _login() async {
    if (_fbKey.currentState!.saveAndValidate()) {
      loginRepository
          .storeLogin(
              username: _fbKey.currentState!.value['username'],
              password: _fbKey.currentState!.value['password'])
          .then((success) {
        if (success) {
          context.goNamed(FavouriteView.routeName);
        } else {
          locator.get<SnackbarService>().showSnackbar(
                type: SnackbarType.error,
                title: S.of(context).loginFailedTitle,
                message: S.of(context).loginFailedMessage,
              );
        }
      });
    }
  }
}
