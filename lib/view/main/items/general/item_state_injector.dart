import 'package:flutter/widgets.dart';

import '../../../../core/database/app_database.dart';
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
        stream: itemsStore.stateByName(itemName).watchSingleOrNull().distinct(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          return builder(snapshot.data!);
        });
  }
}