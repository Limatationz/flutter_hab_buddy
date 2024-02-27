import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../util/constants.dart';

abstract class ItemWidget extends StatelessWidget {
  final Item? item;
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
  static const double width = smallGridCrossAxisCount * itemListCountBreakpoint;
  static const double height = smallGridMainAxisCount * itemListCountBreakpoint;

  const SmallItemWidget(
      {super.key, required super.item, required super.colorScheme})
      : super(
            crossAxisCount: smallGridCrossAxisCount,
            mainAxisCount: smallGridMainAxisCount);
}

abstract class MediumWidthItemWidget extends ItemWidget {
  static const double width = smallGridCrossAxisCount * 2 * itemListCountBreakpoint;
  static const double height = smallGridMainAxisCount * itemListCountBreakpoint;

  const MediumWidthItemWidget(
      {super.key, required super.item, required super.colorScheme})
      : super(
      crossAxisCount: smallGridCrossAxisCount * 2,
      mainAxisCount: smallGridMainAxisCount);
}

abstract class MediumItemWidget extends ItemWidget {
  static const double width = smallGridCrossAxisCount * 2 * itemListCountBreakpoint;
  static const double height = smallGridMainAxisCount * 2 * itemListCountBreakpoint;

  const MediumItemWidget(
      {super.key, required super.item, required super.colorScheme})
      : super(
      crossAxisCount: smallGridCrossAxisCount * 2,
      mainAxisCount: smallGridMainAxisCount * 2);
}

abstract class LargeWidthItemWidget extends ItemWidget {
  static const double width = smallGridCrossAxisCount * 3 * itemListCountBreakpoint;
  static const double height = smallGridMainAxisCount * itemListCountBreakpoint;

  const LargeWidthItemWidget(
      {super.key, required super.item, required super.colorScheme})
      : super(
      crossAxisCount: smallGridCrossAxisCount * 3,
      mainAxisCount: smallGridMainAxisCount);
}

abstract class LargeWidthMediumHeightItemWidget extends ItemWidget {
  static const double width = smallGridCrossAxisCount * 3 * itemListCountBreakpoint;
  static const double height = smallGridMainAxisCount * 2 * itemListCountBreakpoint;

  const LargeWidthMediumHeightItemWidget(
      {super.key, required super.item, required super.colorScheme})
      : super(
      crossAxisCount: smallGridCrossAxisCount * 3,
      mainAxisCount: smallGridMainAxisCount * 2);
}
