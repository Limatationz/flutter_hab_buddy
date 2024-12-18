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
import '../../core/network/interceptors/ApiInterceptor.dart';
import '../../core/network/interceptors/LoginInterceptor.dart';
import '../../core/services/snackbar_service.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../repository/login_repository.dart';
import '../../util/icons/icons.dart';
import '../main/favourite/favourite_view.dart';
import '../util/constants.dart';
import '../util/general/base_elevated_button.dart';
import '../util/general/widget_container.dart';

class LoginApiSetupView extends StatefulWidget {
  static const String routePath = '/login-api-setup';
  static const String routeName = 'LoginApiSetupView';

  const LoginApiSetupView({Key? key}) : super(key: key);

  @override
  State<LoginApiSetupView> createState() => _LoginApiSetupViewState();
}

class _LoginApiSetupViewState extends State<LoginApiSetupView> {
  final formKey = GlobalKey<FormBuilderState>();

  // local login data from the step before to check if the server is the same
  LocalLoginData? localLoginData;

  // remote login data
  ApiLoginData? apiLoginData;

  bool checkingConnection = false;

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
            Text("Step 3: Api Setup",
                style: Theme.of(context).textTheme.headlineLarge),
            Gap(18),
            Text(
                "To enable some features, we need more permissions. More text bla bla.",
                style: Theme.of(context).textTheme.bodyLarge),
            Gap(24),
            Gap(12),
            FormBuilderTextField(
              name: "token",
              decoration: InputDecoration(
                label: Text("Api Token"),
              ),
              keyboardType: TextInputType.multiline,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
              textInputAction: TextInputAction.done,
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
              onPressed: apiLoginData != null
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
                      context.goNamed(FavouriteView.routeName);
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

    context.pushNamed(FavouriteView.routeName);
  }

  Future<void> _testConnection() async {
    if (!formKey.currentState!.saveAndValidate()) {
      return;
    }
    final Map<String, dynamic> values = formKey.currentState!.value;
    final String apiToken = values['token'] as String;

    // Test connection
    final localApi = OpenHAB.create(
        baseUrl: Uri.parse(
            "http://${localLoginData!.host}:${localLoginData!.port}/rest"),
        interceptors: [ApiInterceptor(apiToken)]);

    setState(() {
      checkingConnection = true;
    });

    final result = await localApi.rulesGet();

    if (result.isSuccessful) {
      setState(() {
        apiLoginData = ApiLoginData(apiToken);
      });
    } else {
      if (result.statusCode == 401) {
        locator<SnackbarService>()
            .showSnackbar(message: "Token invalid", type: SnackbarType.error);
        // formKey.currentState?.reset();
      } else {
        locator<SnackbarService>().showSnackbar(
            message: "Connection failed.", type: SnackbarType.error);
      }

      setState(() {
        apiLoginData = null;
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
            if (apiLoginData == null) {
              return Text(
                "No Api token",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            } else {
              return Text(
                "Api Token valid",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }
          }),
        ]));
  }

  IconData get cloudIcon {
    if (checkingConnection) {
      return LineIconsV5.database_refresh;
    } else {
      if (apiLoginData != null) {
        return LineIconsV5.database_check_circle;
      } else {
        return LineIconsV5.database_xmark_circle;
      }
    }
  }

  Color get cloudColor {
    if (checkingConnection) {
      return Colors.orange;
    } else {
      if (apiLoginData != null) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
  }
}
