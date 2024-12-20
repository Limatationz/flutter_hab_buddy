import 'dart:io';

import 'package:android_multicast_lock/android_multicast_lock.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/database/login/login_data.dart';
import '../../core/network/generated/client_index.dart';
import '../../core/network/generated/openHAB.swagger.dart';
import '../../core/network/interceptors/basic_auth_interceptor.dart';
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
  final _loginRepository = locator<LoginRepository>();
  final _cloudFormKey = GlobalKey<FormBuilderState>();
  final _serverFormKey = GlobalKey<FormBuilderState>();

  HttpClient _testClient = HttpClient();

  // local login data from the step before to check if the server is the same
  LocalLoginData? localLoginData;

  // cloud login
  CloudLoginData? cloudLoginData;
  bool checkingCloudConnection = false;
  bool obscureText = true;

  // remote login
  RemoteLoginData? remoteLoginData;
  bool checkingRemoteConnection = false;
  bool showRemoteBasicAuth = false;
  bool obscureBasicAuthPassword = true;

  @override
  void initState() {
    final localLoginData = _loginRepository.localLoginData;
    if (localLoginData == null) {
      // TODO: was machen wir hier?
    } else {
      this.localLoginData = localLoginData;
    }

    _testClient.connectionTimeout = Duration(seconds: 5);
    _testClient.idleTimeout = Duration(seconds: 5);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(paddingScaffold),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: ListView(children: [
              Text("Step 2: Remote Setup",
                  style: Theme.of(context).textTheme.headlineLarge),
              const Gap(largePadding),
              Text("Step 2.1: Remote Server",
                  style: Theme.of(context).textTheme.headlineLarge),
              const Gap(largePadding),
              Text(
                  "Add an url where your server can be accessed from the internet. The server must support the OpenHAB API.",
                  style: Theme.of(context).textTheme.bodyLarge),
              const Gap(extraLargePadding),
              Flexible(
                  child: FormBuilder(
                      key: _serverFormKey,
                      child: Column(children: [
                        FormBuilderTextField(
                          name: "url",
                          initialValue: "https://",
                          decoration: InputDecoration(
                            label: Text("Url"),
                            hintText:
                                "Has to start with 'https://' or 'http://'",
                          ),
                          keyboardType: TextInputType.url,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.url(
                                protocols: ["https", "http"]),
                          ]),
                          textInputAction: TextInputAction.next,
                        ),
                        const Gap(12),
                        FormBuilderTextField(
                          name: "port",
                          decoration: InputDecoration(
                            label: Text("Port"),
                          ),
                          validator: FormBuilderValidators.numeric(
                              checkNullOrEmpty: false),
                          textInputAction: TextInputAction.done,
                        ),
                        const Gap(12),
                        FormBuilderSwitch(
                            name: "basicAuthEnabled",
                            initialValue: showRemoteBasicAuth,
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  showRemoteBasicAuth = newValue;
                                });
                              }
                            },
                            title: Text(
                              "Basic Auth enabled",
                              style: TextTheme.of(context).bodyLarge,
                            )),
                        _serverBasicAuthInputView(context),
                        const Gap(8),
                        BaseElevatedButton(
                          onPressed: _testRemoteConnection,
                          text: "Connect",
                        ),
                      ]))),
              const Gap(extraLargePadding),
              Text("Step 2.2: MyOpenHAB Cloud",
                  style: Theme.of(context).textTheme.headlineLarge),
              const Gap(largePadding),
              Text(
                  "Add the credentials for the myOpenHAB Cloud to access your server remotely.",
                  style: Theme.of(context).textTheme.bodyLarge),
              const Gap(extraLargePadding),
              Flexible(
                  child: FormBuilder(
                      key: _cloudFormKey,
                      child: Column(children: [
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
                        ),
                        const Gap(8),
                        BaseElevatedButton(
                          onPressed: _testCloudConnection,
                          text: "Connect",
                        ),
                      ]))),
            ])),
            Gap(largePadding),
            _buildCloudConnectedServer(context),
            Gap(smallPadding),
            _buildRemoteConnectedServer(context),
            const Gap(16),
            BaseElevatedButton(
              onPressed: cloudLoginData != null
                  ? () {
                      _onNextPressed(context);
                    }
                  : null,
              text: "Next",
            ),
            const Gap(smallPadding),
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
                const Gap(smallPadding),
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
      ),
    );
  }

  Future<void> _onNextPressed(BuildContext context) async {
    final result =
        await _loginRepository.storeCloudLogin(cloudLoginData: cloudLoginData!);
    if (result) {
      context.pushNamed(LoginApiSetupView.routeName);
    } else {
      locator<SnackbarService>().showSnackbar(
          message: "Failed to store remote data. Please try again.",
          type: SnackbarType.error);
    }
  }

  Future<void> _testCloudConnection() async {
    if (!_cloudFormKey.currentState!.saveAndValidate() ||
        localLoginData == null) {
      return;
    }
    final Map<String, dynamic> values = _cloudFormKey.currentState!.value;
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
          BasicAuthInterceptor(username, password),
        ]);

    setState(() {
      checkingCloudConnection = true;
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
          cloudLoginData = CloudLoginData(username, password);
        });
      } else {
        locator<SnackbarService>().showSnackbar(
            message: "Local and Remote Server are not the same.",
            type: SnackbarType.error);

        setState(() {
          cloudLoginData = null;
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
        cloudLoginData = null;
      });
    }

    setState(() {
      checkingCloudConnection = false;
    });
  }

  Future<void> _testRemoteConnection() async {
    if (!_serverFormKey.currentState!.saveAndValidate() ||
        localLoginData == null) {
      return;
    }
    final Map<String, dynamic> values = _serverFormKey.currentState!.value;
    final String host = values['url'] as String;

    String? port = values['port'] as String?;
    if (port?.isEmpty ?? true) {
      port = null;
    }

    String? basicAuthUsername = values['basicAuthUsername'] as String?;
    if (basicAuthUsername?.isEmpty ?? true) {
      basicAuthUsername = null;
    }

    String? basicAuthPassword = values['basicAuthPassword'] as String?;
    if (basicAuthPassword?.isEmpty ?? true) {
      basicAuthPassword = null;
    }

    // Test connection
    String portString = port != null ? ":$port" : "";
    final localApi = OpenHAB.create(
      baseUrl: Uri.parse(
          "http://${localLoginData!.host}:${localLoginData!.port}/rest"),
    );
    final remoteApi = OpenHAB.create(
        baseUrl: Uri.parse("$host$portString/rest"),
        interceptors: [
          if ((basicAuthPassword != null) && (basicAuthUsername != null))
            BasicAuthInterceptor(basicAuthUsername, basicAuthPassword)
        ]);

    setState(() {
      checkingRemoteConnection = true;
    });

    try {
      final localResult = await localApi.itemsGet();

      final remoteResult = await remoteApi.itemsGet();
      if (localResult.isSuccessful && remoteResult.isSuccessful) {
        final localResultItems = localResult.body;
        final remoteResultItems = remoteResult.body;

        // TODO: Anderer Check, ob beides gleich?
        if (localResultItems != null &&
            localResultItems.length == remoteResultItems?.length) {
          setState(() {
            remoteLoginData = RemoteLoginData(host,
                port: port?.isNotEmpty ?? false ? port : null);
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
          locator<SnackbarService>()
              .showSnackbar(message: "Not Allowed", type: SnackbarType.error);
        } else {
          locator<SnackbarService>().showSnackbar(
              message: "Connection failed.", type: SnackbarType.error);
        }

        setState(() {
          remoteLoginData = null;
        });
      }
    } catch (e) {
      // catch network error ...
      setState(() {
        remoteLoginData = null;
      });
      locator<SnackbarService>().showSnackbar(
          message: "Error connecting to server.", type: SnackbarType.error);
    }

    setState(() {
      checkingRemoteConnection = false;
    });
  }

  Widget _buildCloudConnectedServer(BuildContext context) {
    return WidgetContainer(
        width: double.infinity,
        padding: const EdgeInsets.all(paddingContainer),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            cloudIcon,
            color: cloudColor,
            size: 28,
          ),
          const Gap(12),
          Builder(builder: (context) {
            if (checkingCloudConnection) {
              return Text(
                "Checking Connection...",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }
            if (cloudLoginData == null) {
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

  Widget _buildRemoteConnectedServer(BuildContext context) {
    return WidgetContainer(
        width: double.infinity,
        padding: const EdgeInsets.all(paddingContainer),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            serverIcon,
            color: serverColor,
            size: 28,
          ),
          const Gap(12),
          Builder(builder: (context) {
            if (checkingRemoteConnection) {
              return Text(
                "Checking Connection...",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }
            if (remoteLoginData == null) {
              return Text(
                "Not to remote Server connected",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            } else {
              return Text(
                "Remote Server connected",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }
          }),
        ]));
  }

  IconData get cloudIcon {
    if (checkingCloudConnection) {
      return LineIconsV5.cloud_refresh_anticlockwise;
    } else {
      if (cloudLoginData != null) {
        return LineIconsV5.variantfreecloud_check_circle;
      } else {
        return LineIconsV5.cloud_xmark_circle;
      }
    }
  }

  Color get cloudColor {
    if (checkingCloudConnection) {
      return Colors.orange;
    } else {
      if (cloudLoginData != null) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
  }

  IconData get serverIcon {
    if (checkingRemoteConnection) {
      return LineIconsV5.server_refresh;
    } else {
      if (remoteLoginData != null) {
        return LineIconsV5.server_check_circle;
      } else {
        return LineIconsV5.server_xmark_circle;
      }
    }
  }

  Color get serverColor {
    if (checkingRemoteConnection) {
      return Colors.orange;
    } else {
      if (remoteLoginData != null) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
  }

  Widget _serverBasicAuthInputView(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          if (showRemoteBasicAuth) const Gap(mediumPadding),
          if (showRemoteBasicAuth)
            FormBuilderTextField(
              name: "basicAuthUsername",
              decoration: InputDecoration(
                label: Text(S.of(context).username),
              ),
              textInputAction: TextInputAction.next,
            ),
          if (showRemoteBasicAuth) const Gap(mediumPadding),
          if (showRemoteBasicAuth)
            FormBuilderTextField(
              name: "basicAuthPassword",
              decoration: InputDecoration(
                label: Text(S.of(context).password),
                suffixIcon: IconButton(
                  icon: Icon(
                      obscureBasicAuthPassword
                          ? LineIconsFilled.eye
                          : LineIconsFilled.eye_slash,
                      size: 22,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  onPressed: () {
                    setState(() {
                      obscureBasicAuthPassword = !obscureBasicAuthPassword;
                    });
                  },
                ),
              ),
              obscureText: obscureBasicAuthPassword,
              textInputAction: TextInputAction.done,
            ),
        ],
      ),
    );
  }
}
