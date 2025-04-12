import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../locator.dart';
import '../../general/item_widget.dart';
import 'complex_player_data.dart';
import 'complex_player_item_base_widget.dart';

class ComplexPlayerItemWidget extends MediumWidthItemWidget {
  final bool disableTap;
  ComplexPlayerItemWidget({
    super.key,
    required super.item,
    required super.colorScheme,
    this.disableTap = false,
  }) : assert(item != null);

  final _itemsStore = locator<AppDatabase>().itemsStore;

  @override
  Widget build(BuildContext context) {
    final config = ComplexPlayerData.fromJson(item!.complexJson!);
    return ComplexPlayerItemBaseWidget(
      item: item,
      colorScheme: colorScheme,
      playerStateStream: _itemsStore
          .watchStateByName(item!.ohName)
          .whereNotNull(),
      currentDurationStateStream: _itemsStore
          .watchStateByName(config.currentDurationItemName)
          .whereNotNull(),
      totalDurationStateStream: _itemsStore
          .watchStateByName(config.totalDurationItemName)
          .whereNotNull(),
      imageStateStream: config.imageItemName != null
          ? _itemsStore
              .watchStateByName(config.imageItemName!)
              .whereNotNull()
          : null,
      volumeDimmerStateStream: config.volumeDimmerItemName != null
          ? _itemsStore
              .watchStateByName(config.volumeDimmerItemName!)
              .whereNotNull()
          : null,
      disableTap: disableTap,
    );
  }
}
