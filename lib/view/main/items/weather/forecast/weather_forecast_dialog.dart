import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_pack/weather_pack.dart';

import '../../../../../util/icons/icons.dart';
import '../../../../util/weather_icons.dart';
import '../../general/item_state_injector.dart';
import '../weather_data.dart';

class WeatherForecastDialog extends StatelessWidget {
  final String itemName;
  final ColorScheme colorScheme;

  const WeatherForecastDialog(
      {super.key, required this.itemName, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: itemName,
        builder: (itemState) {
          final stateJson = jsonDecode(itemState.state) as Map<String, dynamic>;
          final type = WeatherRequestType.values
              .firstWhere((e) => e.name == stateJson["type"]);
          if (type == WeatherRequestType.forecast) {
            final data = WeatherOneCall.fromJson(stateJson["data"]);
            return _buildWeather(context, data);
          } else {
            return const Text("Error");
          }
        });
  }

  Widget _buildWeather(BuildContext context, WeatherOneCall data) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      if (data.daily?.isNotEmpty ?? false)
        ...data.daily!.map((e) => _buildDayWidget(context, e)).toList()
      else
        const Text("Error"),
      if (data.current?.date != null)
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(DateFormat.Md().add_Hm().format(data.current!.date!),
                style: Theme.of(context).textTheme.bodyMedium)),
    ]));
  }

  Widget _buildDayWidget(BuildContext context, WeatherDaily dayData) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: _buildData(context, dayData)),
          Expanded(child: _buildCondition(context, dayData)),
        ],
      ));

  Widget _buildData(BuildContext context, WeatherDaily data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat.MEd().format(data.date!),
              style: Theme.of(context).textTheme.bodyLarge),
          RichText(
              text: TextSpan(
                  text: worksTempUnits(temp: data.tempDay) ?? "-",
                  children: [
                    TextSpan(
                        text: "°C",
                        style: Theme.of(context).textTheme.bodyLarge)
                  ],
                  style: Theme.of(context).textTheme.headlineLarge)),
          Wrap(spacing: 8, runSpacing: 4, children: [
            _buildDataItem(LineIcons.umbrella, "${data.pop! * 100}%", context),
            if ((data.snow ?? -1) > (data.rain ?? -1))
              _buildDataItem(
                  LineIcons.snowfall, "${data.snow ?? "-"}mm", context)
            else
              _buildDataItem(LineIcons.rain, "${data.rain ?? "-"}mm", context),
            if (data.tempMin != null)
              _buildDataItem(LineIconsFilled.arrow_down,
                  (worksTempUnits(temp: data.tempMin!) ?? "-") + "°C", context),
            if (data.tempMax != null)
              _buildDataItem(LineIconsFilled.arrow_up,
                  (worksTempUnits(temp: data.tempMax!) ?? "-") + "°C", context),
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
            if (data.uvi != null && data.uvi! >= 3)
              _buildDataItem(LineIcons.sun, "${data.uvi}", context),
          ]),
        ],
      );

  Widget _buildDataItem(IconData icon, String text, BuildContext context) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
          ),
          const Gap(4),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      );

  Widget _buildCondition(BuildContext context, WeatherDaily data) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getWeatherIcon(context, data.weatherIcon ?? "01d"),
          Text(data.weatherDescription ?? "-",
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      );

  Widget getWeatherIcon(BuildContext context, String weatherCode) => BoxedIcon(
      WeatherIcons.fromString(convertWeatherCodeToIconName(weatherCode),
          fallback: WeatherIcons.na),
      size: 48,
      color: Theme.of(context).colorScheme.onSurface);
}
