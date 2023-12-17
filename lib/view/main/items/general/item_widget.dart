import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';

abstract class ItemWidget extends StatelessWidget {
  final Item item;
  final ColorScheme colorScheme;

  const ItemWidget({super.key, required this.item, required this.colorScheme});
}
