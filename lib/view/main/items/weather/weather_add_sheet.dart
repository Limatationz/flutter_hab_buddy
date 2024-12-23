import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/items/item_type.dart';
import '../../../../../core/database/items/oh_item_type.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../repository/weather_repository.dart';
import '../../../util/general/base_elevated_button.dart';
import '../../../util/general/better_divider.dart';
import '../../../util/general/delete_dialog.dart';
import '../../../util/general/headline_padding_box.dart';
import '../general/item_widget.dart';
import 'current/weather_current_widget.dart';
import 'forecast/weather_forecast_widget.dart';
import 'weather_data.dart';

class WeatherAddSheet extends StatefulWidget {
  final int roomId;
  final Item? item;
  final WeatherRequestType type;

  WeatherAddSheet(
      {super.key, required this.roomId, this.item, WeatherRequestType? type})
      : type = type ??
            (item?.type == ItemType.weatherForecast
                ? WeatherRequestType.forecast
                : WeatherRequestType.current);

  @override
  State<WeatherAddSheet> createState() => _WeatherAddSheetState();
}

class _WeatherAddSheetState extends State<WeatherAddSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _itemsRepository = locator<ItemRepository>();
  final _weatherRepository = locator<WeatherRepository>();
  final _snackBarService = locator<SnackbarService>();
  final BehaviorSubject<WeatherLocationData?> _locationSubject =
      BehaviorSubject.seeded(null);

  bool get isAdd => widget.item == null;

  bool isSearchingPosition = false;
  bool hasPosition = false;
  bool isForecast = false;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      final config = WeatherData.fromJson(widget.item!.complexJson!);
      _locationSubject.add(config.location);
      if (config.location.lat != null && config.location.lon != null) {
        hasPosition = true;
      }
    }

    isForecast = widget.type == WeatherRequestType.forecast;
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.item?.complexJson != null
        ? WeatherData.fromJson(widget.item!.complexJson!)
        : null;
    return FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(isForecast ? (isAdd ? "Add Weather Forecast" : "Edit Weather Forecast") : (isAdd ? "Add Weather" : "Edit Weather"),
                        style: Theme.of(context).textTheme.headlineMedium)),
                if (!isAdd)
                  IconButton(
                      onPressed: () async {
                        final result = await showDeleteItemDialog(
                            context: context,
                            itemLabel:
                                "Weather for ${config!.location.locationString}");
                        if (result == true) {
                          _itemsRepository
                              .removeItem(
                            widget.item!.ohName,
                          )
                              .then((value) {
                            if (value) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                      visualDensity: VisualDensity.compact,
                      iconSize: 28,
                      icon: Icon(
                        LineIconsFilled.trash_can,
                        color: Theme.of(context).colorScheme.error,
                      )),
              ],
            ),
            const HeadlinePaddingBox(),
            SizedBox(
                height: MediumWidthItemWidget.height,
                width: isForecast ? LargeWidthItemWidget.width : MediumWidthItemWidget.width,
                child: widget.type == WeatherRequestType.current
                    ? WeatherCurrentWidget(
                        item: null,
                        colorScheme: Theme.of(context).colorScheme,
                        locationStream: _locationSubject,
                      )
                    : WeatherForecastWidget(
                        item: null,
                        colorScheme: Theme.of(context).colorScheme,
                        locationStream: _locationSubject,
                      )),
            const Gap(24),
            FormBuilderTextField(
              name: "city",
              initialValue: config?.location.city,
              decoration: const InputDecoration(labelText: "City"),
              enabled: !hasPosition,
              onSubmitted: (value) {
                if (value != null && value.isNotEmpty) {
                  _locationSubject.add(WeatherLocationData(city: value));
                } else {
                  _locationSubject.add(null);
                }
              },
            ),
            const Gap(8),
            BetterDivider(context: context),
            const Gap(8),
            Row(
              children: [
                Expanded(
                    child: Column(children: [
                  FormBuilderTextField(
                    name: "lat",
                    initialValue: config?.location.lat?.toString(),
                    decoration: const InputDecoration(labelText: "Latitude"),
                    readOnly: true,
                  ),
                  const Gap(8),
                  FormBuilderTextField(
                    name: "lon",
                    initialValue: config?.location.lon?.toString(),
                    decoration: const InputDecoration(labelText: "Longitude"),
                    readOnly: true,
                  ),
                ])),
                const Gap(16),
                Stack(alignment: Alignment.center, children: [
                  Visibility(
                      visible: isSearchingPosition,
                      child: const CircularProgressIndicator()),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: !isSearchingPosition,
                      child: IconButton.filled(
                          tooltip: "Request current position from GPS",
                          onPressed: hasPosition
                              ? () {
                                  _formKey.currentState!.patchValue({
                                    "lat": "",
                                    "lon": "",
                                  });
                                  setState(() {
                                    hasPosition = false;
                                  });
                                }
                              : () {
                                  setState(() {
                                    isSearchingPosition = true;
                                  });
                                  LocationService.determinePositionOneTime()
                                      .then((value) async {
                                    final city = await _weatherRepository
                                        .getCityByLocation(
                                            latitude: value.latitude,
                                            longitude: value.longitude);
                                    _formKey.currentState!.patchValue({
                                      "lat": value.latitude.toString(),
                                      "lon": value.longitude.toString(),
                                      "city": city ?? "",
                                    });
                                    setState(() {
                                      isSearchingPosition = false;
                                      hasPosition = true;
                                    });
                                  });
                                },
                          icon: Icon(
                              !hasPosition
                                  ? LineIcons.search_location
                                  : LineIcons.spinner_arrow,
                              size: 36)))
                ])
              ],
            ),
            const Gap(16),
            BaseElevatedButton(
                text: S.current.save,
                onPressed: () {
                  _save().then((value) {
                    if (value) {
                      Navigator.of(context).pop(widget.item);
                    }
                  });
                })
          ],
        ));
  }

  Future<bool> _save() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formKey.currentState!.value;
      if (isAdd) {
        final city = values["city"] as String?;
        final lat = values["lat"] as String?;
        final lon = values["lon"] as String?;

        if ((city?.isEmpty ?? true) &&
            ((lat?.isEmpty ?? true) || (lon?.isEmpty ?? true))) {
          _snackBarService.showSnackbar(
            message: "Please enter a city or request your current position",
            type: SnackbarType.error,
          );
          return false;
        }

        final itemName = "weather_${const Uuid().v4()}";
        final latDouble = double.tryParse(lat ?? "");
        final lonDouble = double.tryParse(lon ?? "");

        WeatherData weatherData;
        if (latDouble != null && lonDouble != null) {
          weatherData = WeatherData(
            itemName: itemName,
            location: WeatherLocationData(
              lat: latDouble,
              lon: lonDouble,
              city: city,
            ),
            type: widget.type,
          );
        } else {
          weatherData = WeatherData(
            itemName: itemName,
            location: WeatherLocationData(city: city),
            type: widget.type,
          );
        }

        final clockItem = ItemsTableCompanion.insert(
          type: isForecast ? ItemType.weatherForecast : ItemType.weather,
          ohType: OhItemType.string,
          ohName: itemName,
          ohLabel: city ?? "Weather",
          roomId: widget.roomId,
          complexJson: Value(weatherData.toJson()),
        );

        await _itemsRepository.addItem(clockItem);

        // start weather observer
        return _weatherRepository.startWeatherObserver(weatherData);
      } else {
        // update
        final oldConfig = WeatherData.fromJson(widget.item!.complexJson!);
        final city = values["city"] as String?;
        final lat = values["lat"] as String?;
        final lon = values["lon"] as String?;

        if ((city?.isEmpty ?? true) &&
            ((lat?.isEmpty ?? true) || (lon?.isEmpty ?? true))) {
          _snackBarService.showSnackbar(
            message: "Please enter a city or request your current position",
            type: SnackbarType.error,
          );
          return false;
        }

        final latDouble = double.tryParse(lat ?? "");
        final lonDouble = double.tryParse(lon ?? "");

        WeatherData newWeatherData;
        if (latDouble != null && lonDouble != null) {
          newWeatherData = WeatherData(
            itemName: widget.item!.ohName,
            location: WeatherLocationData(
              lat: latDouble,
              lon: lonDouble,
              city: city,
            ),
            type: widget.type,
          );
        } else {
          newWeatherData = WeatherData(
            itemName: widget.item!.ohName,
            location: WeatherLocationData(city: city),
            type: widget.type,
          );
        }

        await _itemsStore.updateComplexJsonByName(
            newWeatherData.toJson(), widget.item!.ohName);

        // remove old weather observer
        _weatherRepository.stopWeatherObserver(oldConfig);
        // start new weather observer
        return _weatherRepository.startWeatherObserver(newWeatherData);
      }
    } else {
      _snackBarService.showSnackbar(
        message: S.current.errorHeadline,
        type: SnackbarType.error,
      );
      return false;
    }
  }
}
