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
  final _loginRepository = locator<LoginRepository>();
  final formKey = GlobalKey<FormBuilderState>();
  final MDnsClient client = MDnsClient();
  final multicastLock = MulticastLock();

  // found openhab servers via MDNS
  List<ServerScanResult> scanResults = [];
  bool isScanning = false;

  LocalLoginData? localLoginData;
  RootBean? rootBean;
  bool checkingConnection = false;

  Future<void> discoverOpenHABServers() async {
    // clear results
    setState(() {
      scanResults = [];
      isScanning = true;
    });

    // Acquire the multicast lock on Android
    if (Platform.isAndroid) {
      multicastLock.acquire();
    }

    Set<(String, String)> servers = {};

    try {
      // Start the client
      await client.start();

      // Query for OpenHAB servers (_openhab-server._tcp.local.)
      await for (final PtrResourceRecord ptr in client.lookup<
              PtrResourceRecord>(
          ResourceRecordQuery.serverPointer('_openhab-server._tcp.local'))) {
        // Get additional information about the service
        await for (final SrvResourceRecord srv
            in client.lookup<SrvResourceRecord>(
                ResourceRecordQuery.service(ptr.domainName))) {
          // Retrieve the IP address for the host
          await for (final IPAddressResourceRecord ip
              in client.lookup<IPAddressResourceRecord>(
                  ResourceRecordQuery.addressIPv4(srv.target))) {
            print('Found OpenHAB server: ${ip.address}:${srv.port}');
            servers.add((ip.address.host, srv.port.toString()));
          }
        }
      }
    } catch (e) {
      print('Error: $e');
      locator<SnackbarService>().showSnackbar(
          message:
              "An Error occurred while scanning. Please try the manual setup.",
          type: SnackbarType.error);
    } finally {
      // Stop the client
      client.stop();
      if (Platform.isAndroid) {
        multicastLock.release();
      }
    }

    if (servers.isNotEmpty) {
      // now we want to check the servers if they are openhab servers by getting the rootBean
      for (var server in servers) {
        final client = OpenHAB.create(
          baseUrl: Uri.parse("http://${server.$1}:${server.$2}/rest"),
        );
        try {
          final result = await client.get();
          if (result.isSuccessful && result.body != null) {
            setState(() {
              scanResults
                  .add(ServerScanResult(server.$1, server.$2, result.body!));
            });
          }
        } catch (e) {
          print('Error: $e');
        }
      }
    } else {
      // no servers found
      locator<SnackbarService>().showSnackbar(
          message: "No OpenHAB servers found. Please try the manual setup.",
          type: SnackbarType.error);
    }

    setState(() {
      isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(paddingScaffold),
          child: FormBuilder(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: ListView(children: [
                Text("Step 1: Local Setup",
                    style: Theme.of(context).textTheme.headlineLarge),
                const Gap(18),
                Text("Connect the App to your local OpenHAB server.",
                    style: Theme.of(context).textTheme.bodyLarge),
                const Gap(24),
                BaseElevatedButton(
                  onPressed: !isScanning
                      ? () {
                          discoverOpenHABServers();
                        }
                      : null,
                  text: "Scan Network",
                ),
                _buildScanningIndicator(context),
                _buildServerSearchResults(context),
                const Gap(12),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Gap(12),
                    Text("Or add manually"),
                    Gap(12),
                    Expanded(child: Divider())
                  ],
                ),
                const Gap(12),
                FormBuilderTextField(
                  name: "ipAddress",
                  decoration: const InputDecoration(labelText: "IP Address"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.ip(),
                  ]),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const Gap(8),
                FormBuilderTextField(
                  name: "port",
                  decoration: const InputDecoration(labelText: "Port"),
                  initialValue: "8080",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ]),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                ),
                const Gap(8),
                BaseElevatedButton(
                  onPressed: _testConnection,
                  text: "Connect",
                ),
                ])),
                _buildConnectedServer(context),
                const Gap(16),
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
    );
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
    try {
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
    } on HandshakeException catch (e) {
      // was an SSL error
      locator<SnackbarService>().showSnackbar(
          message: "Connection failed. Try the not ssl protected port.",
          type: SnackbarType.error);
    } catch (e) {
      if (port == "8443") {
        locator<SnackbarService>().showSnackbar(
            message: "Connection failed. Try the not ssl protected port.",
            type: SnackbarType.error);
      } else {
        locator<SnackbarService>().showSnackbar(
            message: "Connection failed. Please try again.",
            type: SnackbarType.error);
      }
    }

    setState(() {
      checkingConnection = false;
    });
  }

  Future<void> _onNextPressed(BuildContext context) async {
    final result =
        await _loginRepository.storeLocalLogin(localLoginData: localLoginData!);
    if (result) {
      context.pushNamed(LoginRemoteSetupView.routeName);
    } else {
      locator<SnackbarService>().showSnackbar(
          message: "Failed to store local data. Please try again.",
          type: SnackbarType.error);
    }
  }

  Widget _buildConnectedServer(BuildContext context) {
    return WidgetContainer(
        width: double.infinity,
        child: Row(children: [
          Icon(
            serverIcon,
            color: serverColor,
            size: 28,
          ),
          const Gap(12),
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
                      Text(
                          "Version: ${rootBean?.runtimeInfo?.version} (${rootBean?.runtimeInfo?.buildString ?? "-"})")
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

  Widget _buildServerSearchResults(BuildContext context) {
    if (scanResults.isEmpty) {
      return Container();
    } else {
      return Padding(
          padding: const EdgeInsets.only(top: listSpacing),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: listSpacing,
              children: scanResults
                  .map((server) => Builder(builder: (context) {
                        final isSelected =
                            server.host == localLoginData?.host &&
                                server.port == localLoginData?.port;
                        return GestureDetector(
                            onTap: isSelected
                                ? null
                                : () {
                                    _onServerSelected(context, server);
                                  },
                            child: WidgetContainer(
                                padding: const EdgeInsets.all(12),
                                child: Row(children: [
                                  Icon(
                                    isSelected
                                        ? LineIconsV5.server_check_circle
                                        : LineIconsV5.server_question,
                                    color: isSelected ? Colors.green : null,
                                    size: 28,
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${server.host} : ${server.port}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          overflow: TextOverflow.fade,
                                        ),
                                        Text(
                                            "Version: ${server.rootBean.runtimeInfo?.version} (${server.rootBean.runtimeInfo?.buildString ?? "-"})")
                                      ],
                                    ),
                                  ),
                                  if (!isSelected)
                                    const Icon(
                                      LineIconsV5.chevron_right,
                                      size: 28,
                                    )
                                ])));
                      }))
                  .toList()));
    }
  }

  Widget _buildScanningIndicator(BuildContext context) {
    if (!isScanning) return Container();
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      child: const CircularProgressIndicator(),
    );
  }

  void _onServerSelected(BuildContext context, ServerScanResult scanResults) {
    setState(() {
      localLoginData = LocalLoginData(scanResults.host, scanResults.port);
      rootBean = scanResults.rootBean;
    });
  }
}

class ServerScanResult {
  final String host;
  final String port;
  final RootBean rootBean;

  ServerScanResult(this.host, this.port, this.rootBean);
}
