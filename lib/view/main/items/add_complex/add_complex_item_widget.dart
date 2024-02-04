import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../generated/l10n.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../../../util/general/widget_container.dart';
import 'add_complex_item_selection_sheet.dart';

class AddComplexItemWidget extends StatelessWidget {
  final ColorScheme colorScheme;
  final int roomId;

  const AddComplexItemWidget(
      {super.key, required this.colorScheme, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
        crossAxisCellCount: smallGridCrossAxisCount,
        mainAxisCellCount: smallGridMainAxisCount,
        child: WidgetContainer(
          colorScheme: colorScheme,
          backgroundColor: colorScheme.secondaryContainer,
          onTap: () => onTap(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoHyphenatingText(S.of(context).addComplexItem,
                  maxLines: 3, style: Theme.of(context).textTheme.titleMedium),
              const Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(LineIcons.plus, size: iconSize)),
            ],
          ),
        ));
  }

  void onTap(BuildContext context) {
    AddComplexItemSelectionSheet.openSheet(context, roomId);
  }
}
