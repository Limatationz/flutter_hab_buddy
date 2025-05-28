import 'package:flutter/widgets.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/hive/state/item_state.dart';
import '../../../../locator.dart';

class ItemStateInjector extends StatelessWidget {
  final String itemName;
  final Widget Function(ItemState) builder;

  final itemsStore = locator<AppDatabase>().itemsStore;

  ItemStateInjector({
    super.key,
    required this.itemName,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ItemState?>(
        stream: itemsStore.watchStateByName(itemName),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          print("State of $itemName is ${snapshot.data}");
          return builder(snapshot.data!);
        });
  }
}