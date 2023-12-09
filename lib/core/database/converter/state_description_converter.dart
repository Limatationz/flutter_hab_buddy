import 'dart:convert';

import 'package:drift/drift.dart';

import '../../network/generated/openHAB.swagger.dart';

class StateDescriptionConverter extends TypeConverter<StateDescription, String> {
  const StateDescriptionConverter();

  @override
  StateDescription fromSql(String fromDb) {
    return StateDescription.fromJson(jsonDecode(fromDb));
  }

  @override
  String toSql(StateDescription value) {
    return jsonEncode(value.toJson());
  }
}
