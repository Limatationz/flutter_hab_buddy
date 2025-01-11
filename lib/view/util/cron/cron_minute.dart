

import 'package:flutter/widgets.dart';

import '../../../generated/l10n.dart';
import 'cron_entity.dart';
import 'cron_part.dart';
import 'enums/cron_minute_type.dart';
import 'util.dart';

class CronMinute extends CronEntity implements CronPart {
  late CronMinuteType type;
  late int everyMinute;
  late int? everyStartMinute;
  late List<int> specificMinutes;
  late int betweenStartMinute;
  late int betweenEndMinute;

  bool get isSingleSpecific => specificMinutes.length == 1;

  CronMinute(String originalValue) : super(originalValue) {
    setDefaults();
    _setValue(originalValue);
  }

  @override
  void setDefaults() {
    // 0-59
    everyMinute = 1;
    everyStartMinute = null;
    specificMinutes = [startIndex];
    betweenStartMinute = startIndex;
    betweenEndMinute = startIndex;
  }

  @override
  void reset() {
    type = CronMinuteType.EVERY;
    setDefaults();
  }

  void setEveryMinute() {
    type = CronMinuteType.EVERY;
  }

  void setEveryMinuteStartAt(int minute, [int? startMinute]) {
    type = CronMinuteType.EVERY_START_AT;
    everyMinute = minute;
    everyStartMinute = startMinute;
  }

  void setSpecificMinutes(List<int> minutes) {
    type = CronMinuteType.SPECIFIC;
    specificMinutes = minutes;
  }

  void setBetweenMinutes(int startMinute, int endMinute) {
    type = CronMinuteType.BETWEEN;
    betweenStartMinute = startMinute;
    betweenEndMinute = endMinute;
  }

  void _setValue(String value) {
    if (!validate(value)) {
      throw ArgumentError('Invalid minute part of expression!');
    }
    type = _getType(value);
    switch (type) {
      case CronMinuteType.EVERY:
        break;
      case CronMinuteType.EVERY_START_AT:
        var parts = value.split('/');
        everyStartMinute = parts[0] == '*' ? null : int.parse(parts[0]);
        everyMinute = int.parse(parts[1]);
        break;
      case CronMinuteType.SPECIFIC:
        specificMinutes = value.split(',').map((v) => int.parse(v)).toList();
        break;
      case CronMinuteType.BETWEEN:
        var parts = value.split('-');
        betweenStartMinute = int.parse(parts[0]);
        betweenEndMinute = int.parse(parts[1]);
        break;
    }
  }

  CronMinuteType _getType(String value) {
    if (value.contains('/')) {
      return CronMinuteType.EVERY_START_AT;
    } else if (value.contains('*')) {
      return CronMinuteType.EVERY;
    } else if (value.contains('-')) {
      return CronMinuteType.BETWEEN;
    }

    return CronMinuteType.SPECIFIC;
  }

  @override
  String toString() {
    switch (type) {
      case CronMinuteType.EVERY:
        return '*';
      case CronMinuteType.EVERY_START_AT:
        return '${everyStartMinute ?? '*'}/$everyMinute';
      case CronMinuteType.SPECIFIC:
        return (specificMinutes.isEmpty ? [startIndex] : specificMinutes)
            .join(',');
      case CronMinuteType.BETWEEN:
        return '$betweenStartMinute-$betweenEndMinute';
    }
  }

  @override
  String toReadableString(BuildContext context) {
    switch (type) {
      case CronMinuteType.EVERY:
        return S.of(context).cronEveryMinute;
      case CronMinuteType.EVERY_START_AT:
        var startMinute = everyStartMinute ?? 0;
        return startMinute > 0
            ? S.of(context).cronEveryEveryMinutesStartingAt(everyMinute, startMinute)
            : S.of(context).cronEveryMinutes(everyMinute);
      case CronMinuteType.SPECIFIC:
        var minutes = specificMinutes.isEmpty ? [startIndex] : specificMinutes;
        return minutes.length == 1
            ? S.of(context).cronAtMinute(minutes[0])
            : S.of(context).cronAtMinutesAnd(
          minutes.getRange(0, minutes.length - 1).join(', '),
          minutes.last,
        );
      case CronMinuteType.BETWEEN:
        return S.of(context).cronEveryMinuteBetweenAnd(betweenStartMinute, betweenEndMinute);
    }
  }

  @override
  bool validate(String part) {
    return true;
  }

  Map<int, String> getEveryMinuteMap() {
    return rangeListToMap(generateRangeList(1, 60));
  }

  Map<int, String> getMinuteMap() {
    return rangeListToMap(generateRangeList(0, 60), converter: (int num) {
      return num.toString().padLeft(2, '0');
    });
  }

  @override
  int get startIndex {
    return 0;
  }
}
