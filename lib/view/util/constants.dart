import 'package:gap/gap.dart';

const double paddingScaffold = 16.0;
const double borderRadiusContainer = 12.0;
const double borderRadiusPillContainer = 32.0;
const double listSpacing = mediumPadding;
const double smallListSpacing = 6.0;
const double paddingContainer = smallPadding;
const double paddingPillContainer = 4.0;
const double marginContainer = largePadding;

const double extraSmallPadding = 4.0;
const double smallPadding = 8.0;
const double mediumPadding = 12.0;
const double largePadding = 16.0;
const double extraLargePadding = 24.0;

const Gap extraSmallGap = Gap(extraSmallPadding);
const Gap smallGap = Gap(smallPadding);
const Gap mediumGap = Gap(mediumPadding);
const Gap largeGap = Gap(largePadding);
const Gap extraLargeGap = Gap(extraLargePadding);

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
