import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import 'cron_entity.dart';
import 'cron_part.dart';
import 'enums/cron_expression_output_format.dart';
import 'enums/cron_expression_type.dart';
import 'enums/cron_month_type.dart';
import 'util.dart';

class CronMonth extends CronEntity implements CronPart {
  late CronMonthType type;
  late int everyMonth;
  late int? everyStartMonth;
  late List<int> specificMonths;
  late int betweenStartMonth;
  late int betweenEndMonth;
  bool useAlternativeValue = false;
  CronExpressionType expressionType;

  bool get isSingleSpecific => specificMonths.length == 1;

  CronMonth(String originalValue, this.expressionType) : super(originalValue) {
    setDefaults();
    _setValue(originalValue);
  }

  @override
  void setDefaults() {
    // 1-12, JAN-DEC, (0-11)
    everyMonth = 1;
    everyStartMonth = null;
    specificMonths = [startIndex];
    betweenStartMonth = startIndex;
    betweenEndMonth = startIndex;
  }

  @override
  void reset() {
    type = CronMonthType.EVERY;
    setDefaults();
  }

  void setEveryMonth() {
    type = CronMonthType.EVERY;
  }

  void setEveryMonthStartAt(int month, [int? startMonth]) {
    type = CronMonthType.EVERY_START_AT;
    everyMonth = month;
    everyStartMonth = startMonth;
  }

  void setSpecificMonths(List<int> months) {
    type = CronMonthType.SPECIFIC;
    specificMonths = months;
  }

  void setBetweenMonths(int startMonth, int endMonth) {
    type = CronMonthType.BETWEEN;
    betweenStartMonth = startMonth;
    betweenEndMonth = endMonth;
  }

  void _setValue(String value) {
    if (!validate(value)) {
      throw ArgumentError('Invalid month part of expression!');
    }
    handleAlternativeValue(value);
    type = _getType(value);
    switch (type) {
      case CronMonthType.EVERY:
        break;
      case CronMonthType.EVERY_START_AT:
        var parts = value.split('/');
        everyStartMonth = parts[0] == '*' ? null : int.parse(parts[0]);
        everyMonth = int.parse(parts[1]);
        break;
      case CronMonthType.SPECIFIC:
        specificMonths = value
            .split(',')
            .map((v) => parseAlternativeValue(v, getMonthMap()))
            .toList();
        break;
      case CronMonthType.BETWEEN:
        var parts = value.split('-');
        betweenStartMonth = parseAlternativeValue(parts[0], getMonthMap());
        betweenEndMonth = parseAlternativeValue(parts[1], getMonthMap());
        break;
    }
  }

  CronMonthType _getType(String value) {
    if (value.contains('/')) {
      return CronMonthType.EVERY_START_AT;
    } else if (value.contains('*')) {
      return CronMonthType.EVERY;
    } else if (value.contains('-')) {
      return CronMonthType.BETWEEN;
    }

    return CronMonthType.SPECIFIC;
  }

  @override
  String toString() {
    return toFormatString(CronExpressionOutputFormat.AUTO);
  }

  String toFormatString(CronExpressionOutputFormat outputFormat) {
    switch (type) {
      case CronMonthType.EVERY:
        return '*';
      case CronMonthType.EVERY_START_AT:
        return '${everyStartMonth ?? '*'}/$everyMonth';
      case CronMonthType.SPECIFIC:
        return (specificMonths.isEmpty ? [startIndex] : specificMonths)
            .map((v) => convertAlternativeValue(
                  outputFormat.isAlternative(useAlternativeValue),
                  v,
                  getMonthMap(),
                ))
            .toList()
            .join(',');
      case CronMonthType.BETWEEN:
        return '${convertAlternativeValue(outputFormat.isAlternative(useAlternativeValue), betweenStartMonth, getMonthMap())}-${convertAlternativeValue(useAlternativeValue, betweenEndMonth, getMonthMap())}';
    }
  }

  @override
  String toReadableString(BuildContext context) {
    switch (type) {
      case CronMonthType.EVERY:
        return S.of(context).cronEveryMonth;
      case CronMonthType.EVERY_START_AT:
        var startMonth = everyStartMonth ?? 0;
        return startMonth > 0
            ? S
                .of(context)
                .cronEveryEveryMonthsStartingAt(everyMonth, startMonth)
            : S.of(context).cronEveryMonths(everyMonth);
      case CronMonthType.SPECIFIC:
        var months = (specificMonths.isEmpty ? [startIndex] : specificMonths)
            .map((v) => convertAlternativeValue(true, v, getMonthMap()))
            .toList();
        return months.length == 1
            ? S.of(context).cronAtMonth(months[0])
            : S.of(context).cronAtMonthsAnd(
                  months.getRange(0, months.length - 1).join(', '),
                  months.last,
                );
      case CronMonthType.BETWEEN:
        return S.of(context).cronEveryMonthBetweenAnd(
              convertAlternativeValue(true, betweenStartMonth, getMonthMap()),
              convertAlternativeValue(true, betweenEndMonth, getMonthMap()),
            );
    }
  }

  @override
  bool validate(String part) {
    return true;
  }

  void handleAlternativeValue(String value) {
    useAlternativeValue = isAlternativeValue(value, getMonthMap());
  }

  Map<int, String> getMonthMap2() {
    final List<String> monthNames = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OKT',
      'NOV',
      'DEC',
    ];

    return getMapFromIndex(monthNames, startIndex);
  }

  Map<int, String> getMonthMap() {

    final List<String> monthNames = List.generate(12, (index) {
      // Use DateFormat to get the abbreviated month name based on the locale
      return DateFormat.MMM().format(
        DateTime(2023, index + 1, 1), // Use January 1st of each month
      ).toUpperCase(); // Convert to uppercase to match the original style
    });

    return getMapFromIndex(monthNames, startIndex);
  }

  @override
  int get startIndex {
    return expressionType == CronExpressionType.STANDARD ? 1 : 0;
  }
}
