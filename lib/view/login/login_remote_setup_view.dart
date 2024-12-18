import 'package:android_multicast_lock/android_multicast_lock.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/network/generated/client_index.dart';
import '../../core/network/generated/openHAB.swagger.dart';
import '../../core/network/interceptors/LoginInterceptor.dart';
import '../../core/services/snackbar_service.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../repository/login_repository.dart';
import '../../util/icons/icons.dart';
import '../util/constants.dart';
import '../util/general/base_elevated_button.dart';
import '../util/general/widget_container.dart';
import 'login_api_setup_view.dart';

class LoginRemoteSetupView extends StatefulWidget {
  static const String routePath = '/login-remote-setup';
  static const String routeName = 'LoginRemoteSetupView';

  const LoginRemoteSetupView({Key? key}) : super(key: key);

  @override
  State<LoginRemoteSetupView> createState() => _LoginRemoteSetupViewState();
}

class _LoginRemoteSetupViewState extends State<LoginRemoteSetupView> {
  final formKey = GlobalKey<FormBuilderState>();

  // local login data from the step before to check if the server is the same
  LocalLoginData? localLoginData;

  // remote login data
  RemoteLoginData? remoteLoginData;

  bool checkingConnection = false;
  bool obscureText = true;

  @override
  void initState() {
    localLoginData = LocalLoginData("192.168.178.49", "8080");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(paddingScaffold),
      child: Center(
          child: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Text("Step 2: Remote Setup",
                style: Theme.of(context).textTheme.headlineLarge),
            Gap(18),
            Text(
                "Add the credentials for the myOpenHAB Cloud to access your server remotely.",
                style: Theme.of(context).textTheme.bodyLarge),
            Gap(24),
            Gap(12),
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
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
              obscureText: obscureText,
              validator: FormBuilderValidators.required(),
              textInputAction: TextInputAction.next,
            ),
            Gap(8),
            BaseElevatedButton(
              onPressed: _testConnection,
              text: "Connect",
            ),
            Spacer(),
            _buildConnectedServer(context),
            Gap(16),
            BaseElevatedButton(
              onPressed: remoteLoginData != null
                  ? () {
                      _onNextPressed(context);
                    }
                  : null,
              text: "Next",
            ),
            Row(
              children: [
                Expanded(
                  child: BaseElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    text: "Back",
                  ),
                ),
                Gap(8),
                Expanded(
                  child: BaseElevatedButton(
                    onPressed: () {
                      context.pushNamed(LoginApiSetupView.routeName);
                    },
                    text: "Skip",
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    ));
  }

  Future<void> _onNextPressed(BuildContext context) async {
    // TODO: save local data

    context.pushNamed(LoginApiSetupView.routeName);
  }

  Future<void> _testConnection() async {
    if (!formKey.currentState!.saveAndValidate() || localLoginData == null) {
      return;
    }
    final Map<String, dynamic> values = formKey.currentState!.value;
    final String username = values['username'] as String;
    final String password = values['password'] as String;

    // Test connection
    final localApi = OpenHAB.create(
      baseUrl: Uri.parse(
          "http://${localLoginData!.host}:${localLoginData!.port}/rest"),
    );
    final remoteApi = OpenHAB.create(
        baseUrl: Uri.parse("https://myopenhab.org/rest"),
        interceptors: [
          LoginInterceptor(username, password),
        ]);

    setState(() {
      checkingConnection = true;
    });

    final localResult = await localApi.itemsGet();

    final remoteResult = await remoteApi.itemsGet();
    if (localResult.isSuccessful && remoteResult.isSuccessful) {
      final localResultItems = localResult.body;
      final remoteResultItems = remoteResult.body;

      // TODO: Anderer Check, ob beides gleich?
      if (localResultItems != null &&
          localResultItems.length == remoteResultItems?.length) {
        setState(() {
          remoteLoginData = RemoteLoginData(username, password);
        });
      } else {
        locator<SnackbarService>().showSnackbar(
            message: "Local and Remote Server are not the same.",
            type: SnackbarType.error);

        setState(() {
          remoteLoginData = null;
        });
      }
    } else {
      if (remoteResult.statusCode == 401) {
        locator<SnackbarService>().showSnackbar(
            message: "Wrong Credentials", type: SnackbarType.error);
      } else {
        locator<SnackbarService>().showSnackbar(
            message: "Connection failed.", type: SnackbarType.error);
      }

      setState(() {
        remoteLoginData = null;
      });
    }

    setState(() {
      checkingConnection = false;
    });
  }

  Widget _buildConnectedServer(BuildContext context) {
    return WidgetContainer(
        width: double.infinity,
        padding: EdgeInsets.all(paddingContainer),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            cloudIcon,
            color: cloudColor,
            size: 28,
          ),
          Gap(12),
          Builder(builder: (context) {
            if (checkingConnection) {
              return Text(
                "Checking Connection...",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }
            if (remoteLoginData == null) {
              return Text(
                "Not to Cloud connected",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            } else {
              return Text(
                "Cloud service connected",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }
          }),
        ]));
  }

  IconData get cloudIcon {
    if (checkingConnection) {
      return LineIconsV5.cloud_refresh_anticlockwise;
    } else {
      if (remoteLoginData != null) {
        return LineIconsV5.variantfreecloud_check_circle;
      } else {
        return LineIconsV5.cloud_xmark_circle;
      }
    }
  }

  Color get cloudColor {
    if (checkingConnection) {
      return Colors.orange;
    } else {
      if (remoteLoginData != null) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
  }
}
