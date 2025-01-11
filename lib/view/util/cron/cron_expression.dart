import 'package:flutter/widgets.dart';

import 'cron_day.dart';
import 'cron_hour.dart';
import 'cron_minute.dart';
import 'cron_month.dart';
import 'cron_second.dart';
import 'cron_year.dart';
import 'day_of_month.dart';
import 'day_of_week.dart';
import 'enums/cron_expression_output_format.dart';
import 'enums/cron_expression_type.dart';

class CronExpression {
  CronSecond second;
  CronMinute minute;
  CronHour hour;
  CronDay _day;
  CronMonth month;
  CronYear year;
  CronExpressionType type;

  CronExpression(
    this.second,
    this.minute,
    this.hour,
    this._day,
    this.month,
    this.year,
    this.type,
  );

  // Check if the expression is specific this could also mean that there are multiple dates in the expression
  bool get isSpecific =>
      second.type.isSpecific &&
      minute.type.isSpecific &&
      hour.type.isSpecific &&
      _day.type.isSpecific &&
      month.type.isSpecific &&
      year.type.isSpecific;

  // Check if the expression is a single specific date
  bool get isSingleSpecificDate =>
      second.isSingleSpecific &&
      minute.isSingleSpecific &&
      hour.isSingleSpecific &&
      _day.isSingleSpecific &&
      month.isSingleSpecific &&
      year.isSingleSpecific;

  static CronExpression now() {
    final now = DateTime.now();

    return CronExpression(
      CronSecond(now.second.toString()),
      // Current second
      CronMinute(now.minute.toString()),
      // Current minute
      CronHour(now.hour.toString()),
      // Current hour
      CronDay(
        now.day.toString(),
        '?', // Use '?' for Quartz expressions
        CronExpressionType.QUARTZ,
      ),
      CronMonth(
        now.month.toString(),
        CronExpressionType.QUARTZ,
      ),
      CronYear(now.year.toString()),
      // Current year
      CronExpressionType.QUARTZ, // Default to Quartz for now
    );
  }

  static CronExpression everyHour() {
    return CronExpression.fromString("0 0 * ? * * *");
  }

  factory CronExpression.fromString(String cronExpression) {
    List<String> expressionParts = cronExpression.split(' ');
    if (expressionParts.length < 5) {
      expressionParts = '* * ? * *'.split(' ');
    }
    var expressionType = expressionParts.contains('?')
        ? CronExpressionType.QUARTZ
        : CronExpressionType.STANDARD;
    if (expressionParts.length == 5) {
      expressionParts.insert(0, '');
      expressionParts.add('');
    } else if (expressionParts.length == 6) {
      expressionParts.add('');
    }

    return CronExpression(
      CronSecond(
        expressionParts[0].isEmpty ? null : expressionParts[0],
      ),
      CronMinute(
        expressionParts[1],
      ),
      CronHour(
        expressionParts[2],
      ),
      CronDay(
        expressionParts[3],
        expressionParts[5],
        expressionType,
      ),
      CronMonth(
        expressionParts[4],
        expressionType,
      ),
      CronYear(
        expressionParts[6].isEmpty ? null : expressionParts[6],
      ),
      expressionType,
    );
  }

  factory CronExpression.fromDateTime(DateTime date) {
    return CronExpression(
      CronSecond(date.second.toString()),
      CronMinute(date.minute.toString()),
      CronHour(date.hour.toString()),
      CronDay(
        date.day.toString(),
        '?', // Use '?' for Quartz expressions
        CronExpressionType.QUARTZ,
      ),
      CronMonth(
        date.month.toString(),
        CronExpressionType.QUARTZ,
      ),
      CronYear(date.year.toString()),
      // Current year
      CronExpressionType.QUARTZ, // Default to Quartz for now
    );
  }

  DayOfMonth get dayOfMonth => _day.dayOfMonth;

  DayOfWeek get dayOfWeek => _day.dayOfWeek;

  void reset() {
    second.reset();
    minute.reset();
    hour.reset();
    _day.reset();
    month.reset();
    year.reset();
  }

  @override
  String toString() {
    return toFormatString(CronExpressionOutputFormat.AUTO);
  }

  String toFormatString(CronExpressionOutputFormat outputFormat) {
    return [
      second.toString(),
      minute.toString(),
      hour.toString(),
      dayOfMonth.toString(),
      month.toFormatString(outputFormat),
      dayOfWeek.toFormatString(outputFormat),
      year.toString(),
    ]
        .join(' ')
        .trim()
        .replaceFirst('?', type == CronExpressionType.STANDARD ? '*' : '?');
  }

  String toReadableString(BuildContext context) {
    final pattern = RegExp('\\s+');
    var sentence = [
      second.toReadableString(context),
      minute.toReadableString(context),
      hour.toReadableString(context),
      _day.toReadableString(context),
      month.toReadableString(context),
      year.toReadableString(context),
    ]
        .where((element) => element.isNotEmpty)
        .toList()
        .join(', ')
        .replaceAll(pattern, ' ')
        .trim();

    return _capitalize(sentence);
  }

  DateTime? toDateTime() {
    if (!isSingleSpecificDate) {
      return null;
    } else {
      return DateTime(
        year.specificYears.first,
        month.specificMonths.first,
        dayOfMonth.specificMonthDays.first,
        hour.specificHours.first,
        minute.specificMinutes.first,
        second.specificSeconds.first,
      );
    }
  }

  String _capitalize(String str) {
    if (str.isEmpty) {
      return '';
    }

    return '${str[0].toUpperCase()}${str.substring(1)}';
  }
}
