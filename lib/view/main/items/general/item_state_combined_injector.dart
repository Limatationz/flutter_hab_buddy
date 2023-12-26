import 'package:flutter/widgets.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../locator.dart';

class ItemStateCombinedInjector extends StatelessWidget {
  final String itemName;
  final Widget Function(Item, ItemState) builder;

  final itemsStore = locator<AppDatabase>().itemsStore;

  ItemStateCombinedInjector({
    super.key,
    required this.itemName,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ItemWithState?>(
        stream: itemsStore.watchByNameWithState(itemName),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          final item = snapshot.data!.item;
          final state = snapshot.data!.state;
          return builder(item, state);
        });
  }
}