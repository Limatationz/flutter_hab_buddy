import 'package:flutter/cupertino.dart';

abstract class CronPart {
  void reset();

  void setDefaults();

  @override
  String toString();

  String toReadableString(BuildContext context);

  bool validate(String part);

  int get startIndex;
}
