import '../../database/app_database.dart';
import '../../database/inbox/inbox_table.dart';
import '../generated/openHAB.models.swagger.dart';

extension InboxDBConverter on EnrichedItemDTO {
  InboxEntry? asDatabaseModel() {
    if(name == null || label == null || type == null) {
      return null;
    }
    return InboxEntry(
      type: InboxEntryType.fromString(type!),
      name: name!,
      label: label!,
      category: category,
      tags: tags,
      groups: groupNames,
    );
  }
}