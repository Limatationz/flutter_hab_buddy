import 'package:drift/drift.dart';

import '../../../util/list.dart';
import '../../database/app_database.dart';
import '../../database/inbox/inbox_table.dart';
import '../generated/openHAB.models.swagger.dart';

extension InboxDBConverter on EnrichedItemDTO {
  InboxEntry? asDatabaseModel() {
    if (name == null || label == null || type == null || state == null) {
      return null;
    }
    return InboxEntry(
      type: InboxEntryType.fromString(type!),
      name: name!,
      label: label!,
      category: category,
      tags: (tags?.isEmptyCheck ?? true) ? null : tags,
      groups: (groupNames?.isEmptyCheck ?? true) ? null : groupNames,
      state: state!,
      stateDescription: stateDescription,
      transformedState: transformedState,
    );
  }

  ItemsTableCompanion? asItemUpdate() {
    if (name == null || label == null || type == null || state == null) {
      return null;
    }
    return ItemsTableCompanion(
      ohType: Value(InboxEntryType.fromString(type!)),
      ohName: Value(name!),
      ohLabel: Value(label!),
      ohCategory: category != null ? Value(category!) : const Value.absent(),
      ohTags: (tags?.isEmptyCheck ?? true) ? const Value.absent() : Value(tags!),
      ohGroups: (groupNames?.isEmptyCheck ?? true) ? const Value.absent() : Value(groupNames!),
      state: Value(state!),
      stateDescription: stateDescription != null ? Value(stateDescription!) : const Value.absent(),
      transformedState: transformedState != null ? Value(transformedState!) : const Value.absent(),
    );
  }
}
