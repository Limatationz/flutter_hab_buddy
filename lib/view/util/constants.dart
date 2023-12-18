import 'package:flutter/material.dart';

const double paddingScaffold = 16.0;
const double borderRadiusContainer = 12.0;
const double borderRadiusPillContainer = 32.0;
const double listSpacing = 12.0;
const double smallListSpacing = 6.0;
const double paddingContainer = 8.0;
const double paddingPillContainer = 4.0;
const double marginContainer = 16.0;

// item widgets
const double itemListCountBreakpoint = 60;
const double roomListCountBreakpoint = 400;
const double iconSize = 32;
const smallGridCrossAxisCount = 2;
const smallGridMainAxisCount = 2.1;

// item list
int getItemListCount(double width) {
  return (width / itemListCountBreakpoint).floor();
}

// room list
int getRoomListCount(double width) {
  final count = (width / roomListCountBreakpoint).floor() + 1;
  return count;
}
