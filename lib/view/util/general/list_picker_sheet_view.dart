import 'package:flutter/material.dart';


import '../../../generated/l10n.dart';
import '../../../util/icons/icons.dart';
import '../constants.dart';
import '../general/base_elevated_button.dart';
import '../general/better_divider.dart';

class ListPickerSheetView<T> extends StatefulWidget {
  final List<T> options;
  final T? option;
  final Function(T?) onOptionChange;
  final String Function(T)? optionToString;
  final bool canSelectNone;

  const ListPickerSheetView(
      {super.key,
      required this.options,
      this.option,
      required this.onOptionChange,
      this.canSelectNone = false,
      this.optionToString});

  @override
  _ListPickerSheetViewState<T> createState() => _ListPickerSheetViewState<T>();
}

class _ListPickerSheetViewState<T> extends State<ListPickerSheetView<T>> {
  T? _option;

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
          const SizedBox(height: largePadding),
          BaseElevatedButton(
            fullWidth: true,
            text: S.of(context).done,
            onPressed: _option == null && !widget.canSelectNone ? null : () {
              widget.onOptionChange(_option);
              Navigator.of(context).pop();
            },
          )
        ]);
  }

  Widget getListView(BuildContext context) => ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: widget.options.length,
      itemBuilder: (BuildContext context, int index) {
        final currentOption = widget.options[index];
        return ListTile(
          title: Text(
              widget.optionToString?.call(currentOption) ??
                  currentOption.toString(),
              style: Theme.of(context).textTheme.bodyLarge),
          trailing: _option == currentOption
              ? Icon(
                  LineIcons.checkmark,
                  color: Theme.of(context).colorScheme.secondary,
                )
              : const SizedBox.shrink(),
          onTap: () {
            setState(() {
              if (_option != currentOption) {
                _option = currentOption;
              } else if (widget.canSelectNone) {
                _option = null;
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
