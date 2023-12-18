import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../util/constants.dart';

abstract class ItemWidget extends StatelessWidget {
  final Item item;
  final ColorScheme colorScheme;
  final int crossAxisCount;
  final double mainAxisCount;

  const ItemWidget(
      {super.key,
      required this.item,
      required this.colorScheme,
      required this.crossAxisCount,
      required this.mainAxisCount});
}

abstract class SmallItemWidget extends ItemWidget {
  const SmallItemWidget(
      {super.key, required super.item, required super.colorScheme})
      : super(
            crossAxisCount: smallGridCrossAxisCount,
            mainAxisCount: smallGridMainAxisCount);
}
