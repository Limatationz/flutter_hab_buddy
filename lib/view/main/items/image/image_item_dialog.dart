import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/hive/state/state_utils.dart';
import '../general/item_state_injector.dart';

class ImageItemDialog extends StatelessWidget {
  final String itemName;

  const ImageItemDialog({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: itemName,
        builder: (itemState) {
          final image = parseImage(itemState.state);
          if (image == null) {
            return const SizedBox();
          } else {
            return Flexible(
                child: Align(
                    child:
                        Image.memory(base64Decode(image), fit: BoxFit.cover)));
          }
        });
  }
}
