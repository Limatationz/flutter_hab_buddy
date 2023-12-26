import 'dart:convert';

import 'package:drift/drift.dart';

class JsonConverter extends TypeConverter<Map<String, dynamic>?, String?> {
  const JsonConverter();

  @override
  Map<String, dynamic>? fromSql(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return jsonDecode(fromDb);
  }

  @override
  String? toSql(Map<String, dynamic>? value) {
    if (value == null) {
      return null;
    }
    return jsonEncode(value);
  }
}
