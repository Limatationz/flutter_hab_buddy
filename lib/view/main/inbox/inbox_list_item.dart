import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';

class InboxListItem extends StatelessWidget {
  final InboxEntry entry;

  const InboxListItem({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(entry.label),
      subtitle: Text(entry.name),
      leading: entry.type.icon != null ? Icon(entry.type.icon) : null,
    );
  }
}
