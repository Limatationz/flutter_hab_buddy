import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show IconData;

import '../../../util/icons/icons.dart';
import '../converter/icon_data_converter.dart';
import '../converter/string_list_converter.dart';

@DataClassName("Room")
class RoomsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get icon => text().map(const IconDataConverter()).nullable()();
  TextColumn get color => text().nullable()();
  IntColumn get level => integer().nullable()();
}
