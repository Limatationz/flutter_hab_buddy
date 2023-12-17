import 'package:drift/drift.dart';
import 'package:sprintf/sprintf.dart';

import '../../../view/util/constants.dart';
import '../app_database.dart';
import '../converter/command_description_converter.dart';
import '../converter/icon_data_converter.dart';
import '../converter/state_description_converter.dart';
import '../converter/string_list_converter.dart';
import 'item_type.dart';
import 'oh_item_type.dart';

@DataClassName("Item")
class ItemsTable extends Table {
  TextColumn get type => textEnum<ItemType>()();

  TextColumn get ohType => textEnum<OhItemType>()();

  TextColumn get ohName => text()();

  TextColumn get ohLabel => text()();

  TextColumn get customLabel => text().nullable()();

  TextColumn get ohCategory => text().nullable()();

  TextColumn get ohTags => text().map(const StringListConverter()).nullable()();

  TextColumn get ohGroups =>
      text().map(const StringListConverter()).nullable()();

  TextColumn get ohUnitSymbol => text().nullable()();

  IntColumn get roomId => integer()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  TextColumn get icon => text().map(const IconDataConverter()).nullable()();

  TextColumn get state => text()();

  TextColumn get transformedState => text().nullable()();

  TextColumn get stateDescription =>
      text().map(const StateDescriptionConverter()).nullable()();

  TextColumn get commandDescription =>
      text().map(const CommandDescriptionConverter()).nullable()();

  RealColumn get score => real().withDefault(const Constant(0))();

  RealColumn get newScore => real().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {ohName};

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY(room_id) REFERENCES rooms_table(id)',
      ];
}

class ItemWithRoom {
  final Item item;
  final Room room;

  ItemWithRoom(this.item, this.room);
}

extension ItemLabel on Item {
  String get label => customLabel ?? ohLabel;

  String get itemState {
    if (transformedState != null) {
      return transformedState!;
    } else if (ohUnitSymbol != null) {
      return '$state $ohUnitSymbol';
    } else if (stateDescription?.pattern != null) {
      try {
        return sprintf(stateDescription!.pattern!, [typeState]);
      } catch (e) {
        return stateDescription!.pattern!.replaceFirst(RegExp(r'(\S+)'), state);
      }
    } else {
      return state;
    }
  }

  dynamic get typeState {
    final doubleValue = double.tryParse(state);
    if (doubleValue != null) {
      return doubleValue;
    }
    final intValue = int.tryParse(state);
    if (intValue != null) {
      return intValue;
    }
    return state;
  }

  bool get isReadOnly => stateDescription?.readOnly ?? false;

  bool get isSensor =>
      type == ItemType.temperature ||
      type == ItemType.humidity ||
      type == ItemType.airPressure ||
      type == ItemType.airQuality ||
      type == ItemType.presence;

  int get crossAxisCount {
    if(isSensor) {
      return 1;
    }

    switch (ohType) {
      case OhItemType.button:
      case OhItemType.dimmer:
      case OhItemType.rollershutter:
      case OhItemType.string:
      case OhItemType.number:
        return smallGridCrossAxisCount;
      default:
        return 1;
    }
  }

  double get mainAxisCount {
    if(isSensor) {
      return 0.5;
    }

    switch (ohType) {
      case OhItemType.button:
      case OhItemType.dimmer:
      case OhItemType.rollershutter:
      case OhItemType.string:
      case OhItemType.number:
        return smallGridMainAxisCount;
      default:
        return 1;
    }
  }
}
