import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/snackbar_service.dart';
import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/items/item_type.dart';
import '../../../../../core/database/items/oh_item_type.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../../../util/general/base_elevated_button.dart';
import '../../../util/general/delete_dialog.dart';
import '../../../util/general/headline_padding_box.dart';
import '../general/item_widget.dart';
import 'clock_data.dart';
import 'clock_item_base_widget.dart';

class ClockAddSheet extends StatefulWidget {
  final int roomId;
  final Item? item;

  const ClockAddSheet({super.key, required this.roomId, this.item});

  @override
  State<ClockAddSheet> createState() => _ClockAddSheetState();
}

class _ClockAddSheetState extends State<ClockAddSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _itemsRepository = locator<ItemRepository>();
  final _snackBarService = locator<SnackbarService>();

  final BehaviorSubject<String> _clockFormatStream =
  BehaviorSubject.seeded("HH:mm:ss");

  bool get isAdd => widget.item == null;

  bool isFavorite = false;

  List<String> get formats =>
      [
        "HH:mm:ss",
        "HH:mm",
        "dd.MM.yyyy HH:mm:ss",
        "dd.MM.yyyy HH:mm",
        "dd.MM.yyyy",
        "dd.MM.yy HH:mm:ss",
        "dd.MM.yy HH:mm",
        "dd.MM.yy",
        "dd.MM HH:mm:ss",
        "dd.MM HH:mm",
        "dd.MM",
        "EEEE, dd.MM.yyyy HH:mm:ss",
        "EEEE, dd.MM.yyyy HH:mm",
        "EEEE, dd.MM.yyyy",
        "EEEE, dd.MM.yy HH:mm:ss",
        "EEEE, dd.MM.yy HH:mm",
        "EEEE, dd.MM.yy",
        "EEEE, dd.MM HH:mm:ss",
        "EEEE, dd.MM HH:mm",
        "EEEE, dd.MM",
        "EEEE, HH:mm:ss",
        "EEEE, HH:mm",
        "EEEE",
      ];

  @override
  void initState() {
    super.initState();
    if (!isAdd) {
      isFavorite = widget.item!.isFavorite;
      _clockFormatStream.add(widget.item!.complexJson != null
          ? ClockData
          .fromJson(widget.item!.complexJson!)
          .format
          : "HH:mm:ss");
    }
  }

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    final config = widget.item?.complexJson != null
        ? ClockData.fromJson(widget.item!.complexJson!)
        : null;
    return FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(isAdd ? "Add clock" : "Edit clock",
                        style: Theme
                            .of(context)!
                            .textTheme
                            .headlineMedium)),
                if (!isAdd)
                  IconButton(
                      onPressed: () {
                        _itemsRepository
                            .updateFavoriteByName(
                            widget.item!.ohName, !widget.item!.isFavorite)
                            .then((value) =>
                            setState(() {
                              isFavorite = !isFavorite;
                            }));
                      },
                      visualDensity: VisualDensity.compact,
                      icon: Icon(isFavorite
                          ? LineIconsFilled.heart
                          : LineIcons.heart)),
                if (!isAdd) const Gap(listSpacing),
                if (!isAdd)
                  IconButton(
                      onPressed: () async {
                        final result = await showDeleteItemDialog(
                            context: context, itemLabel: "Clock");
                        if (result == true) {
                          _itemsRepository
                              .removeItem(
                            widget.item!.ohName,
                          )
                              .then((value) {
                            if (value) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                      visualDensity: VisualDensity.compact,
                      iconSize: 28,
                      icon: Icon(
                        LineIconsFilled.trash_can,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .error,
                      )),
              ],
            ),
            const HeadlinePaddingBox(),
            SizedBox(
                height: MediumWidthItemWidget.height,
                width: MediumWidthItemWidget.width,
                child: ClockItemBaseWidget(
                  item: null,
                  colorScheme: Theme
                      .of(context)
                      .colorScheme,
                  clockFormatStream: _clockFormatStream,
                )),
            const Gap(24),
            FormBuilderDropdown(
                name: "format",
                items: formats
                    .map((e) =>
                    DropdownMenuItem(
                        value: e,
                        child: Text("${DateFormat(e).format(time)} ($e)")))
                    .toList(),
                decoration:
                InputDecoration(labelText: S
                    .of(context)
                    .timeFormat),
                initialValue: config?.format ?? "HH:mm:ss",
                validator: FormBuilderValidators.required(),
                onChanged: (value) => _clockFormatStream.add(value as String)),
            const Gap(16),
            BaseElevatedButton(
                text: S.current.save,
                onPressed: () {
                  _save().then((value) {
                    if (value) {
                      Navigator.of(context).pop(widget.item);
                    }
                  });
                })
          ],
        ));
  }

  Future<bool> _save() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formKey.currentState!.value;
      if (isAdd) {
        final clockItemName = "clock_${const Uuid().v1()}";
        final format = values["format"] as String;

        final clockData = ClockData(
          itemName: clockItemName,
          format: format,
        );

        final clockItem = ItemsTableCompanion.insert(
          type: const Value(ItemType.clock),
          ohType: OhItemType.dateTime,
          ohName: clockItemName,
          ohLabel: "Clock",
          roomId: Value(widget.roomId),
          complexJson: Value(clockData.toJson()),
          score: const Value(double.infinity),
        );

        await _itemsRepository.addItem(clockItem);

        return true;
      } else {
        // update
        final newClockData = ClockData(
          itemName: widget.item!.ohName,
          format: _formKey.currentState!.value["format"] as String,
        );

        await _itemsStore.updateComplexJsonByName(
            newClockData.toJson(), widget.item!.ohName);

        return true;
      }
    } else {
      _snackBarService.showSnackbar(
        message: S.current.errorHeadline,
        type: SnackbarType.error,
      );
      return false;
    }
  }
}
