import 'package:flutter/material.dart';

import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../general/item_state_injector.dart';

class PlayerItemDialog extends StatelessWidget {
  final String itemName;
  final ColorScheme colorScheme;
  final _itemRepository = locator<ItemRepository>();

 PlayerItemDialog(
      {super.key, required this.itemName, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: itemName,
        builder: (itemState) {
          final isPlaying = itemState.state == "PLAY";
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => onAction("PREVIOUS"),
                icon: const Icon(LineIconsFilled.previous),
              ),
              if (!isPlaying)
                IconButton.filled(
                  style: IconButton.styleFrom(
                      backgroundColor: colorScheme.primary),
                  onPressed: () => onAction("PLAY"),
                  icon: const Icon(LineIcons.play),
                )
              else
                IconButton.filled(
                  style: IconButton.styleFrom(
                      backgroundColor: colorScheme.primary),
                  onPressed: () => onAction("PAUSE"),
                  icon: const Icon(LineIcons.pause),
                ),
              IconButton(
                onPressed: () => onAction("NEXT"),
                icon: const Icon(LineIconsFilled.next),
              ),
            ],
          );
        });
  }

  Future<void> onAction(String action) async {
    await _itemRepository.stringAction(itemName, action);
  }
}
