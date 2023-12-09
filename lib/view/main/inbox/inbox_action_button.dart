import 'package:badges/badges.dart' as badges;
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../util/icons/icons.dart';
import 'inbox_view.dart';

class InboxActionButton extends StatelessWidget {
  final Stream<int> countInbox;

  const InboxActionButton({super.key, required this.countInbox});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: countInbox,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return badges.Badge(
          badgeContent: Text(snapshot.data.toString(),
              style: DynamicTheme.of(context)!
                  .theme
                  .textTheme
                  .bodySmall!
                  .copyWith(
                      fontSize: 10,
                      color: DynamicTheme.of(context)!
                          .theme
                          .colorScheme
                          .onPrimaryContainer)),
          position: badges.BadgePosition.topEnd(top: 0, end: 0),
          badgeStyle: badges.BadgeStyle(
            badgeColor:
                DynamicTheme.of(context)!.theme.colorScheme.primaryContainer,
            padding: const EdgeInsets.all(4),
          ),
          badgeAnimation: const badges.BadgeAnimation.fade(
              animationDuration: Duration(milliseconds: 200)),
          showBadge: count > 0,
          child: IconButton(
            onPressed: () {
              showMaterialModalBottomSheet(
                  useRootNavigator: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                  builder: (_) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: const InboxView()));
            },
            icon: Icon(LineIcons.plus,
                color: DynamicTheme.of(context)!.theme.colorScheme.primary),
          ),
        );
      },
    );
  }
}
