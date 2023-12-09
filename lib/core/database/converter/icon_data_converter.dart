import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';

class IconDataConverter extends TypeConverter<IconData, String> {
  const IconDataConverter();

  @override
  IconData fromSql(String fromDb) {
    return IconData(int.parse(fromDb), fontFamily: 'MaterialIcons');
  }

  @override
  String toSql(IconData value) {
    return value.codePoint.toString();
  }
}