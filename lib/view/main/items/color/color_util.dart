import 'package:color_models/color_models.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../generated/l10n.dart';
import '../../../../util/icons/icons.dart';

class OpenhabColorUtil {
  static HsbColor parseColorState(String state) {
    final splitted = state.split(',');
    if (splitted.length == 3) {
      return HsbColor(
        double.parse(splitted[0]),
        double.parse(splitted[1]),
        double.parse(splitted[2]),
      );
    } else {
      Logger().w('Invalid color state: $state');
      return const HsbColor(0, 0, 0);
    }
  }

  static Future<Color> showColorPicker(
      {required BuildContext context,
        required Color initialColor,
          ColorScheme? colorScheme}) =>
      showColorPickerDialog(
        context,
        initialColor,
        pickersEnabled: const <ColorPickerType, bool>{
          ColorPickerType.both: false,
          ColorPickerType.primary: true,
          ColorPickerType.accent: false,
          ColorPickerType.bw: false,
          ColorPickerType.custom: true,
          ColorPickerType.wheel: true,
        },
        showColorName: true,
        showColorCode: true,
        selectedColorIcon: LineIconsV5.variantfreecheck,
        editIcon: LineIconsV5.variantfreepencil_1,
        colorCodeHasColor: true,
        showEditIconButton: true,
        showRecentColors: true,
        maxRecentColors: 5,
        showMaterialName: true,
        recentColorsSubheading: Text(S.of(context).recentColors),
        columnSpacing: 16,
        backgroundColor: colorScheme?.surface,
        surfaceTintColor: colorScheme?.surfaceTint,
      );
}

extension ColorConverter on HsbColor {
  Color toColor({bool fullOpacity = false}) {
    final rgbColor = toRgbColor();
    return Color.fromRGBO(rgbColor.red, rgbColor.green, rgbColor.blue,
        fullOpacity ? 1.0 : opacity);
  }
}
