import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/rooms/rooms_table.dart';
import '../../../../generated/l10n.dart';
import '../../../../util/icons/LineIconsV5_icons.dart';
import '../../../../util/icons/line_icons_filled_icons.dart';
import '../../../util/constants.dart';
import '../../../util/form/base_form_dropdown.dart';
import '../../../util/form/base_form_icon_picker.dart';
import '../../../util/form/base_form_text_field.dart';
import '../../../util/general/base_elevated_button.dart';
import '../../../util/general/delete_dialog.dart';
import '../../../util/general/headline_padding_box.dart';
import '../../../util/icon_picker/icon_pack_room.dart';
import 'room_add_viewmodel.dart';

class RoomAddView extends StatelessWidget {
  static const String routePathEdit = ':id/edit';
  static const String routeNameEdit = 'RoomEditView';
  static const String routePathAdd = 'add';
  static const String routeNameAdd = 'RoomAddView';

  final int? roomId; // for edit

  const RoomAddView({
    super.key,
    this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoomAddViewModel>.reactive(
        viewModelBuilder: () => RoomAddViewModel(roomId),
        builder: (context, model, _) {
          return Scaffold(
              appBar: AppBar(
                title: Text(roomId != null
                    ? S.of(context).editRoomHeadline
                    : S.of(context).addRoomHeadline),
                actions: [
                  if (model.editedRoom != null)
                    IconButton(
                        onPressed: () async {
                          final result = await showDeleteRoomDialog(
                              context: context,
                              roomLabel: model.editedRoom!.name);
                          if (result == true) {
                            model.onDelete().then((value) {
                              Navigator.of(context).pop(-1);
                            });
                          }
                        },
                        visualDensity: VisualDensity.compact,
                        iconSize: 28,
                        icon: Icon(
                          LineIconsFilled.trash_can,
                          color: Theme.of(context).colorScheme.error,
                        )),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  child: const Icon(LineIconsV5.floppy_disk_1),
                  onPressed: () {
                    (model.isAdd ? model.save() : model.update()).then((id) {
                      if (id != null) {
                        Navigator.of(context).pop(id);
                      }
                    });
                  }),
              body: FormBuilder(
                  key: model.fbKey,
                  child: ListView(
                    padding: const EdgeInsets.all(paddingScaffold),
                    children: [
                      BaseFormTextField(
                          name: "name",
                          label: S.of(context).roomNameLabel,
                          helperText: S.of(context).roomNameHelp,
                          hintText: S.of(context).roomNameHint,
                          validator: FormBuilderValidators.required()),
                      const Gap(listSpacing),
                      BaseFormTextField(
                        name: "description",
                        label: S.of(context).roomDescriptionLabel,
                        helperText: S.of(context).roomDescriptionHelp,
                        required: false,
                      ),
                      const Gap(listSpacing),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: BaseFormTextField(
                                  name: "level",
                                  label: S.of(context).roomLevelLabel,
                                  keyboardType: TextInputType.number,
                                  required: false,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.numeric(
                                        checkNullOrEmpty: false),
                                    FormBuilderValidators.max(100,
                                        checkNullOrEmpty: false),
                                    FormBuilderValidators.min(0,
                                        checkNullOrEmpty: false)
                                  ]))),
                          const Gap(listSpacing),
                          Expanded(
                              flex: 5,
                              child: FormBuilderColorPickerField(
                                  name: "color",
                                  initialValue:
                                      Theme.of(context).colorScheme.primary,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).roomColorLabel,
                                    border: const OutlineInputBorder(),
                                    isDense: true,
                                  ))),
                        ],
                      ),
                      const Gap(listSpacing),
                      Row(children: [
                        Expanded(
                            flex: 3,
                            child: BaseFormIconPicker(
                              iconPack: iconPackRoom,
                              onChange: model.setIcon,
                              selectedIcon: model.roomIcon,
                              required: false,
                            )),
                        const Gap(listSpacing),
                        Expanded(
                            flex: 5,
                            child: BaseFormDropdown<RoomItemsSortOption>(
                              name: "itemsSortOption",
                              label: "Items Sort Option",
                              initialValue: RoomItemsSortOption.byScore,
                              items: RoomItemsSortOption.values
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e.localized)))
                                  .toList(),
                            ))
                      ]),
                    ],
                  )));
        });
  }
}
