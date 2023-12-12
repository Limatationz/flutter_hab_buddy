import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class DimmableIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final double value;

  final Color color;
  final Color? accentColor;

  const DimmableIcon(
      {super.key,
      required this.icon,
      required this.size,
      required this.value,
      this.color = Colors.grey,
      this.accentColor});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [0, value, value],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            accentColor ?? getFallbackAccentColor(context),
            accentColor ?? getFallbackAccentColor(context),
            color
          ],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(icon, size: size, color: Colors.grey),
      ),
    );
  }

  Color getFallbackAccentColor(BuildContext context) =>
      DynamicTheme.of(context)!.theme.colorScheme.primary;
}
