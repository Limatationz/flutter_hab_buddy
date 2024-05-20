import 'package:drift/drift.dart';
import 'package:sprintf/sprintf.dart';

import '../app_database.dart';
import '../converter/command_description_converter.dart';
import '../converter/state_description_converter.dart';

@DataClassName("ItemState")
class ItemStatesTable extends Table {
  TextColumn get ohName => text()();

  TextColumn get state => text()();

  TextColumn get transformedState => text().nullable()();

  TextColumn get stateDescription =>
      text().map(const StateDescriptionConverter()).nullable()();

  TextColumn get commandDescription =>
      text().map(const CommandDescriptionConverter()).nullable()();

  TextColumn get ohUnitSymbol => text().nullable()();

  @override
  Set<Column> get primaryKey => {ohName};

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY(oh_name) REFERENCES items_table(oh_name)',
      ];
}

extension FormattedState on ItemState {
  String get itemState => transformState(state);

  String transformState(String state) {
    if (transformedState != null) {
      return transformedState!;
    } else if (stateDescription?.pattern != null) {
      try {
        final text = sprintf(stateDescription!.pattern!, [getTypeState(state)]);
        if(ohUnitSymbol != null){
          return "$text $ohUnitSymbol";
        } else {
          return text;
        }
      } catch (e) {
        return stateDescription!.pattern!.replaceFirst(RegExp(r'(\S+)'), state);
      }
    } else if (ohUnitSymbol != null) {
      return "$state ${ohUnitSymbol!}";
    } else {
      return state;
    }
  }

  String rawState(String state) {
    if (stateDescription?.pattern != null) {
      try {
        return sprintf(stateDescription!.pattern!, [getTypeState(state)]);
      } catch (e) {
        return stateDescription!.pattern!.replaceFirst(RegExp(r'(\S+)'), state);
      }
    } else {
      return state;
    }
  }

  dynamic getTypeState(String state) {
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
}

extension ItemStateFromInboxEntry on ItemState {
  static ItemState convert(InboxEntry state) => ItemState(
        ohName: state.name,
        state: state.state,
        transformedState: state.transformedState,
        stateDescription: state.stateDescription,
        commandDescription: state.commandDescription,
        ohUnitSymbol: state.unitSymbol,
      );
}
