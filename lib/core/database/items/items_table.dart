import 'dart:math';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show Colors;

import '../../hive/state/item_state.dart';
import '../../network/generated/openHAB.models.swagger.dart';
import '../app_database.dart';
import '../converter/icon_data_converter.dart';
import '../converter/json_converter.dart';
import '../converter/string_list_converter.dart';
import '../rooms/rooms_table.dart';
import 'item_type.dart';
import 'oh_item_type.dart';

@DataClassName("Item")
class ItemsTable extends Table {
  TextColumn get type => textEnum<ItemType>().nullable()();

  TextColumn get ohType => textEnum<OhItemType>()();

  TextColumn get ohName => text()();

  TextColumn get ohLabel => text()();

  TextColumn get customLabel => text().nullable()();

  TextColumn get ohCategory => text().nullable()();

  TextColumn get ohTags => text().map(const StringListConverter()).nullable()();

  TextColumn get ohGroups =>
      text().map(const StringListConverter()).nullable()();

  IntColumn get roomId => integer().references(RoomsTable, #id).nullable()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  TextColumn get icon => text().map(const IconDataConverter()).nullable()();

  RealColumn get score => real().withDefault(const Constant(0))();

  RealColumn get newScore => real().withDefault(const Constant(0))();

  IntColumn get manualOrderIndex => integer().withDefault(const Constant(0))();

  TextColumn get complexJson => text().map(const JsonConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {ohName};
}

class ItemWithRoom {
  final Item item;
  final Room room;

  ItemWithRoom(this.item, this.room);
}

class ItemWithState {
  final Item item;
  final ItemState state;

  ItemWithState(this.item, this.state);
}

extension ItemExtension on Item {
  bool get isInInbox => roomId == null;

  String get label => customLabel ?? ohLabel;

  bool get isSensor =>
      type == ItemType.temperature ||
      type == ItemType.humidity ||
      type == ItemType.airPressure ||
      type == ItemType.airQuality ||
      type == ItemType.presence;

  dynamic get defaultValue {
    switch (ohType) {
      case OhItemType.number:
        return 0;
      case OhItemType.string:
        return '';
      case OhItemType.button:
        return false;
      case OhItemType.dimmer:
        return 0;
      case OhItemType.rollershutter:
        return 0;
      case OhItemType.dateTime:
        return DateTime.now();
      case OhItemType.color:
        return Colors.primaries[Random().nextInt(Colors.primaries.length)];
      case OhItemType.contact:
        return false;
      default:
       return null;
    }
  }

  bool equalsDTO(EnrichedItemDTO other) {
    final companion = toCompanion(true);
    return companion.ohName.value == other.name &&
        companion.ohLabel.value == other.label &&
        companion.ohCategory.value == other.category &&
        (companion.ohTags.value ?? []).equals(other.tags ?? []) &&
        (companion.ohGroups.value ?? []).equals(other.groupNames ?? []);
  }
}
