import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_pack/weather_pack.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../../util/weather_icons.dart';
import '../../general/item_state_injector.dart';
import '../weather_data.dart';

class WeatherCurrentDialog extends StatelessWidget {
  final String itemName;
  final ColorScheme colorScheme;

  const WeatherCurrentDialog(
      {super.key, required this.itemName, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: itemName,
        builder: (itemState) {
          final stateJson = jsonDecode(itemState.state) as Map<String, dynamic>;
          final type = WeatherRequestType.values
              .firstWhere((e) => e.name == stateJson["type"]);
          if (type == WeatherRequestType.current) {
            final data = WeatherCurrent.fromJson(stateJson["data"]);
            return _buildWeather(context, data);
          } else {
            return const Text("Error");
          }
        });
  }

  Widget _buildWeather(BuildContext context, WeatherCurrent data) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildDataWidget(context, data),
          ),
          Expanded(
            child: _buildConditionWidget(context, data),
          )
        ],
      ),
      if (data.date != null)
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(DateFormat.Md().add_Hm().format(data.date!),
                style: Theme.of(context).textTheme.bodyMedium)),
    ]);
  }

  Widget _buildDataWidget(
    BuildContext context,
    WeatherCurrent data,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: worksTempUnits(temp: data.temp) ?? "-",
                  children: [
                    TextSpan(
                        text: "°C",
                        style: Theme.of(context).textTheme.bodyLarge)
                  ],
                  style: Theme.of(context).textTheme.headlineLarge)),
          if (data.tempFeelsLike != null)
            Text(
                "${S.current.feelsLike(worksTempUnits(temp: data.tempFeelsLike!)!)}°C",
                style: Theme.of(context).textTheme.bodyLarge),
          const Gap(12),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              if (data.sunrise != null)
                _buildDataItem(LineIconsFilled.sunrise_alt_1,
                    DateFormat.Hm().format(data.sunrise!), context),
              if (data.sunset != null)
                _buildDataItem(LineIconsFilled.sunset_alt,
                    DateFormat.Hm().format(data.sunset!), context),
              if (data.windSpeed != null)
                _buildDataItem(
                    LineIcons.wind_cloud, "${data.windSpeed} m/s", context),
              if (data.windDegree != null)
                _buildDataItem(
                    LineIcons.direction, "${data.windDegree}°", context),
              if (data.humidity != null)
                _buildDataItem(
                    LineIcons.humidity_alt, "${data.humidity}%", context),
              if (data.cloudiness != null)
                _buildDataItem(
                    LineIcons.clouds, "${data.cloudiness}%", context),
              if (data.uvi != null && data.uvi! >= 3)
                _buildDataItem(LineIcons.sun, "${data.uvi}", context),
            ],
          )
        ],
      );

  Widget _buildDataItem(IconData icon, String text, BuildContext context) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const Gap(4),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      );

  Widget _buildConditionWidget(BuildContext context, WeatherCurrent data) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getWeatherIcon(context, data.weatherIcon ?? "01d"),
          Text(
            data.weatherDescription ?? "-",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.end,
          ),
        ],
      );

  Widget getWeatherIcon(BuildContext context, String weatherCode) => BoxedIcon(
      WeatherIcons.fromString(convertWeatherCodeToIconName(weatherCode),
          fallback: WeatherIcons.na),
      size: 48,
      color: Theme.of(context).colorScheme.onSurface);
}
