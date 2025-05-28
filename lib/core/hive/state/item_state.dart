import 'package:hive_ce/hive.dart';
import 'package:sprintf/sprintf.dart';

import '../../network/overrides/command_description.dart';
import '../../network/overrides/state_description.dart';

class ItemState extends HiveObject {
  final String ohName;
  String state;

  String? transformedState;

  StateDescription? stateDescription;

  CommandDescription? commandDescription;

  String? ohUnitSymbol;

  ItemState({
    required this.ohName,
    required this.state,
    this.transformedState,
    this.stateDescription,
    this.commandDescription,
    this.ohUnitSymbol,
  });

  @override
  String toString() {
    return "{State: $state, TransformedState: $transformedState, unit: $ohUnitSymbol}";
  }
}

extension FormattedState on ItemState {
  String get itemState => transformState(state);

  String transformState(String state) {
    if (transformedState != null) {
      return transformedState!;
    } else if (stateDescription?.pattern != null) {
      try {
        final text = sprintf(stateDescription!.pattern!, [getTypeState(state)]);
        if (ohUnitSymbol != null) {
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

  double? get doubleState {
    // regex to match numbers with optional decimal point
    final regex = RegExp(r'(-?\d+(?:[\.,]\d+)?)');

    final match = regex.firstMatch(state);
    if (match != null) {
      // Ersetze , durch . für Dart-kompatibles Parsing
      return double.tryParse(match.group(0)!.replaceAll(',', '.'));
    }

    return null;
  }

  String? get doubleStateWithUnit {
    final doubleValue = doubleState;

    if (doubleValue != null && ohUnitSymbol != null) {
      return "$doubleValue $ohUnitSymbol";
    }
    return doubleValue?.toString();
  }

  bool get isReadOnly => stateDescription?.readOnly ?? false;
}
