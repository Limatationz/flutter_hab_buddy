import 'package:drift/drift.dart';

import '../../../util/list.dart';
import '../../database/app_database.dart';
import '../../database/inbox/inbox_table.dart';
import '../../database/items/oh_item_type.dart';
import '../generated/openHAB.models.swagger.dart';

extension InboxDBConverter on EnrichedItemDTO {
  InboxEntry? asDatabaseModel() {
    if (name == null || label == null || type == null || state == null) {
      return null;
    }
    return InboxEntry(
      type: OhItemType.fromString(type!),
      name: name!,
      label: label!,
      category: category,
      tags: (tags?.isEmptyCheck ?? true) ? null : tags,
      groups: (groupNames?.isEmptyCheck ?? true) ? null : groupNames,
      unitSymbol: unitSymbol,
      state: state!,
      stateDescription: stateDescription,
      commandDescription: commandDescription,
      transformedState: transformedState,
    );
  }

  ItemsTableCompanion? asItemUpdate() {
    if (name == null || label == null || type == null || state == null) {
      return null;
    }
    return ItemsTableCompanion(
      ohType: Value(OhItemType.fromString(type!)),
      ohName: Value(name!),
      ohLabel: Value(label!),
      ohCategory: category != null ? Value(category!) : const Value.absent(),
      ohTags:
          (tags?.isEmptyCheck ?? true) ? const Value.absent() : Value(tags!),
      ohGroups: (groupNames?.isEmptyCheck ?? true)
          ? const Value.absent()
          : Value(groupNames!),
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
