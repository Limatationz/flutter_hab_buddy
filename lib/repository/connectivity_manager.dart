import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/io_client.dart' as http_io;
import 'package:http/http.dart' as http;
import 'dart:io';

import '../core/database/login/login_data.dart';
import '../core/network/generated/openHAB.swagger.dart';
import '../core/network/interceptors/api_auth_interceptor.dart';
import '../core/network/interceptors/basic_auth_interceptor.dart';
import '../core/network/interceptors/cloud_auth_interceptor.dart';
import '../core/network/interceptors/remote_basic_auth_interceptor.dart';
import '../generated/l10n.dart';
import '../locator.dart';
import '../util/icons/icons.dart';

class ConnectivityManager {
  final _log = Logger();

  final connectivity = Connectivity();

  // Connection Status
  final BehaviorSubject<ServerConnectionState> _connectionStateSubject =
      BehaviorSubject.seeded(ServerConnectionState.offline);

  Stream<ServerConnectionState> get connectionStateStream =>
      _connectionStateSubject.stream;

  ServerConnectionState get connectionState => _connectionStateSubject.value;

  // SSE data
  Stream<SSEModel>? _sseDataStream;
  StreamController<SSEModel> _sseStateStreamController =
      StreamController.broadcast();

  Stream<SSEModel> get sseStateStream =>
      _sseStateStreamController.stream.whereNotNull();

  final BehaviorSubject<DateTime?> _sseLastConnection =
      BehaviorSubject.seeded(null);

  Stream<DateTime?> get sseLastConnection => _sseLastConnection.stream;

  final BehaviorSubject<DateTime?> _sseLastMessage =
      BehaviorSubject.seeded(null);

  Stream<DateTime?> get sseLastMessage => _sseLastMessage.stream;

  // Base Url
  String _baseUrl = "";

  String get baseUrl => _baseUrl;

  // interceptors
  final ApiAuthInterceptor _apiAuthInterceptor;
  final CloudAuthInterceptor _cloudAuthInterceptor;
  final RemoteBasisAuthInterceptor _remoteBasicAuthInterceptor;

  Completer<bool> firstConnectionComplete;

  ConnectivityManager(
      Stream<LoginData?> loginDataStream, this.firstConnectionComplete)
      : _apiAuthInterceptor = ApiAuthInterceptor(loginDataStream),
        _cloudAuthInterceptor = CloudAuthInterceptor(loginDataStream),
        _remoteBasicAuthInterceptor =
            RemoteBasisAuthInterceptor(loginDataStream) {
    _updateApi(ServerConnectionState.offline, "");
    asyncInit(loginDataStream);

    _sseStateStreamController.stream.listen((_) {
      _sseLastMessage.add(DateTime.now());
    });
  }

  asyncInit(Stream<LoginData?> loginDataStream) async {
    final currentConnectionStatus = await connectivity.checkConnectivity();

    // listen to login changes
    loginDataStream.listen((e) {
      _updateBestConnectivity(e);
    });

    // listen to connectivity changes
    connectivity.onConnectivityChanged
        .startWith(currentConnectionStatus)
        .withLatestFrom(loginDataStream, (c, l) => (c, l))
        .listen((e) {
      _updateBestConnectivity(e.$2);
    });
  }

  // Update Chopper client with the best available base URL
  Future<void> _updateBestConnectivity(LoginData? loginData) async {
    if (loginData != null) {
      final http.Client testClient = http_io.IOClient(
        HttpClient()
          ..connectionTimeout = const Duration(seconds: 5)
          ..idleTimeout = const Duration(seconds: 5),
      );

      // Test connections in priority order
      if (await _testLocalConnection(loginData.localLoginData, testClient)) {
        _log.d('Local Connection Test successful');
        return;
      }
      if (loginData.hasRemoteLogin &&
          await _testRemoteConnection(loginData.remoteLoginData!, testClient)) {
        _log.d('Remote Connection Test successful');
        return;
      }
      if (loginData.hasCloudLogin &&
          await _testCloudConnection(loginData.cloudLoginData!, testClient)) {
        _log.d('Cloud Connection Test successful');
        return;
      }
    }

    // Fallback to offline state
    _updateApi(ServerConnectionState.offline, "");
    _connectionStateSubject.add(ServerConnectionState.offline);
  }

  Future<bool> _testLocalConnection(
      LocalLoginData loginData, http.Client client) async {
    final testApi = OpenHAB.create(
      client: ChopperClient(
          converter: $JsonSerializableConverter(),
          client: client,
          baseUrl: Uri.parse(loginData.url)),
    );

    try {
      final rootBean = await testApi.get();

      if (rootBean.isSuccessful &&
          connectionState != ServerConnectionState.local) {
        _updateApi(ServerConnectionState.local, loginData.url);
        _updateSSEConnection(loginData.url);
        _baseUrl = loginData.url;
        _connectionStateSubject.add(ServerConnectionState.local);
        return true;
      }
    } catch (e, s) {
      _log.e("Error while testing local Connection", error: e, stackTrace: s);
    }

    return false;
  }

  Future<bool> _testRemoteConnection(
      RemoteLoginData loginData, http.Client client) async {
    final testApi = OpenHAB.create(
      client: ChopperClient(
          client: client,
          baseUrl: Uri.parse(loginData.url),
          converter: $JsonSerializableConverter(),
          interceptors: [
            if (loginData.hasBasicAuth)
              BasicAuthInterceptor(
                  loginData.basicAuthUsername!, loginData.basicAuthPassword!)
          ]),
    );

    try {
      final rootBean = await testApi.get();

      if (rootBean.isSuccessful &&
          connectionState != ServerConnectionState.remote) {
        _updateApi(ServerConnectionState.remote, loginData.url,
            remoteBasicAuth: loginData.hasBasicAuth);
        _updateSSEConnection(loginData.fullUrl,
            basicAuthUsername: loginData.basicAuthUsername,
            basicAuthPassword: loginData.basicAuthPassword);
        _baseUrl = loginData.fullUrl;
        _connectionStateSubject.add(ServerConnectionState.remote);
        return true;
      }
    } catch (e, s) {
      _log.e("Error while testing remote Connection", error: e, stackTrace: s);
    }

    return false;
  }

  Future<bool> _testCloudConnection(
      CloudLoginData loginData, http.Client client) async {
    final testApi = OpenHAB.create(
        client: ChopperClient(
            client: client,
            converter: $JsonSerializableConverter(),
            baseUrl: Uri.parse("https://myopenhab.org/rest"),
            interceptors: [
          BasicAuthInterceptor(loginData.username, loginData.password)
        ]));

    try {
      final rootBean = await testApi.get();

      if (rootBean.isSuccessful &&
          connectionState != ServerConnectionState.cloud) {
        _updateApi(
          ServerConnectionState.cloud,
          "https://myopenhab.org/rest",
        );
        _updateSSEConnection("https://myopenhab.org/rest",
            basicAuthUsername: loginData.username,
            basicAuthPassword: loginData.password);
        _baseUrl = "https://myopenhab.org/rest";
        _connectionStateSubject.add(ServerConnectionState.cloud);
        return true;
      }
    } catch (e, s) {
      _log.e("Error while testing cloud Connection", error: e, stackTrace: s);
    }

    return false;
  }

  void _updateApi(ServerConnectionState newState, String baseUrl,
      {bool remoteBasicAuth = false}) {
    final newApi = OpenHAB.create(baseUrl: Uri.parse(baseUrl), interceptors: [
      if (newState != ServerConnectionState.offline) _apiAuthInterceptor,
      if (newState == ServerConnectionState.remote && remoteBasicAuth)
        _remoteBasicAuthInterceptor,
      if (newState == ServerConnectionState.cloud) _cloudAuthInterceptor
    ]);

    // Unregister the old OpenHAB instance
    if (locator.isRegistered<OpenHAB>()) {
      locator.unregister<OpenHAB>();
    }

    // Register the new OpenHAB instance
    locator.registerSingleton<OpenHAB>(newApi);

    if (newState != ServerConnectionState.offline &&
        firstConnectionComplete.isCompleted == false) {
      firstConnectionComplete.complete(true);
    }

    _log.i("Updated Connection State to $newState");
  }

  void _updateSSEConnection(
    String baseUrl, {
    String? basicAuthUsername,
    String? basicAuthPassword,
  }) {
    _sseDataStream = SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: '$baseUrl/events?topics=*/items/*/statechanged',
      oldStreamController: _sseStateStreamController,
      header: basicAuthUsername != null && basicAuthPassword != null
          ? generateBasicAuth(
              basicAuthUsername,
              basicAuthPassword,
            )
          : {},
    );

    _sseLastConnection.add(DateTime.now());
  }

  Map<String, String> generateBasicAuth(String username, String password) {
    final bytes = utf8.encode("$username:$password");
    final base64Str = base64.encode(bytes);
    return {"Authorization": "Basic $base64Str"};
  }

  void reset() {
    firstConnectionComplete = Completer<bool>();

    _connectionStateSubject.add(ServerConnectionState.offline);
    _sseLastConnection.add(null);
    _sseLastMessage.add(null);
    _sseDataStream = null;
    _sseStateStreamController.close();
    _sseStateStreamController = StreamController.broadcast();

    _baseUrl = "";
  }
}

enum ServerConnectionState {
  local,
  remote,
  cloud,
  offline;

  IconData get icon {
    switch (this) {
      case ServerConnectionState.local:
        return LineIconsV5.server_wifi;
      case ServerConnectionState.remote:
        return LineIconsV5.server_1;
      case ServerConnectionState.cloud:
        return LineIconsV5.cloud_wifi;
      case ServerConnectionState.offline:
        return LineIconsV5.wifi_disabled;
    }
  }

  String get name {
    switch (this) {
      case ServerConnectionState.local:
        return S.current.serverConnectionStateLocal;
      case ServerConnectionState.remote:
        return S.current.serverConnectionStateRemote;
      case ServerConnectionState.cloud:
        return S.current.serverConnectionStateCloud;
      case ServerConnectionState.offline:
        return S.current.serverConnectionStateOffline;
    }
  }

  Color get color {
    switch (this) {
      case ServerConnectionState.local:
      case ServerConnectionState.remote:
      case ServerConnectionState.cloud:
        return Colors.green;
      case ServerConnectionState.offline:
        return Colors.red;
    }
  }
}
