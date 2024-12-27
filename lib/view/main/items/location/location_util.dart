import 'dart:async';

import 'package:intl/intl_standalone.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:nominatim_flutter/model/request/reverse_request.dart';
import 'package:nominatim_flutter/model/response/response.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

class OpenhabLocation {
  final LatLng latLng;
  final String itemName;

  final bool withNominatim;
  NominatimResponse? nominatimResponse;

  final nominatimCompleter = Completer<void>();

  OpenhabLocation(
      {required this.itemName,
      required double latitude,
      required double longitude, this.withNominatim = false})
      : latLng = LatLng(latitude, longitude) {
    if (!withNominatim) {
      return;
    }
    // Perform reverse geocoding
    findSystemLocale().then((locale) {
      final reverseRequest = ReverseRequest(
        lat: latitude,
        lon: longitude,
      );

      NominatimFlutter.instance
          .reverse(
        reverseRequest: reverseRequest,
        language: locale,
      )
          .then((reverseResult) {
        nominatimResponse = reverseResult;
        print("nominatim: ${nominatimResponse?.name}");
        nominatimCompleter.complete();
      });
    });
  }

  factory OpenhabLocation.fromItemState(String state, String name, bool withNominatim) {
    final splitted = state.split(',');
    if (splitted.length == 2) {
      return OpenhabLocation(
        itemName: name,
        latitude: double.parse(splitted[0]),
        longitude: double.parse(splitted[1]),
        withNominatim: withNominatim,
      );
    } else {
      Logger().w('Invalid location state: $state');
      return OpenhabLocation(itemName: name, latitude: 0, longitude: 0, withNominatim: false);
    }
  }
}
