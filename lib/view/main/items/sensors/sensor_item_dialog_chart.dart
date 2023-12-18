import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../core/network/converters/persistence.dart';
import '../../../../locator.dart';
import '../../../../repository/chart_repository.dart';
import '../../../util/constants.dart';

class SensorItemDialogChart extends StatelessWidget {
  final Item item;
  final ColorScheme colorScheme;
  final _chartRepository = locator<ChartRepository>();

  SensorItemDialogChart(
      {super.key, required this.item, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final data = _chartRepository.getChartDataStreamByName(item.ohName);
    if (data.isEmpty) {
      return const SizedBox.shrink();
    } else {
      final minY = calculateMinY(data);
      final maxY = calculateMaxY(data);
      final minX = calculateMinX(data);
      final maxX = calculateMaxX(data);
      final xDiffInDays = maxX.difference(minX).inDays;

      return Container(
          margin: const EdgeInsets.only(top: listSpacing * 2),
          constraints: const BoxConstraints(maxHeight: 250),
          child: LineChart(LineChartData(
            lineBarsData: [
              LineChartBarData(
                  spots: data
                      .map((e) => FlSpot(
                          e.time.millisecondsSinceEpoch.toDouble(),
                          double.parse(e.state)))
                      .toList(),
                  isCurved: true,
                  color: colorScheme.primary,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false)),
            ],
            minY: minY,
            maxY: maxY,
            gridData: FlGridData(getDrawingHorizontalLine: (value) {
              return FlLine(
                color: colorScheme.onBackground.withOpacity(0.2),
                strokeWidth: 1,
              );
            }, getDrawingVerticalLine: (value) {
              return FlLine(
                color: colorScheme.onBackground.withOpacity(0.2),
                strokeWidth: 1,
              );
            }),
            borderData: FlBorderData(
                show: true,
                border: Border.all(
                  width: 2,
                  color: colorScheme.onBackground.withOpacity(0.2),
                )),
            titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        reservedSize: 45,
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          return RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                xDiffInDays > 1 ? DateFormat.Md().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        value.toInt())) : DateFormat.Hm().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        value.toInt())),
                              ));
                        })),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        reservedSize: 40,
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          return Text(
                            item.transformState(value.toString()),
                          );
                        }))),
            lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: colorScheme.primaryContainer,
                    tooltipRoundedRadius: 8,
                    tooltipPadding: const EdgeInsets.all(8),
                    getTooltipItems: (touchedSpots) => touchedSpots
                        .map((e) => LineTooltipItem(
                                '${DateFormat.yMd().add_Hm().format(DateTime.fromMillisecondsSinceEpoch(e.x.toInt()))}\n',
                                DynamicTheme.of(context)!
                                    .theme
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: colorScheme.onPrimaryContainer,
                                    ),
                                children: [
                                  TextSpan(
                                      text: item.transformState(e.y.toString()),
                                      style: DynamicTheme.of(context)!
                                          .theme
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: colorScheme
                                                  .onPrimaryContainer,
                                              fontWeight: FontWeight.bold))
                                ]))
                        .toList())),
          )));
    }
  }

  double calculateMinY(List<SensorHistoryDataBean> data) {
    final min =
        data.map((e) => double.parse(e.state)).reduce((a, b) => a < b ? a : b);
    return (min - (min % 2)).floorToDouble();
  }

  double calculateMaxY(List<SensorHistoryDataBean> data) {
    final max =
        data.map((e) => double.parse(e.state)).reduce((a, b) => a > b ? a : b);
    return (max + (max % 2)).floorToDouble();
  }

  DateTime calculateMinX(List<SensorHistoryDataBean> data) {
    return data.first.time;
  }

  DateTime calculateMaxX(List<SensorHistoryDataBean> data) {
    return data.last.time;
  }
}
