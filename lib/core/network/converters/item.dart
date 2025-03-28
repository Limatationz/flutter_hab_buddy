import 'package:drift/drift.dart';

import '../../../util/list.dart';
import '../../database/app_database.dart';
import '../../database/items/oh_item_type.dart';
import '../generated/openHAB.models.swagger.dart';

extension ItemDBConverter on EnrichedItemDTO {

  ItemsTableCompanion? asDatabaseModel() {
    if (name == null || label == null || type == null || state == null) {
      return null;
    }
    return ItemsTableCompanion.insert(
      ohType: OhItemType.fromString(type!),
      ohName: name!,
      ohLabel: label!,
      ohCategory: Value(category),
      ohTags: Value((tags?.isEmptyCheck ?? true) ? null : tags),
      ohGroups: Value((groupNames?.isEmptyCheck ?? true) ? null : groupNames),
    );
  }

  ItemStatesTableCompanion? asItemStateUpdate() {
    if (name == null || label == null || type == null || state == null) {
      return null;
    }
    return ItemStatesTableCompanion(
      ohName: Value(name!),
      state: Value(state!),
      stateDescription: stateDescription != null
          ? Value(stateDescription!)
          : const Value.absent(),
      transformedState: transformedState != null
          ? Value(transformedState!)
          : const Value.absent(),
      commandDescription: commandDescription != null
          ? Value(commandDescription!)
          : const Value.absent(),
      ohUnitSymbol:
      unitSymbol != null ? Value(unitSymbol!) : const Value.absent(),
    );
  }
}
