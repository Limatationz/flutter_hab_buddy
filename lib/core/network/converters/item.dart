import 'package:drift/drift.dart';

import '../../../util/list.dart';
import '../../database/app_database.dart';
import '../../database/items/oh_item_type.dart';
import '../../hive/state/item_state.dart';
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
      ohTags: (tags?.isEmptyCheck ?? true) ? const Value.absent() : Value(tags),
      ohGroups: (groupNames?.isEmptyCheck ?? true) ? const Value.absent() : Value(groupNames),
    );
  }

  ItemState? asItemState() {
    if (name == null || label == null || type == null || state == null) {
      return null;
    }
    return ItemState(
      ohName: name!,
      state: state!,
      stateDescription: stateDescription,
      transformedState: transformedState,
      commandDescription: commandDescription,
      ohUnitSymbol:
      unitSymbol,
    );
  }
}
