import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';

class InboxListItem extends StatelessWidget {
  final InboxEntry entry;
  final VoidCallback? onTap;

  const InboxListItem({super.key, required this.entry, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 22),
      title: Text(entry.label),
      subtitle: Text(entry.name),
      trailing: entry.type.icon != null ? Icon(entry.type.icon) : null,
      onTap: onTap,
    );
  }
}
