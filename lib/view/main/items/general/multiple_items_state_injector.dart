import 'package:flutter/widgets.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/hive/state/item_state.dart';
import '../../../../locator.dart';

class MultipleItemStatesInjector extends StatelessWidget {
  final List<String> itemNames;
  final Widget Function(Map<String, ItemState>) builder;

  final itemsStore = locator<AppDatabase>().itemsStore;

  MultipleItemStatesInjector({
    super.key,
    required this.itemNames,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ItemState?>?>(
        stream: itemsStore.watchStatesByNameList(itemNames).distinct(
            (previous, next) =>
                previous.map((e) => e?.state).join() ==
                next.map((e) => e?.state).join()),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          try {
            final itemStates = snapshot.data!;
            final map = <String, ItemState>{};
            for (int i = 0; i < itemNames.length; i++) {
              if (itemStates[i] != null) {
                map[itemStates[i]!.ohName] = itemStates[i]!;
              }
            }
            return builder(map);
          } catch (e) {
            return const SizedBox.shrink();
          }
        });
  }
}
