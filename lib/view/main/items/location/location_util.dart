import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:geocoding/geocoding.dart';

class OpenhabLocation {
  final LatLng latLng;
  final String itemName;

  final bool withNominatim;
  Placemark? nominatimResponse;

  final nominatimCompleter = Completer<void>();

  OpenhabLocation(
      {required this.itemName,
      required double latitude,
      required double longitude,
      this.withNominatim = false})
      : latLng = LatLng(latitude, longitude) {
    if (!withNominatim) {
      return;
    }
    // Perform reverse geocoding
    placemarkFromCoordinates(latitude, longitude).then((reverseResult) {
      nominatimResponse = reverseResult.firstOrNull;
      print("nominatim: ${nominatimResponse?.name}");
      nominatimCompleter.complete();
    });
  }

  factory OpenhabLocation.fromItemState(
      String state, String name, bool withNominatim) {
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
      return OpenhabLocation(
          itemName: name, latitude: 0, longitude: 0, withNominatim: false);
    }
  }
}
