
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../general/item_state_injector.dart';

class DimmerItemDialog extends StatefulWidget {
  final String itemName;
  final double initialValue;
  final ColorScheme colorScheme;

  const DimmerItemDialog(
      {super.key,
      required this.itemName,
      required this.initialValue,
      required this.colorScheme});

  @override
  State<DimmerItemDialog> createState() => _DimmerItemDialogState();
}

class _DimmerItemDialogState extends State<DimmerItemDialog> {
  final _itemRepository = locator<ItemRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue;

    _itemsStore
        .stateByName(widget.itemName)
        .watchSingleOrNull().distinct()
        .listen((state) {
      if (state != null) {
        final doubleValue = double.tryParse(state.state);
        if(mounted) {
          setState(() {
            if (doubleValue != null) {
              sliderValue = doubleValue;
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ItemStateInjector(
        itemName: widget.itemName,
        builder: (itemState) {
          return Column(children: [
            Slider(
              value: sliderValue,
              onChangeEnd: onDragDone,
              onChanged: (newValue) {
                setState(() {
                  sliderValue = newValue;
                });
              },
              min: itemState.stateDescription?.minimum ?? 0,
              max: itemState.stateDescription?.maximum ?? 100,
              divisions: itemState.stateDescription?.step != null
                  ? (itemState.stateDescription?.maximum ?? 100) ~/
                      itemState.stateDescription!.step!
                  : null,
              activeColor: widget.colorScheme.primary,
              inactiveColor: widget.colorScheme.primary.withOpacity(0.24),
            ),
            const Gap(8),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      itemState.stateDescription?.maximum?.round().toString() ??
                          "100",
                      style:
                          Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "${(sliderValue).round()}",
                      style:
                          Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      itemState.stateDescription?.minimum?.round().toString() ??
                          "0",
                      style:
                          Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ))
          ]);
        });
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(widget.itemName, value);
  }
}
