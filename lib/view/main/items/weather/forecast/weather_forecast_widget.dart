import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_pack/weather_pack.dart';

import '../../../../../../locator.dart';
import '../../../../../repository/weather_repository.dart';
import '../../../../util/general/widget_container.dart';
import '../../../../util/weather_icons.dart';
import '../../general/item_state_injector.dart';
import '../../general/item_widget.dart';
import '../../general/item_widget_factory.dart';
import '../weather_data.dart';
import 'weather_forecast_dialog.dart';

const dayWidgetWidth = 60.0;

class WeatherForecastWidget extends LargeWidthItemWidget {
  final Stream<WeatherLocationData?>? locationStream;
  final bool disableTap;

  WeatherForecastWidget({
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
                  type: WeatherRequestType.forecast,
                );
                return FutureBuilder<Tuple2<WeatherCurrent?, WeatherOneCall?>>(
                    future: _weatherRepository.fetchWeather(request),
                    builder: (context, future) {
                      final forecast = future.data?.item2;
                      return _buildWidget(
                          context, forecast ?? mockData, location);
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
            if (type == WeatherRequestType.forecast) {
              final data = WeatherOneCall.fromJson(json["data"]);
              return _buildWidget(context, data, config!.location);
            } else {
              return const SizedBox.shrink();
            }
          });
    }
    return const Text("Weather");
  }

  Widget _buildWidget(BuildContext context, WeatherOneCall data,
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
          child: LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            final days = width ~/ dayWidgetWidth;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.daily?.isNotEmpty ?? false)
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: data.daily!
                              .take(days)
                              .map((dayData) =>
                                  _buildDayWidget(context, dayData))
                              .toList()))
                else
                  Text("No data"),
                Gap(2),
                Row(children: [
                  Text(location.locationString,
                      style: Theme.of(context).textTheme.bodySmall),
                  Spacer(),
                  if (data.current?.date != null)
                    Text(DateFormat.Md().add_Hm().format(data.current!.date!),
                        style: Theme.of(context).textTheme.bodySmall)
                ])
              ],
            );
          }));

  Widget _buildDayWidget(BuildContext context, WeatherDaily dayData) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(DateFormat.MEd().format(dayData.date!),
              maxLines: 1, style: Theme.of(context).textTheme.bodyMedium),
          getWeatherIcon(context, dayData.weatherIcon!),
          Builder(builder: (context) {
            final minTemp = worksTempUnits(temp: dayData.tempMin, precision: 0);
            final maxTemp = worksTempUnits(temp: dayData.tempMax, precision: 0);
            if (minTemp == maxTemp) {
              return AutoSizeText(
                "${minTemp ?? "-"}°C",
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
              );
            } else {
              return AutoSizeText(
                "${minTemp ?? "-"}°C/${maxTemp ?? "-"}°C",
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
              );
            }
          }),
        ],
      );

  Widget getWeatherIcon(BuildContext context, String weatherCode) => BoxedIcon(
      WeatherIcons.fromString(convertWeatherCodeToIconName(weatherCode),
          fallback: WeatherIcons.na),
      size: 24,
      color: Theme.of(context).colorScheme.onSurface);

  void onTap(BuildContext context) => ItemWidgetFactory.openDialog(
      context,
      WeatherForecastDialog(itemName: item!.ohName, colorScheme: colorScheme),
      item!,
      colorScheme,
      scrollable: true,
      hideItemName: true);

  void onLongTap(BuildContext context) => ItemWidgetFactory.openEditSheet(
        context,
        item!,
      );

  WeatherOneCall get mockData => WeatherOneCall.fromJson(jsonDecode(
          '{"lat":49.9456,"lon":11.5713,"timezone":"Europe/Berlin","timezone_offset":3600,"current":{"dt":1707077924,"sunrise":1707029028,"sunset":1707063078,"temp":280.97,"feels_like":279.6,"pressure":1018,"humidity":93,"dew_point":279.91,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":2.24,"wind_deg":279,"wind_gust":7.6,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}]},"minutely":[{"dt":1707077940,"precipitation":0},{"dt":1707078000,"precipitation":0},{"dt":1707078060,"precipitation":0},{"dt":1707078120,"precipitation":0},{"dt":1707078180,"precipitation":0},{"dt":1707078240,"precipitation":0},{"dt":1707078300,"precipitation":0},{"dt":1707078360,"precipitation":0},{"dt":1707078420,"precipitation":0},{"dt":1707078480,"precipitation":0},{"dt":1707078540,"precipitation":0},{"dt":1707078600,"precipitation":0},{"dt":1707078660,"precipitation":0},{"dt":1707078720,"precipitation":0},{"dt":1707078780,"precipitation":0},{"dt":1707078840,"precipitation":0},{"dt":1707078900,"precipitation":0},{"dt":1707078960,"precipitation":0},{"dt":1707079020,"precipitation":0},{"dt":1707079080,"precipitation":0},{"dt":1707079140,"precipitation":0},{"dt":1707079200,"precipitation":0},{"dt":1707079260,"precipitation":0},{"dt":1707079320,"precipitation":0},{"dt":1707079380,"precipitation":0},{"dt":1707079440,"precipitation":0},{"dt":1707079500,"precipitation":0},{"dt":1707079560,"precipitation":0},{"dt":1707079620,"precipitation":0},{"dt":1707079680,"precipitation":0},{"dt":1707079740,"precipitation":0},{"dt":1707079800,"precipitation":0},{"dt":1707079860,"precipitation":0},{"dt":1707079920,"precipitation":0},{"dt":1707079980,"precipitation":0},{"dt":1707080040,"precipitation":0},{"dt":1707080100,"precipitation":0},{"dt":1707080160,"precipitation":0},{"dt":1707080220,"precipitation":0},{"dt":1707080280,"precipitation":0},{"dt":1707080340,"precipitation":0},{"dt":1707080400,"precipitation":0},{"dt":1707080460,"precipitation":0},{"dt":1707080520,"precipitation":0},{"dt":1707080580,"precipitation":0},{"dt":1707080640,"precipitation":0},{"dt":1707080700,"precipitation":0},{"dt":1707080760,"precipitation":0},{"dt":1707080820,"precipitation":0},{"dt":1707080880,"precipitation":0},{"dt":1707080940,"precipitation":0},{"dt":1707081000,"precipitation":0},{"dt":1707081060,"precipitation":0},{"dt":1707081120,"precipitation":0},{"dt":1707081180,"precipitation":0},{"dt":1707081240,"precipitation":0},{"dt":1707081300,"precipitation":0},{"dt":1707081360,"precipitation":0},{"dt":1707081420,"precipitation":0},{"dt":1707081480,"precipitation":0}],"hourly":[{"dt":1707076800,"temp":280.97,"feels_like":276.85,"pressure":1018,"humidity":93,"dew_point":279.91,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":8.5,"wind_deg":253,"wind_gust":17.29,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.42},{"dt":1707080400,"temp":280.92,"feels_like":276.74,"pressure":1019,"humidity":94,"dew_point":280.02,"uvi":0,"clouds":100,"visibility":3645,"wind_speed":8.66,"wind_deg":253,"wind_gust":17.46,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.42},{"dt":1707084000,"temp":280.9,"feels_like":276.71,"pressure":1019,"humidity":94,"dew_point":280,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":8.68,"wind_deg":254,"wind_gust":18.24,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.38},{"dt":1707087600,"temp":280.94,"feels_like":276.66,"pressure":1020,"humidity":93,"dew_point":279.88,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":9.09,"wind_deg":256,"wind_gust":18.93,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.38},{"dt":1707091200,"temp":281.07,"feels_like":276.94,"pressure":1020,"humidity":92,"dew_point":279.85,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":8.67,"wind_deg":259,"wind_gust":18.66,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.38},{"dt":1707094800,"temp":281.27,"feels_like":277.21,"pressure":1020,"humidity":91,"dew_point":279.21,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":8.62,"wind_deg":261,"wind_gust":18.5,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.29},{"dt":1707098400,"temp":281.22,"feels_like":277.21,"pressure":1020,"humidity":91,"dew_point":279.22,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":8.36,"wind_deg":260,"wind_gust":17.43,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.1},{"dt":1707102000,"temp":281.12,"feels_like":277.18,"pressure":1020,"humidity":92,"dew_point":279.28,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":8.01,"wind_deg":261,"wind_gust":16.84,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.12},{"dt":1707105600,"temp":281.21,"feels_like":277.29,"pressure":1021,"humidity":91,"dew_point":279.14,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":8.02,"wind_deg":261,"wind_gust":16.34,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"pop":0.37,"rain":{"1h":0.11}},{"dt":1707109200,"temp":281.28,"feels_like":277.36,"pressure":1021,"humidity":88,"dew_point":278.8,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":8.11,"wind_deg":260,"wind_gust":16.1,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0.01},{"dt":1707112800,"temp":280.98,"feels_like":277.07,"pressure":1021,"humidity":90,"dew_point":278.87,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":7.75,"wind_deg":258,"wind_gust":15.81,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707116400,"temp":280.97,"feels_like":277.06,"pressure":1022,"humidity":90,"dew_point":278.74,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":7.76,"wind_deg":259,"wind_gust":15.92,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707120000,"temp":281.03,"feels_like":277.2,"pressure":1022,"humidity":87,"dew_point":278.41,"uvi":0.1,"clouds":100,"visibility":10000,"wind_speed":7.54,"wind_deg":261,"wind_gust":15.08,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707123600,"temp":281.08,"feels_like":277.35,"pressure":1022,"humidity":86,"dew_point":278.29,"uvi":0.24,"clouds":100,"visibility":10000,"wind_speed":7.27,"wind_deg":261,"wind_gust":14.35,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707127200,"temp":281.34,"feels_like":277.76,"pressure":1022,"humidity":85,"dew_point":278.38,"uvi":0.6,"clouds":100,"visibility":10000,"wind_speed":7.02,"wind_deg":259,"wind_gust":14.63,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707130800,"temp":281.63,"feels_like":278.19,"pressure":1022,"humidity":84,"dew_point":278.54,"uvi":0.6,"clouds":100,"visibility":10000,"wind_speed":6.81,"wind_deg":257,"wind_gust":14.63,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707134400,"temp":282.43,"feels_like":279.26,"pressure":1022,"humidity":82,"dew_point":278.83,"uvi":0.87,"clouds":99,"visibility":10000,"wind_speed":6.69,"wind_deg":256,"wind_gust":14.58,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707138000,"temp":282.97,"feels_like":280.03,"pressure":1021,"humidity":80,"dew_point":279.03,"uvi":0.75,"clouds":70,"visibility":10000,"wind_speed":6.43,"wind_deg":256,"wind_gust":14.38,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1707141600,"temp":282.96,"feels_like":280.08,"pressure":1020,"humidity":80,"dew_point":279.06,"uvi":0.45,"clouds":54,"visibility":10000,"wind_speed":6.21,"wind_deg":256,"wind_gust":14.28,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1707145200,"temp":282.38,"feels_like":279.42,"pressure":1020,"humidity":82,"dew_point":278.84,"uvi":0.17,"clouds":44,"visibility":10000,"wind_speed":5.98,"wind_deg":254,"wind_gust":14.47,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1707148800,"temp":281.31,"feels_like":278.23,"pressure":1020,"humidity":86,"dew_point":278.41,"uvi":0,"clouds":37,"visibility":10000,"wind_speed":5.52,"wind_deg":252,"wind_gust":14.24,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1707152400,"temp":280.55,"feels_like":277.46,"pressure":1021,"humidity":89,"dew_point":278.2,"uvi":0,"clouds":35,"visibility":10000,"wind_speed":5.07,"wind_deg":248,"wind_gust":14.28,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"pop":0},{"dt":1707156000,"temp":280.17,"feels_like":277.03,"pressure":1021,"humidity":90,"dew_point":278.05,"uvi":0,"clouds":38,"visibility":10000,"wind_speed":4.95,"wind_deg":247,"wind_gust":14.33,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"pop":0},{"dt":1707159600,"temp":279.92,"feels_like":276.68,"pressure":1021,"humidity":91,"dew_point":277.89,"uvi":0,"clouds":76,"visibility":10000,"wind_speed":5.04,"wind_deg":246,"wind_gust":14.51,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"pop":0},{"dt":1707163200,"temp":279.75,"feels_like":276.4,"pressure":1020,"humidity":91,"dew_point":277.76,"uvi":0,"clouds":86,"visibility":10000,"wind_speed":5.2,"wind_deg":246,"wind_gust":15.2,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707166800,"temp":279.6,"feels_like":276.19,"pressure":1020,"humidity":93,"dew_point":277.85,"uvi":0,"clouds":90,"visibility":10000,"wind_speed":5.25,"wind_deg":244,"wind_gust":15.34,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707170400,"temp":279.66,"feels_like":276.15,"pressure":1020,"humidity":93,"dew_point":277.95,"uvi":0,"clouds":92,"visibility":10000,"wind_speed":5.53,"wind_deg":245,"wind_gust":15.54,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707174000,"temp":279.78,"feels_like":276.24,"pressure":1019,"humidity":92,"dew_point":277.89,"uvi":0,"clouds":94,"visibility":10000,"wind_speed":5.69,"wind_deg":245,"wind_gust":15.71,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707177600,"temp":279.77,"feels_like":276.14,"pressure":1019,"humidity":91,"dew_point":277.77,"uvi":0,"clouds":94,"visibility":10000,"wind_speed":5.89,"wind_deg":245,"wind_gust":15.85,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707181200,"temp":279.88,"feels_like":276.21,"pressure":1019,"humidity":90,"dew_point":277.7,"uvi":0,"clouds":98,"visibility":10000,"wind_speed":6.07,"wind_deg":248,"wind_gust":15.69,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707184800,"temp":280.05,"feels_like":276.25,"pressure":1018,"humidity":88,"dew_point":277.5,"uvi":0,"clouds":99,"visibility":10000,"wind_speed":6.56,"wind_deg":251,"wind_gust":15.68,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707188400,"temp":280.04,"feels_like":276.03,"pressure":1018,"humidity":85,"dew_point":277.01,"uvi":0,"clouds":99,"visibility":10000,"wind_speed":7.19,"wind_deg":255,"wind_gust":14.93,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707192000,"temp":279.68,"feels_like":275.77,"pressure":1018,"humidity":88,"dew_point":277.21,"uvi":0,"clouds":99,"visibility":10000,"wind_speed":6.6,"wind_deg":252,"wind_gust":14.49,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707195600,"temp":279.61,"feels_like":275.75,"pressure":1017,"humidity":89,"dew_point":277.24,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":6.41,"wind_deg":251,"wind_gust":14.6,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"pop":0.2,"rain":{"1h":0.11}},{"dt":1707199200,"temp":279.62,"feels_like":275.7,"pressure":1017,"humidity":89,"dew_point":277.25,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":6.56,"wind_deg":250,"wind_gust":14.69,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707202800,"temp":279.58,"feels_like":275.58,"pressure":1017,"humidity":87,"dew_point":277.01,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":6.76,"wind_deg":254,"wind_gust":14.79,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707206400,"temp":279.48,"feels_like":275.41,"pressure":1018,"humidity":86,"dew_point":276.75,"uvi":0.06,"clouds":100,"visibility":10000,"wind_speed":6.89,"wind_deg":254,"wind_gust":15.13,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"pop":0.2,"rain":{"1h":0.11}},{"dt":1707210000,"temp":279.39,"feels_like":275.29,"pressure":1018,"humidity":87,"dew_point":276.75,"uvi":0.13,"clouds":100,"visibility":10000,"wind_speed":6.9,"wind_deg":252,"wind_gust":15.17,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707213600,"temp":279.48,"feels_like":275.41,"pressure":1018,"humidity":86,"dew_point":276.65,"uvi":0.2,"clouds":100,"visibility":10000,"wind_speed":6.9,"wind_deg":252,"wind_gust":15.39,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707217200,"temp":279.73,"feels_like":275.63,"pressure":1017,"humidity":85,"dew_point":276.73,"uvi":0.23,"clouds":100,"visibility":10000,"wind_speed":7.2,"wind_deg":252,"wind_gust":15.79,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707220800,"temp":279.92,"feels_like":275.8,"pressure":1017,"humidity":84,"dew_point":276.71,"uvi":0.23,"clouds":100,"visibility":10000,"wind_speed":7.43,"wind_deg":251,"wind_gust":16.14,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707224400,"temp":280.1,"feels_like":275.98,"pressure":1016,"humidity":83,"dew_point":276.76,"uvi":0.19,"clouds":100,"visibility":10000,"wind_speed":7.6,"wind_deg":250,"wind_gust":16.43,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707228000,"temp":280.22,"feels_like":276.08,"pressure":1015,"humidity":83,"dew_point":276.85,"uvi":0.14,"clouds":100,"visibility":10000,"wind_speed":7.78,"wind_deg":249,"wind_gust":16.52,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707231600,"temp":280.23,"feels_like":276.09,"pressure":1015,"humidity":82,"dew_point":276.83,"uvi":0.07,"clouds":100,"visibility":10000,"wind_speed":7.78,"wind_deg":248,"wind_gust":16.41,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707235200,"temp":279.99,"feels_like":275.81,"pressure":1015,"humidity":84,"dew_point":276.78,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":7.67,"wind_deg":247,"wind_gust":16.25,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1707238800,"temp":279.92,"feels_like":275.75,"pressure":1015,"humidity":84,"dew_point":276.78,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":7.59,"wind_deg":245,"wind_gust":16.34,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707242400,"temp":280,"feels_like":275.92,"pressure":1014,"humidity":83,"dew_point":276.73,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":7.37,"wind_deg":243,"wind_gust":16.07,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1707246000,"temp":280.05,"feels_like":275.95,"pressure":1014,"humidity":83,"dew_point":276.72,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":7.49,"wind_deg":248,"wind_gust":16.29,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0}],"daily":[{"dt":1707044400,"sunrise":1707029028,"sunset":1707063078,"moonrise":1707011880,"moonset":1707041100,"moon_phase":0.8,"temp":{"day":280.14,"min":279.68,"max":280.97,"night":280.9,"eve":280.87,"morn":279.97},"feels_like":{"day":276.23,"night":276.71,"eve":276.76,"morn":276.41},"pressure":1024,"humidity":91,"dew_point":278.12,"wind_speed":8.68,"wind_deg":254,"wind_gust":18.24,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":100,"pop":0.66,"rain":1.41,"uvi":0.22},{"dt":1707130800,"sunrise":1707115337,"sunset":1707149582,"moonrise":1707102900,"moonset":1707129480,"moon_phase":0.83,"temp":{"day":281.63,"min":279.6,"max":282.97,"night":279.66,"eve":280.55,"morn":281.28},"feels_like":{"day":278.19,"night":276.15,"eve":277.46,"morn":277.36},"pressure":1022,"humidity":84,"dew_point":278.54,"wind_speed":9.09,"wind_deg":256,"wind_gust":18.93,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":100,"pop":0.38,"rain":0.11,"uvi":0.87},{"dt":1707217200,"sunrise":1707201645,"sunset":1707236086,"moonrise":1707193740,"moonset":1707218820,"moon_phase":0.87,"temp":{"day":279.73,"min":279.39,"max":280.23,"night":279.86,"eve":279.92,"morn":279.61},"feels_like":{"day":275.63,"night":275.75,"eve":275.75,"morn":275.75},"pressure":1017,"humidity":85,"dew_point":276.73,"wind_speed":7.78,"wind_deg":249,"wind_gust":16.52,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":100,"pop":0.2,"rain":0.22,"uvi":0.23},{"dt":1707303600,"sunrise":1707287950,"sunset":1707322590,"moonrise":1707283860,"moonset":1707309300,"moon_phase":0.9,"temp":{"day":280.78,"min":279.97,"max":280.9,"night":280.29,"eve":280.76,"morn":280.21},"feels_like":{"day":276.87,"night":276.67,"eve":277.21,"morn":276.08},"pressure":1009,"humidity":85,"dew_point":277.74,"wind_speed":8.04,"wind_deg":242,"wind_gust":16.92,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":100,"pop":1,"rain":2.3,"uvi":0.27},{"dt":1707390000,"sunrise":1707374254,"sunset":1707409094,"moonrise":1707373140,"moonset":1707400740,"moon_phase":0.94,"temp":{"day":281.5,"min":280.73,"max":282.52,"night":281.36,"eve":282.52,"morn":281.05},"feels_like":{"day":278.72,"night":279.64,"eve":280.27,"morn":277.83},"pressure":1002,"humidity":95,"dew_point":280.07,"wind_speed":6.24,"wind_deg":242,"wind_gust":14.32,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"clouds":100,"pop":1,"rain":13.11,"uvi":0.13},{"dt":1707476400,"sunrise":1707460557,"sunset":1707495598,"moonrise":1707461520,"moonset":1707492600,"moon_phase":0.98,"temp":{"day":284.01,"min":280.81,"max":284.01,"night":280.81,"eve":281.68,"morn":280.84},"feels_like":{"day":283.27,"night":280.81,"eve":280.86,"morn":279.47},"pressure":996,"humidity":81,"dew_point":280.2,"wind_speed":3.06,"wind_deg":174,"wind_gust":9.78,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":100,"pop":0.51,"rain":1.32,"uvi":0.79},{"dt":1707562800,"sunrise":1707546858,"sunset":1707582102,"moonrise":1707549360,"moonset":1707584640,"moon_phase":0,"temp":{"day":285,"min":279.25,"max":285,"night":280.58,"eve":281.3,"morn":279.25},"feels_like":{"day":283.94,"night":280.58,"eve":280.18,"morn":278.31},"pressure":992,"humidity":65,"dew_point":277.99,"wind_speed":2.14,"wind_deg":84,"wind_gust":4.28,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":100,"pop":0,"uvi":1},{"dt":1707649200,"sunrise":1707633157,"sunset":1707668606,"moonrise":1707636900,"moonset":1707676500,"moon_phase":0.06,"temp":{"day":282.96,"min":278.74,"max":282.96,"night":278.86,"eve":280.13,"morn":278.74},"feels_like":{"day":280.96,"night":276.16,"eve":277.33,"morn":277.65},"pressure":992,"humidity":80,"dew_point":278.99,"wind_speed":4.21,"wind_deg":263,"wind_gust":8.61,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":100,"pop":0.59,"rain":0.43,"uvi":1}],"alerts":[{"sender_name":"Deutscher Wetterdienst","event":"gale-force gusts","start":1707030000,"end":1707123600,"description":"There is a risk of gale-force gusts (Level 2 of 4).Height range: > 600 m; Max. gusts: ~ 70 km/h; Wind direction: west; Increased gusts: in exposed locations < 85 km/h","tags":["Thunderstorm"]},{"sender_name":"Deutscher Wetterdienst","event":"wind gusts","start":1707030000,"end":1707123600,"description":"There is a risk of wind gusts (level 1 of 4).Max. gusts: 50-60 km/h; Wind direction: west; Increased gusts: in exposed locations < 70 km/h","tags":["Wind"]},{"sender_name":"Deutscher Wetterdienst","event":"gale-force gusts","start":1707123600,"end":1707152400,"description":"There is a risk of gale-force gusts (Level 2 of 4).Height range: > 600 m; Max. gusts: < 70 km/h; Wind direction: west; Increased gusts: in exposed locations < 80 km/h","tags":["Thunderstorm"]},{"sender_name":"Deutscher Wetterdienst","event":"wind gusts","start":1707123600,"end":1707159600,"description":"There is a risk of wind gusts (level 1 of 4).Max. gusts: < 60 km/h; Wind direction: west then south-west; Increased gusts: in exposed locations < 70 km/h","tags":["Wind"]}]}')
      as Map<String, dynamic>);

  WeatherLocationData get mockLocation => WeatherLocationData(
        city: "Weather",
        lat: 48.13743,
        lon: 11.57549,
      );
}
