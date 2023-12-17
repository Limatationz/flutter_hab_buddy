import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../generated/l10n.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../../../util/general/widget_container.dart';

class AddComplexItemWidget extends StatelessWidget {
  final ColorScheme colorScheme;

  const AddComplexItemWidget({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
        crossAxisCellCount: smallGridCrossAxisCount,
        mainAxisCellCount: smallGridMainAxisCount, child: WidgetContainer(
      colorScheme: colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoHyphenatingText(S.of(context).addComplexItem,
              maxLines: 3,
              style: DynamicTheme.of(context)!.theme.textTheme.titleMedium),
          const Align(
              alignment: Alignment.bottomRight,
              child: Icon(LineIcons.plus, size: iconSize)),
        ],
      ),
    ));
  }
}
