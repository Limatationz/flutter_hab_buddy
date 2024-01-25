import 'package:flutter/material.dart';

import '../general/item_widget.dart';
import 'clock_item_base_widget.dart';

class ClockItemWidget extends LargeWidthItemWidget {
  const ClockItemWidget({
    super.key,
    required super.item,
    required super.colorScheme,
  }) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    return ClockItemBaseWidget(
      item: item,
      colorScheme: colorScheme,
    );
  }
}
