import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import 'alert_dialog_action.dart';

Future<bool?> showDeleteItemDialog({
  required BuildContext context,
  required String itemLabel,
}) =>
    showAdaptiveDialog<bool?>(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              title: Text(S.current.deleteItemDialogHeadline),
              content: Text.rich(TextSpan(children: [
                TextSpan(text: S.current.deleteItemDialogText),
                TextSpan(
                    text: " $itemLabel",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(
                  text: "?",
                ),
              ])),
              actions: [
                AlertDialogAction(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(S.of(context).cancel)),
                AlertDialogAction(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(S.of(context).confirm))
              ],
            ));

Future<bool?> showDeleteRoomDialog({
  required BuildContext context,
  required String roomLabel,
}) =>
    showAdaptiveDialog<bool?>(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          title: Text(S.current.deleteRoomDialogHeadline),
          content: Text.rich(TextSpan(children: [
            TextSpan(text: S.current.deleteRoomDialogText),
            TextSpan(
                text: " $roomLabel",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(
              text: "?",
            ),
          ])),
          actions: [
            AlertDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(S.of(context).cancel)),
            AlertDialogAction(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(S.of(context).confirm))
          ],
        ));
