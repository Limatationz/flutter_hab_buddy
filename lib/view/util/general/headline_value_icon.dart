import 'package:flutter/material.dart';


class HeadlineValueIcon extends StatelessWidget {
  final String title;
  final String data;
  final IconData? icon;
  final Widget? prefix;

  const HeadlineValueIcon(
      {super.key,
      required this.title,
      required this.data,
      this.icon,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "$title:",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null || prefix != null)
            Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    child: prefix ??
                        Icon(
                          icon,
                          size: 20,
                        ))),
          Expanded(
              child: Text(
            data,
            style: Theme.of(context).textTheme.bodyLarge,
          )),
        ],
      ),
    ]);
  }
}
