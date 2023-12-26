import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../generated/l10n.dart';
import '../../../util/icons/icons.dart';
import '../general/base_elevated_button.dart';
import '../general/better_divider.dart';
import '../general/bottom_sheet_container.dart';

class ListPickerSheetView<T> extends StatefulWidget {
  final List<T> options;
  final int option;
  final Function(int) onOptionChange;
  final bool canSelectNone;

  const ListPickerSheetView(
      {super.key,
      required this.options,
      required this.option,
      required this.onOptionChange,
      this.canSelectNone = false});

  @override
  _ListPickerSheetViewState createState() => _ListPickerSheetViewState();
}

class _ListPickerSheetViewState extends State<ListPickerSheetView> {
  int _option = 0;

  @override
  void initState() {
    _option = widget.option;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: getListView(context)),
              const SizedBox(height: 16),
              BaseElevatedButton(
                text: S.of(context).done,
                onPressed: () {
                  widget.onOptionChange(_option);
                  context.pop(_option);
                },
                fullSizeOnDesktop: true,
              )
            ]);
  }

  Widget getListView(BuildContext context) => ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: widget.options.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(widget.options[index].toString(),
              style: Theme.of(context).textTheme.bodyLarge),
          trailing: _option == index
              ? Icon(
                  LineIcons.checkmark,
                  color: Theme.of(context).colorScheme.secondary,
                )
              : const SizedBox.shrink(),
          onTap: () {
            setState(() {
              if (_option != index) {
                _option = index;
              } else if (widget.canSelectNone) {
                _option = -1;
              }
            });
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return BetterDivider(
          context: context,
          padding: false,
        );
      });
}
