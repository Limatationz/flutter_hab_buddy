import 'package:fetch_client/fetch_client.dart';
import 'package:http/http.dart' show Client;

Client getHttpClient() => FetchClient(mode: RequestMode.cors);
