import 'package:azlistview_plus/azlistview_plus.dart';

import '../app_database.dart';

class InboxListEntry extends ISuspensionBean {
  final InboxEntry entry;

  InboxListEntry(this.entry);

  @override
  String getSuspensionTag() {
    return entry.name[0];
  }
}
