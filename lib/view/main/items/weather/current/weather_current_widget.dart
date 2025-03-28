import 'dart:convert';

import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_pack/weather_pack.dart';

import '../../../../../../locator.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../repository/weather_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../../util/general/widget_container.dart';
import '../../../../util/weather_icons.dart';
import '../../general/item_state_injector.dart';
import '../../general/item_widget.dart';
import '../../general/item_widget_factory.dart';
import '../weather_data.dart';
import 'weather_current_dialog.dart';

class WeatherCurrentWidget extends MediumWidthItemWidget {
  final Stream<WeatherLocationData?>? locationStream;
  final bool disableTap;

  WeatherCurrentWidget({
    super.key,
    required super.item,
    required super.colorScheme,
    this.locationStream,
    this.disableTap = false,
  });

  bool get isMock => item == null;
  final _weatherRepository = locator<WeatherRepository>();

  @override
  Widget build(BuildContext context) {
    final config = item?.complexJson != null
        ? WeatherData.fromJson(item!.complexJson!)
        : null;
    if (isMock && config == null) {
      if (locationStream == null) {
        return _buildWidget(context, mockData, mockLocation);
      } else {
        return StreamBuilder<WeatherLocationData?>(
            stream: locationStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return _buildWidget(context, mockData, mockLocation);
              } else {
                final location = snapshot.data!;
                final request = WeatherData(
                  itemName: "add",
                  location: location,
                  type: WeatherRequestType.current,
                );
                return FutureBuilder<Tuple2<WeatherCurrent?, WeatherOneCall?>>(
                    future: _weatherRepository.fetchWeather(request),
                    builder: (context, future) {
                      final current = future.data?.item1;
                      return _buildWidget(
                          context, current ?? mockData, location);
                    });
              }
            });
      }
    } else if (!isMock) {
      return ItemStateInjector(
          itemName: item!.ohName,
          builder: (state) {
            final json = jsonDecode(state.state) as Map<String, dynamic>;
            final type = WeatherRequestType.values
                .firstWhere((e) => e.name == json["type"]);
            if (type == WeatherRequestType.current) {
              final data = WeatherCurrent.fromJson(json["data"]);
              return _buildWidget(context, data, config!.location);
            } else {
              final data = WeatherOneCall.fromJson(json["data"]);
              return const SizedBox.shrink();
            }
          });
    }
    return const Text("Weather");
  }

  Widget _buildWidget(BuildContext context, WeatherCurrent data,
          WeatherLocationData location) =>
      WidgetContainer(
          onTap: !isMock
              ? () => onTap(
                    context,
                  )
              : null,
          onLongTap: !isMock
              ? () => onLongTap(
                    context,
                  )
              : null,
          disableTap: disableTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(child: _buildTempWidget(context, data, location)),
                _buildConditionWidget(context, data),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _buildSunriseSunsetWidget(context, data),
                if (data.date != null)
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(DateFormat.Md().add_Hm().format(data.date!),
                          style: Theme.of(context).textTheme.bodySmall))
              ])
            ],
          ));

  Widget _buildTempWidget(BuildContext context, WeatherCurrent data,
          WeatherLocationData location) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoHyphenatingText(location.city ?? location.locationString,
              maxLines: 2, style: Theme.of(context).textTheme.titleMedium),
          const Gap(4),
          RichText(
              text: TextSpan(
                  text: worksTempUnits(temp: data.temp) ?? "-",
                  children: [
                    TextSpan(
                        text: "°C",
                        style: Theme.of(context).textTheme.bodyLarge)
                  ],
                  style: Theme.of(context).textTheme.headlineMedium)),
          if (data.tempFeelsLike != null)
            Text(
                "${S.current.feelsLike(worksTempUnits(temp: data.tempFeelsLike!)!)}°C",
                style: Theme.of(context).textTheme.bodySmall),
        ],
      );

  Widget _buildConditionWidget(BuildContext context, WeatherCurrent data) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getWeatherIcon(context, data.weatherIcon ?? "01d"),
          Text(data.weatherMain ?? "-",
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      );

  Widget getWeatherIcon(BuildContext context, String weatherCode) => BoxedIcon(
      WeatherIcons.fromString(convertWeatherCodeToIconName(weatherCode),
          fallback: WeatherIcons.na),
      size: 36,
      color: Theme.of(context).colorScheme.onSurface);

  Widget _buildSunriseSunsetWidget(BuildContext context, WeatherCurrent data) =>
      data.sunrise != null && data.sunset != null
          ? Row(
              children: [
                const Icon(LineIconsFilled.sunrise_alt_1, size: 18),
                const Gap(4),
                Text(DateFormat.Hm().format(data.sunrise!),
                    style: Theme.of(context).textTheme.bodySmall),
                const Gap(8),
                const Icon(LineIconsFilled.sunset_alt, size: 18),
                const Gap(4),
                Text(DateFormat.Hm().format(data.sunset!),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            )
          : const SizedBox.shrink();

  void onTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context,
      WeatherCurrentDialog(itemName: item!.ohName, colorScheme: colorScheme),
      item!,
      colorScheme,
      hideItemName: true);

  void onLongTap(BuildContext context) => ItemWidgetFactory.openEditSheet(
        context,
        item!,
      );

  WeatherCurrent get mockData => WeatherCurrent.fromJson(jsonDecode(
          '{"timezone_offset": 3600, "dt": 1706529969, "sunrise": 1706511123, "sunset": 1706543904, "temp": 280.79, "feels_like": 278.77, "pressure": 1031, "humidity": 53, "clouds": 0, "visibility": 10000, "wind_speed": 3.09, "wind_deg": 180, "wind_gust": null, "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]}')
      as Map<String, dynamic>);

  WeatherLocationData get mockLocation => WeatherLocationData(
        city: "Weather",
        lat: 48.13743,
        lon: 11.57549,
      );
}
