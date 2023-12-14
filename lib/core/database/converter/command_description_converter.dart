import 'dart:convert';

import 'package:drift/drift.dart';

import '../../network/generated/openHAB.swagger.dart';

class CommandDescriptionConverter extends TypeConverter<CommandDescription, String> {
  const CommandDescriptionConverter();

  @override
  CommandDescription fromSql(String fromDb) {
    return CommandDescription.fromJson(jsonDecode(fromDb));
  }

  @override
  String toSql(CommandDescription value) {
    return jsonEncode(value.toJson());
  }
}
