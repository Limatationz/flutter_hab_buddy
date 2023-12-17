import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../../../generated/l10n.dart';
import '../../../util/icons/icons.dart';

class BaseFormIconPicker extends StatefulWidget {
  final Map<String, IconData> iconPack;
  final Function(IconData?) onChange;
  final IconData? selectedIcon;
  final String? helperText;

  const BaseFormIconPicker(
      {super.key,
      required this.iconPack,
      required this.onChange,
      required this.selectedIcon,
      this.helperText});

  @override
  State<BaseFormIconPicker> createState() => _BaseFormIconPickerState();
}

class _BaseFormIconPickerState extends State<BaseFormIconPicker> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: "icon",
      controller: _controller,
      decoration: InputDecoration(
          labelText: S.of(context).icon,
          border: const OutlineInputBorder(),
          helperText: widget.helperText,
          helperMaxLines: 3,
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: widget.selectedIcon != null
              ? Icon(widget.selectedIcon, size: 30)
              : null,
          suffixIcon: widget.selectedIcon != null
              ? GestureDetector(
                  onTap: () {
                    widget.onChange(null);
                    _controller.clear();
                  },
                  child: Icon(LineIcons.close,
                      size: 16,
                      color:
                          DynamicTheme.of(context)!.theme.colorScheme.primary),
                )
              : Icon(LineIcons.chevron_right,
                  color: DynamicTheme.of(context)!.theme.colorScheme.primary)),
      onTap: () => _pickIcon(context),
      readOnly: true,
    );
  }

  void _pickIcon(
    BuildContext context,
  ) async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      customIconPack: widget.iconPack,
      iconPackModes: [IconPack.custom],
      backgroundColor: DynamicTheme.of(context)!.theme.dialogBackgroundColor,
      searchClearIcon: const Icon(LineIcons.close),
      iconColor: DynamicTheme.of(context)!.theme.colorScheme.onSurface,
      iconPickerShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      searchHintText: S.current.search,
      searchIcon: const Icon(LineIcons.search),
      noResultsText: S.current.iconPickerNoResultsText,
      title: Text(S.current.iconPickerTitle),
      closeChild: Text(
        S.current.close,
      ),
    );
    if (icon != null) {
      widget.onChange(icon);
      _controller.text = "  ";
    }
  }
}
