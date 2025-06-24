import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_marker_popup_plus/extension_api.dart';
import 'package:flutter_map_marker_popup_plus/flutter_map_marker_popup_plus.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/icons/icons.dart';
import 'location_util.dart';

// TODO: Maybe add a button where i can center back to the location?
// TODO: Edit location via new marker

class OpenhabMapWidget extends StatelessWidget {
  final OpenhabLocation location;
  final ColorScheme colorScheme;
  final bool showPopupInitial;
  final PopupBuilder? popupBuilder;

  const OpenhabMapWidget(
      {super.key,
      required this.location,
      required this.colorScheme,
      this.showPopupInitial = true, this.popupBuilder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCachePath(),
        builder: (context, future) {
          if (!future.hasData) {
            return const SizedBox.shrink();
          }
          final marker = Marker(
            point: location.latLng,
            width: 40,
            height: 40,
            child: Icon(
              LineIconsFilled.map_marker,
              size: 40,
              color: colorScheme.primary,
            ),
          );
          return FlutterMap(
              options: MapOptions(
                initialCenter: location.latLng,
                initialZoom: 16.0,
                keepAlive: true,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  tileProvider: CachedTileProvider(
                    // maxStale keeps the tile cached for the given Duration and
                    // tries to revalidate the next time it gets requested
                    maxStale: const Duration(days: 30),
                    store: HiveCacheStore(
                      future.data!,
                      hiveBoxName: 'flutter_map_cache',
                    ),
                  ),
                ),
                PopupMarkerLayer(
                  options: PopupMarkerLayerOptions(
                      initiallySelected: [
                        if (showPopupInitial)
                          PopupSpec(
                            marker: marker,
                          )
                      ],
                      markers: [
                        marker
                      ],
                      popupDisplayOptions: PopupDisplayOptions(
                        builder: popupBuilder
                            ?? (_, __) => const SizedBox.shrink(),
                      )),
                ),
                RichAttributionWidget(
                  animationConfig: const ScaleRAWA(),
                  // Or `FadeRAWA` as is default
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ]);
        });
  }

  Future<String> getCachePath() async {
    final cacheDirectory = await getTemporaryDirectory();
    return cacheDirectory.path;
  }
}
