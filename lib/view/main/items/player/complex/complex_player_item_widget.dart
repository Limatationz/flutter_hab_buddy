import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../locator.dart';
import '../../general/item_widget.dart';
import 'complex_player_data.dart';
import 'complex_player_item_base_widget.dart';

class ComplexPlayerItemWidget extends LargeWidthItemWidget {
  ComplexPlayerItemWidget({
    super.key,
    required super.item,
    required super.colorScheme,
  }) : assert(item != null);

  final _itemsStore = locator<AppDatabase>().itemsStore;

  @override
  Widget build(BuildContext context) {
    final config = ComplexPlayerData.fromJson(item!.complexJson!);
    return ComplexPlayerItemBaseWidget(
      item: item,
      colorScheme: colorScheme,
      playerStateStream: _itemsStore
          .stateByName(item!.ohName)
          .watchSingleOrNull()
          .whereNotNull(),
      currentDurationStateStream: _itemsStore
          .stateByName(config.currentDurationItemName)
          .watchSingleOrNull()
          .whereNotNull(),
      totalDurationStateStream: _itemsStore
          .stateByName(config.totalDurationItemName)
          .watchSingleOrNull()
          .whereNotNull(),
      imageStateStream: config.imageItemName != null
          ? _itemsStore
              .stateByName(config.imageItemName!)
              .watchSingleOrNull()
              .whereNotNull()
          : null,
      volumeDimmerStateStream: config.volumeDimmerItemName != null
          ? _itemsStore
              .stateByName(config.volumeDimmerItemName!)
              .watchSingleOrNull()
              .whereNotNull()
          : null,
    );
  }
}
