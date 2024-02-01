import 'package:flutter/material.dart';

import '../general/item_widget.dart';
import 'weather_item_base_widget.dart';

class WeatherItemWidget extends LargeWidthItemWidget {
  const WeatherItemWidget({
    super.key,
    required super.item,
    required super.colorScheme,
  }) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    return WeatherItemBaseWidget(
      item: item,
      colorScheme: colorScheme,
    );
  }
}
