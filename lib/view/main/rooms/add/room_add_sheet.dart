import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:stacked/stacked.dart';

import '../../../util/form/base_form_icon_picker.dart';
import '../../../util/general/base_elevated_button.dart';
import '../../../util/icon_picker/icon_pack_room.dart';
import 'room_add_viewmodel.dart';

class RoomAddSheet extends StatelessWidget {
  const RoomAddSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoomAddViewModel>.reactive(
        viewModelBuilder: () => RoomAddViewModel(),
        builder: (context, model, _) {
          return FormBuilder(
              key: model.fbKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                      name: "name",
                      decoration: InputDecoration(labelText: "Name"),
                      validator: FormBuilderValidators.required()),
                  FormBuilderTextField(
                      name: "description",
                      decoration: InputDecoration(labelText: "Description")),
                  FormBuilderTextField(
                      name: "level",
                      decoration: InputDecoration(labelText: "Level"),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(100),
                        FormBuilderValidators.min(0)
                      ])),
                  FormBuilderColorPickerField(
                      name: "color",
                      decoration: InputDecoration(labelText: "Color")),
                  BaseFormIconPicker(
                      iconPack: iconPackRoom,
                      onChange: model.setIcon,
                      selectedIcon: model.roomIcon),
                  const SizedBox(height: 16),
                  BaseElevatedButton(
                      text: "Save",
                      onPressed: () {
                        model.save().then((value) {
                          if (value) {
                            Navigator.pop(context);
                          }
                        });
                      })
                ],
              ));
        });
  }
}
