import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../general/item_state_injector.dart';
import 'location_util.dart';
import 'openhab_map_widget.dart';

class LocationItemDialog extends StatefulWidget {
  final String itemName;
  final OpenhabLocation initialValue;
  final ColorScheme colorScheme;

  const LocationItemDialog(
      {super.key,
      required this.itemName,
      required this.initialValue,
      required this.colorScheme});

  @override
  State<LocationItemDialog> createState() => _LocationItemDialogState();
}

class _LocationItemDialogState extends State<LocationItemDialog> {
  final _itemRepository = locator<ItemRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  late OpenhabLocation location;

  @override
  void initState() {
    super.initState();
    location = widget.initialValue;

    _itemsStore
        .watchStateByName(widget.itemName)
        .distinct()
        .listen((state) {
      if (state != null) {
        final newLocation =
            OpenhabLocation.fromItemState(state.state, widget.itemName, true);
        if (mounted) {
          setState(() {
            location = newLocation;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: widget.itemName,
        builder: (itemState) {
          return Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusContainer),
                  child: OpenhabMapWidget(
                    location: location,
                    colorScheme: widget.colorScheme,
                    showPopupInitial: false,
                    popupBuilder: (context, marker) =>
                        location.nominatimResponse != null
                            ? Container(
                                padding: const EdgeInsets.all(smallPadding),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(smallPadding),
                                  color: widget.colorScheme.surface,
                                ),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (location.nominatimResponse?.name
                                              ?.isNotEmpty ==
                                          true)
                                        Text(location.nominatimResponse!.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: widget.colorScheme
                                                        .onSurface)),
                                      if (location.nominatimResponse
                                              ?.displayName?.isNotEmpty ==
                                          true)
                                        Text(
                                            location.nominatimResponse!
                                                .displayName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: widget
                                                        .colorScheme.onSurface))
                                    ]),
                              )
                            : SizedBox.shrink(),
                  )));
        });
  }

  Future<void> onNewLocation(double latitude, double longitude) async {
    await _itemRepository.locationAction(widget.itemName, latitude, longitude);
  }
}
