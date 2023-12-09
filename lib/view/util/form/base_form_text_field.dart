import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../util/icons/icons.dart';

class BaseFormTextField extends StatelessWidget {
  final String name;
  final String label;
  final String? helperText;
  final String? hintText;
  final String? Function(dynamic)? validator;
  final String? Function(dynamic)? onChanged;
  final dynamic initialValue;
  final Widget? suffixIcon;

  const BaseFormTextField(
      {super.key,
      required this.name,
      required this.label,
      this.helperText,
      this.hintText,
      this.validator,
      this.onChanged,
      this.initialValue,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          helperText: helperText,
          helperMaxLines: 3,
          hintText: hintText,
          isDense: true,
          suffixIcon: suffixIcon),
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
