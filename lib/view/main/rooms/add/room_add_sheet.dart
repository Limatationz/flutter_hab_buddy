import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/rooms/rooms_table.dart';
import '../../../../generated/l10n.dart';
import '../../../util/constants.dart';
import '../../../util/form/base_form_dropdown.dart';
import '../../../util/form/base_form_icon_picker.dart';
import '../../../util/form/base_form_text_field.dart';
import '../../../util/general/base_elevated_button.dart';
import '../../../util/general/headline_padding_box.dart';
import '../../../util/icon_picker/icon_pack_room.dart';
import 'room_add_viewmodel.dart';

class RoomAddSheet extends StatelessWidget {
  final int? roomId; // for edit

  const RoomAddSheet({
    super.key,
    this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoomAddViewModel>.reactive(
        viewModelBuilder: () => RoomAddViewModel(this.roomId),
        builder: (context, model, _) {
          return FormBuilder(
              key: model.fbKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).addRoomHeadline,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const HeadlinePaddingBox(),
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
                  const SizedBox(height: 16),
                  BaseElevatedButton(
                      text: S.of(context).save,
                      onPressed: () {
                        (model.isAdd ? model.save() : model.update())
                            .then((id) {
                          if (id != null) {
                            Navigator.of(context).pop(id);
                          }
                        });
                      })
                ],
              ));
        });
  }
}
