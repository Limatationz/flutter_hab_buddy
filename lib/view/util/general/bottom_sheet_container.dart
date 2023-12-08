import 'package:flutter/material.dart';

import '../constants.dart';

class BottomSheetContainer extends Container {
  BottomSheetContainer(
      {super.key,
        required Widget child,
        EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(
            paddingScaffold, 20.0, paddingScaffold, 20.0),
        super.constraints,
        super.height})
      : super(child: Padding(padding: padding, child: child));
}

