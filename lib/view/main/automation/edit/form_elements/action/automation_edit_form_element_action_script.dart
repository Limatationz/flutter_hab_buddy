import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

import 'automation_edit_form_element_action_general.dart';

class AutomationEditFormElementActionScript extends StatelessWidget {
  final RuleActionScript action;
  final RuleActionCallback onChanged;

  const AutomationEditFormElementActionScript(
      {super.key,
      required this.action,
      required this.onChanged,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: min(MediaQuery.of(context).size.height * 0.4, 400),
      child: CodeTheme(
          data: CodeThemeData(styles: monokaiSublimeTheme),
          child: SingleChildScrollView(
            child: CodeField(
              minLines: 12,
              controller: action.controller,
            ),
          )),
    );
  }
}
