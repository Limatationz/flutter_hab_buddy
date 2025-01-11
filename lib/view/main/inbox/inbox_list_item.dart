import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';

class InboxListItem extends StatelessWidget {
  final InboxEntry entry;
  final VoidCallback? onTap;

  const InboxListItem({super.key, required this.entry, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 26),
    child: ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(entry.label),
      subtitle: Text(entry.name),
      trailing: entry.type.icon != null ? Icon(entry.type.icon) : null,
      onTap: onTap,
    ));
  }
}
