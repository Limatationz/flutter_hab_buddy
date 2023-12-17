import 'package:flutter/material.dart';

/// Convert hex color to color
///
/// Example:
/// ```dart
/// HexColor('#FFFFFF')
/// ```
///
/// Returns [Color]
Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

extension HexColor on Color {
  /// Convert color to hex color
  ///
  /// Example:
  /// ```dart
  /// Colors.white.toHex()
  /// ```
  ///
  /// Returns [String]
  String toHex() => '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
}
