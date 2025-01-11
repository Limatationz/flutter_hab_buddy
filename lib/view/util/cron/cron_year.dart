import 'package:flutter/widgets.dart';

import '../../../generated/l10n.dart';
import 'cron_entity.dart';
import 'cron_part.dart';
import 'enums/cron_year_type.dart';

class CronYear extends CronEntity implements CronPart {
  late CronYearType type;
  late int? everyYear;
  late int? everyStartYear;
  late List<int> specificYears;
  late int betweenStartYear;
  late int betweenEndYear;
  late int currentYear;

  bool get isSingleSpecific => specificYears.length == 1;

      CronYear(String? originalValue) : super(originalValue) {
    currentYear = DateTime.now().year;
    setDefaults();
    _setValue(originalValue);
  }

  @override
  void setDefaults() {
    // 2021
    everyYear = null;
    everyStartYear = null;
    specificYears = [startIndex];
    betweenStartYear = startIndex;
    betweenEndYear = startIndex;
  }

  @override
  void reset() {
    type = CronYearType.EVERY;
    setDefaults();
  }

  void setEveryYear() {
    type = CronYearType.EVERY;
  }

  void setEveryYearStartAt(int? year, [int? startYear]) {
    type = CronYearType.EVERY_START_AT;
    everyYear = year;
    everyStartYear = startYear;
  }

  void setSpecificYears(List<int> years) {
    type = CronYearType.SPECIFIC;
    specificYears = years;
  }

  void setBetweenYears(int startYear, int endYear) {
    type = CronYearType.BETWEEN;
    betweenStartYear = startYear;
    betweenEndYear = endYear;
  }

  void _setValue(String? value) {
    type = _getType(value);
    if (value == null) {
      return;
    }
    if (!validate(value)) {
      throw ArgumentError('Invalid year part of expression!');
    }
    switch (type) {
      case CronYearType.EVERY:
        break;
      case CronYearType.EVERY_START_AT:
        var parts = value.split('/');
        everyStartYear = parts[0] == '*' ? null : int.parse(parts[0]);
        everyYear = parts[1] == '*' ? null : int.parse(parts[1]);
        break;
      case CronYearType.SPECIFIC:
        specificYears = value.split(',').map((v) => int.parse(v)).toList();
        break;
      case CronYearType.BETWEEN:
        var parts = value.split('-');
        betweenStartYear = int.parse(parts[0]);
        betweenEndYear = int.parse(parts[1]);
        break;
      case CronYearType.NONE:
        break;
    }
  }

  CronYearType _getType(String? value) {
    if (value == null) {
      return CronYearType.NONE;
    }
    if (value.contains('/')) {
      return CronYearType.EVERY_START_AT;
    } else if (value.contains('*')) {
      return CronYearType.EVERY;
    } else if (value.contains('-')) {
      return CronYearType.BETWEEN;
    }

    return CronYearType.SPECIFIC;
  }

  @override
  String toString() {
    switch (type) {
      case CronYearType.EVERY:
        return '*';
      case CronYearType.EVERY_START_AT:
        return '${everyStartYear ?? '*'}/${everyYear ?? '1'}';
      case CronYearType.SPECIFIC:
        return specificYears.isEmpty
            ? startIndex.toString()
            : specificYears.join(',');
      case CronYearType.BETWEEN:
        return '$betweenStartYear-$betweenEndYear';
      case CronYearType.NONE:
        return '';
    }
  }

  @override
  String toReadableString(BuildContext context) {
    switch (type) {
      case CronYearType.EVERY:
        return S.of(context).cronEveryYear;
      case CronYearType.EVERY_START_AT:
        var year = everyYear ?? 1;
        var startYear = everyStartYear ?? startIndex;
        return year > 1
            ? S.of(context).cronEveryEveryYearsStartingAt(year, startYear)
            : S.of(context).cronStartingInYear(startYear);
      case CronYearType.SPECIFIC:
        var years = specificYears.isEmpty ? [startIndex] : specificYears;
        return years.length == 1
            ? S.of(context).cronInYear(years[0])
            : S.of(context).cronInYearsAnd(
          years.getRange(0, years.length - 1).join(', '),
          years.last,
        );
      case CronYearType.BETWEEN:
        return S.of(context).cronBetweenYears(betweenStartYear, betweenEndYear);
      case CronYearType.NONE:
        return '';
    }
  }

  @override
  bool validate(String part) {
    return true;
  }

  @override
  int get startIndex {
    return currentYear;
  }
}
