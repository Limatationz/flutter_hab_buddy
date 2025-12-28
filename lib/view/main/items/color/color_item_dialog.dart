import 'package:color_models/color_models.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/hive/state/item_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../repository/item_repository.dart';
import '../../../util/constants.dart';
import '../general/item_state_injector.dart';
import 'color_util.dart';

class ColorItemDialog extends StatefulWidget {
  final String itemName;
  final HsbColor initialValue;
  final ColorScheme colorScheme;

  const ColorItemDialog(
      {super.key,
      required this.itemName,
      required this.initialValue,
      required this.colorScheme});

  @override
  State<ColorItemDialog> createState() => _ColorItemDialogState();
}

class _ColorItemDialogState extends State<ColorItemDialog> {
  final _itemRepository = locator<ItemRepository>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue.brightness.toDouble();

    _itemsStore
        .watchStateByName(widget.itemName)
        .distinct()
        .listen((state) {
      if (state != null) {
        final doubleValue = double.tryParse(state.state);
        if (mounted) {
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
          final color = AppColorUtil.parseColorState(itemState.state);
          return Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(S.of(context).color,
                  style: Theme.of(context).textTheme.titleLarge),
              Gap(largePadding),
              ColorIndicator(
                color: color.toColor(),
                height: 48,
                width: 48,
                onSelect: !itemState.isReadOnly
                    ? () async {
                        final newColor = await AppColorUtil.showColorPicker(
                          context: context,
                          initialColor: color.toColor(),
                          colorScheme: widget.colorScheme,
                        );
                        final rgbColor = RgbColor(newColor.r * 255,
                            newColor.g * 255, newColor.b * 255);
                        final hsbColor = rgbColor.toHsbColor();
                        await onColorPickerDone(hsbColor);
                      }
                    : null,
              )
            ]),
            const Gap(largePadding),
            Slider(
              value: sliderValue,
              onChangeEnd: !itemState.isReadOnly ? onDragDone : null,
              onChanged: !itemState.isReadOnly
                  ? (newValue) {
                      setState(() {
                        sliderValue = newValue;
                      });
                    }
                  : null,
              min: itemState.stateDescription?.minimum ?? 0,
              max: itemState.stateDescription?.maximum ?? 100,
              divisions: itemState.stateDescription?.step != null
                  ? (itemState.stateDescription?.maximum ?? 100) ~/
                      itemState.stateDescription!.step!
                  : null,
              activeColor: color.toColor(),
              inactiveColor: widget.colorScheme.primary.withOpacity(0.24),
            ),
            const Gap(smallPadding),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      itemState.stateDescription?.minimum?.round().toString() ??
                          "0",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "${(sliderValue).round()}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      itemState.stateDescription?.maximum?.round().toString() ??
                          "100",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                )),
          ]);
        });
  }

  Future<void> onDragDone(double value) async {
    await _itemRepository.dimmerAction(widget.itemName, value);
  }

  Future<void> onColorPickerDone(HsbColor value) async {
    await _itemRepository.colorAction(widget.itemName, value);
  }
}
