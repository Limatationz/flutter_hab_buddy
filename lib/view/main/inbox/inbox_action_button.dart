import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../util/icons/icons.dart';
import 'inbox_view.dart';

class InboxActionButton extends StatelessWidget {
  final Stream<int> countInbox;
  final Future<int?>? getRoomId;

  const InboxActionButton(
      {super.key, required this.countInbox, this.getRoomId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: countInbox,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return badges.Badge(
          badgeContent: Text(snapshot.data.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(
                      fontSize: 10,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer)),
          position: badges.BadgePosition.topEnd(top: 0, end: 0),
          badgeStyle: badges.BadgeStyle(
            badgeColor:
                Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(4),
          ),
          badgeAnimation: const badges.BadgeAnimation.fade(
              animationDuration: Duration(milliseconds: 200)),
          showBadge: count > 0,
          child: IconButton(
            onPressed: () async {
              final roomId = await getRoomId;
              showMaterialModalBottomSheet(
                  useRootNavigator: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                  builder: (_) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: InboxView(
                        roomId: roomId,
                      )));
            },
            icon: Icon(LineIcons.plus,
                color: Theme.of(context).colorScheme.primary),
          ),
        );
      },
    );
  }
}
