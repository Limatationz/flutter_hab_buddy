import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BaseAlphabetListView extends StatelessWidget {
  final Iterable<AlphabetListViewItemGroup> items;
  final ScrollController? scrollController;

  const BaseAlphabetListView(
      {super.key, required this.items, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return AlphabetListView(
        items: items,
        scrollController: scrollController,
        options: AlphabetListViewOptions(
            listOptions: const ListOptions(
              showSectionHeader: false,
              padding: EdgeInsets.fromLTRB(
                  paddingScaffold, 0, paddingScaffold, paddingScaffold),
            ),
            overlayOptions: OverlayOptions(
              overlayBuilder: (context, symbol) {
                return Material(
                    elevation: 3,
                    type: MaterialType.card,
                    color: ColorScheme.of(context).secondaryContainer,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(borderRadiusContainer)),
                    child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Center(
                          child: Text(
                            symbol,
                            style: TextStyle(
                              fontSize: 36,
                              color:
                                  ColorScheme.of(context).onSecondaryContainer,
                            ),
                          ),
                        )));
              },
            ),
            scrollbarOptions: ScrollbarOptions(symbolBuilder: (
              BuildContext context,
              String symbol,
              AlphabetScrollbarItemState state,
            ) {
              if (state == AlphabetScrollbarItemState.active) {
                return Container(
                    decoration: BoxDecoration(
                      color: ColorScheme.of(context).secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: AutoSizeText(
                      symbol,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        color: ColorScheme.of(context).onSecondaryContainer,
                      ),
                    ));
              }
              if (state == AlphabetScrollbarItemState.inactive) {
                return AutoSizeText(
                  symbol,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: ColorScheme.of(context).onSurface,
                  ),
                );
              } else {
                // inactive
                return AutoSizeText(
                  symbol,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, color: Colors.grey),
                );
              }
            })));
  }
}
