import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class BaseElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final bool fullSizeOnDesktop;

  const BaseElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.fullSizeOnDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: width ?? double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ??
                    DynamicTheme.of(context)!.theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                minimumSize: const Size(0, 0),
              ),
              child: Text(
                text,
                style: DynamicTheme.of(context)!
                    .theme
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                        color: textColor ??
                            DynamicTheme.of(context)!
                                .theme
                                .colorScheme
                                .onInverseSurface),
              ),
            ));
  }
}
