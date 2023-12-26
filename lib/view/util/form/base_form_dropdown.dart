import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../util/icons/icons.dart';

class BaseFormDropdown<T> extends StatelessWidget {
  final String name;
  final String label;
  final String? helperText;
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final String? Function(dynamic)? validator;
  final void Function(T?)? onChanged;
  final dynamic initialValue;
  final Widget? suffixIcon;
  final bool required;

  const BaseFormDropdown(
      {super.key,
      required this.name,
      required this.label,
      this.helperText,
      this.hintText,
      required this.items,
      this.validator,
      this.onChanged,
      this.initialValue,
      this.suffixIcon, this.required = true});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<T>(
      name: name,
      decoration: InputDecoration(
          labelText: required ? "$label*" : label,
          border: const OutlineInputBorder(),
          helperText: helperText,
          helperMaxLines: 3,
          hintText: hintText,
          isDense: true,
          suffixIcon: suffixIcon),
      icon: const Icon(LineIcons.chevron_down),
      items: items,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
