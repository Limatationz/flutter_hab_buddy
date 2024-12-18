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
import '../../core/services/snackbar_service.dart';
import '../../locator.dart';
import '../../repository/login_repository.dart';
import '../../util/icons/icons.dart';
import '../util/constants.dart';
import '../util/general/base_elevated_button.dart';
import '../util/general/widget_container.dart';
import 'login_remote_setup_view.dart';

class LoginLocalSetupView extends StatefulWidget {
  static const String routePath = '/login-local-setup';
  static const String routeName = 'LoginLocalSetupView';

  const LoginLocalSetupView({Key? key}) : super(key: key);

  @override
  State<LoginLocalSetupView> createState() => _LoginLocalSetupViewState();
}

class _LoginLocalSetupViewState extends State<LoginLocalSetupView> {
  final formKey = GlobalKey<FormBuilderState>();
  final MDnsClient client = MDnsClient();

  LocalLoginData? localLoginData;
  RootBean? rootBean;
  bool checkingConnection = false;

  Future<void> discoverOpenHABServers() async {
    final multicastLock = MulticastLock();
    multicastLock.acquire();

    // Create an mDNS client
    final MDnsClient client = MDnsClient();

    try {
      // Start the client
      await client.start();

      // Query for OpenHAB servers (_openhab._tcp.local.)
      await for (final PtrResourceRecord ptr
          in client.lookup<PtrResourceRecord>(
              ResourceRecordQuery.serverPointer('_openhab._tcp.local'))) {
        // Get additional information about the service
        await for (final SrvResourceRecord srv
            in client.lookup<SrvResourceRecord>(
                ResourceRecordQuery.service(ptr.domainName))) {
          // Retrieve the IP address for the host
          await for (final IPAddressResourceRecord ip
              in client.lookup<IPAddressResourceRecord>(
                  ResourceRecordQuery.addressIPv4(srv.target))) {
            print('Found OpenHAB server: ${ip.address}:${srv.port}');
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      // Stop the client
      client.stop();
      multicastLock.release();
    }
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
            Text("Step 1: Local Setup",
                style: Theme.of(context).textTheme.headlineLarge),
            Gap(18),
            Text("Connect the App to your local OpenHAB server.",
                style: Theme.of(context).textTheme.bodyLarge),
            Gap(24),
            BaseElevatedButton(
              onPressed: () {
                discoverOpenHABServers();
              },
              text: "Scan Network - TO BE IMPLEMENTED",
            ),
            Gap(12),
            Row(
              children: [
                Expanded(child: Divider()),
                Gap(12),
                Text("Or add manually"),
                Gap(12),
                Expanded(child: Divider())
              ],
            ),
            Gap(12),
            FormBuilderTextField(
              name: "ipAddress",
              decoration: InputDecoration(labelText: "IP Address"),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.ip(),
              ]),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            Gap(8),
            FormBuilderTextField(
              name: "port",
              decoration: InputDecoration(labelText: "Port"),
              initialValue: "8080",
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
              ]),
              keyboardType: TextInputType.number,
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
              onPressed: localLoginData != null
                  ? () {
                      _onNextPressed(context);
                    }
                  : null,
              text: "Next",
            ),
          ],
        ),
      )),
    ));
  }

  Future<void> _testConnection() async {
    if (!formKey.currentState!.saveAndValidate()) {
      return;
    }
    final Map<String, dynamic> values = formKey.currentState!.value;
    final String ipAddress = values['ipAddress'] as String;
    final String port = values['port'] as String;

    // Test connection
    final client = OpenHAB.create(
      baseUrl: Uri.parse("http://$ipAddress:$port/rest"),
    );

    setState(() {
      checkingConnection = true;
    });

    final result = await client.get();
    if (result.isSuccessful) {
      setState(() {
        localLoginData = LocalLoginData(ipAddress, port);
        rootBean = result.body;
      });
    } else {
      locator<SnackbarService>().showSnackbar(
          message: "Connection failed.", type: SnackbarType.error);

      setState(() {
        localLoginData = null;
        rootBean = null;
      });
    }

    setState(() {
      checkingConnection = false;
    });
  }

  Future<void> _onNextPressed(BuildContext context) async {
    // TODO: save local data

    context.pushNamed(LoginRemoteSetupView.routeName);
  }

  Widget _buildConnectedServer(BuildContext context) {
    return WidgetContainer(
        width: double.infinity,
        padding: EdgeInsets.all(paddingContainer),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            serverIcon,
            color: serverColor,
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
            if (localLoginData == null) {
              return Text(
                "No Server connected",
                style: Theme.of(context).textTheme.bodyLarge,
              );
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${localLoginData!.host} : ${localLoginData!.port}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (rootBean != null)
                      Text("Version: ${rootBean?.runtimeInfo?.version}")
                  ]);
            }
          }),
        ]));
  }

  IconData get serverIcon {
    if (checkingConnection) {
      return LineIconsV5.server_refresh;
    } else {
      if (localLoginData != null) {
        return LineIconsV5.server_check_circle;
      } else {
        return LineIconsV5.server_xmark_circle;
      }
    }
  }

  Color get serverColor {
    if (checkingConnection) {
      return Colors.orange;
    } else {
      if (localLoginData != null) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
  }
}
