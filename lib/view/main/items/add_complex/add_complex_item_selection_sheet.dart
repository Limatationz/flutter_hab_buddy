import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart'
    as modal_bottom_sheet;

import '../../../../core/database/items/item_type.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../../../util/general/headline_padding_box.dart';
import '../general/item_widget_factory.dart';

class AddComplexItemSelectionSheet extends StatelessWidget {
  final int roomId;

  const AddComplexItemSelectionSheet({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(
              paddingScaffold, paddingScaffold, paddingScaffold, 0),
          child: Row(
            children: [
              Expanded(
                  child: Text("Add Complex Item",
                      style: Theme.of(context).textTheme.headlineMedium)),
              const Gap(12),
              IconButton.filled(
                  iconSize: 18,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(LineIcons.close))
            ],
          )),
      const HeadlinePaddingBox(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingScaffold),
          child: LayoutBuilder(
              builder: (context, constraints) => StaggeredGrid.count(
                    crossAxisCount: getItemListCount(constraints.maxWidth),
                    mainAxisSpacing: listSpacing,
                    crossAxisSpacing: listSpacing,
                    children: ItemType.getComplexWidgets(context)
                        .map((e) => StaggeredGridTile.count(
                            crossAxisCellCount: e.item2.crossAxisCount,
                            mainAxisCellCount: e.item2.mainAxisCount,
                            child: InkWell(
                                onTap: () =>
                                    ItemWidgetFactory.openComplexAddView(
                                            context, e.item1, roomId)
                                        .then((value) {
                                      if (value) {
                                        Navigator.of(context).pop();
                                      }
                                    }),
                                child: e.item2)))
                        .toList(),
                  )))
    ]));
  }

  static openSheet(BuildContext context, int roomId) {
    modal_bottom_sheet.showMaterialModalBottomSheet(
        useRootNavigator: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        builder: (_) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: AddComplexItemSelectionSheet(
              roomId: roomId,
            )));
  }
}
