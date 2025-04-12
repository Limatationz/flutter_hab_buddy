import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/hive/sensor_history_data_bean/sensor_history_data_bean.dart';
import '../../../../core/hive/state/item_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../repository/chart_repository.dart';
import '../../../util/constants.dart';

class SensorItemDialogChart extends StatelessWidget {
  final Item item;
  final ItemState itemState;
  final ColorScheme colorScheme;
  final _chartRepository = locator<ChartRepository>();

  SensorItemDialogChart(
      {super.key,
      required this.item,
      required this.itemState,
      required this.colorScheme});

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
                color: colorScheme.onSurface.withOpacity(0.2),
                strokeWidth: 1,
              );
            }, getDrawingVerticalLine: (value) {
              return FlLine(
                color: colorScheme.onSurface.withOpacity(0.2),
                strokeWidth: 1,
              );
            }),
            borderData: FlBorderData(
                show: true,
                border: Border.all(
                  width: 2,
                  color: colorScheme.onSurface.withOpacity(0.2),
                )),
            titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                    axisNameSize: 20,
                    axisNameWidget: AutoSizeText(
                      xDiffInDays > 1 ? S.of(context).date : S.of(context).time,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    sideTitles: SideTitles(
                        reservedSize: 45,
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          return RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                xDiffInDays > 1
                                    ? DateFormat.Md().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            value.toInt()))
                                    : DateFormat.Hm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            value.toInt())),
                              ));
                        })),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  axisNameSize: 20,
                  axisNameWidget: AutoSizeText(
                    itemState.ohUnitSymbol == null ? S.of(context).data : S.of(context).dataWithUnit(itemState.ohUnitSymbol!),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                    sideTitles: SideTitles(
                        reservedSize: 40,
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          return Text(
                            itemState.rawState(value.toString()),
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }))),
            lineTouchData: LineTouchData(
              getTouchedSpotIndicator: (barData, spotIndexes) {
                return spotIndexes.map((spotIndex) {
                  return TouchedSpotIndicatorData(
                    FlLine(
                      color: colorScheme.secondaryContainer,
                      strokeWidth: 4,
                    ),
                    FlDotData(
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 8,
                          color: colorScheme.secondaryContainer,
                          strokeWidth: 2,
                          strokeColor: colorScheme.onSecondaryContainer,
                        );
                      },
                    ),
                  );
                }).toList();
              },
                touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (spot) => colorScheme.secondaryContainer,
                    tooltipRoundedRadius: 8,
                    tooltipPadding: const EdgeInsets.all(8),
                    getTooltipItems: (touchedSpots) => touchedSpots
                        .map((e) => LineTooltipItem(
                                '${DateFormat.yMd().add_Hm().format(DateTime.fromMillisecondsSinceEpoch(e.x.toInt()))}\n',
                                Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: colorScheme.onPrimaryContainer,
                                    ),
                                children: [
                                  TextSpan(
                                      text: itemState
                                          .transformState(e.y.toString()),
                                      style: Theme.of(context)
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
