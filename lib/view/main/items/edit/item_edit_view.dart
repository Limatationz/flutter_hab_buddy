import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../core/database/items/items_table.dart';
import '../../../../generated/l10n.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/constants.dart';
import '../../../util/form/base_form_dropdown.dart';
import '../../../util/form/base_form_icon_picker.dart';
import '../../../util/form/base_form_text_field.dart';
import '../../../util/general/bar_bottom_sheet.dart';
import '../../../util/general/base_elevated_button.dart';
import '../../../util/general/headline_padding_box.dart';
import '../../../util/general/headline_value_icon.dart';
import '../../../util/icon_picker/icon_pack_items.dart';
import '../../rooms/add/room_add_sheet.dart';
import 'item_edit_viewmodel.dart';

class ItemEditView extends StatelessWidget {
  final Item item;

  const ItemEditView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemEditViewModel>.reactive(
        viewModelBuilder: () => ItemEditViewModel(item),
        builder: (context, model, _) {
          return FormBuilder(
              key: model.fbKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Edit Item",
                      style: DynamicTheme.of(context)!
                          .theme
                          .textTheme
                          .headlineMedium),
                  const HeadlinePaddingBox(),
                  HeadlineValueIcon(title: "Name", data: item.ohName),
                  HeadlineValueIcon(title: "Label", data: item.ohLabel),
                  if (item.ohCategory != null)
                    HeadlineValueIcon(
                        title: "Category", data: item.ohCategory!),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.ohTags != null)
                        Expanded(
                            child: HeadlineValueIcon(
                                title: "Tags", data: item.ohTags!.join(", "))),
                      if (item.ohGroups != null && item.ohTags != null)
                        const Gap(listSpacing),
                      if (item.ohGroups != null)
                        Expanded(
                            child: HeadlineValueIcon(
                                title: "Groups",
                                data: item.ohGroups!.join(", "))),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BaseFormDropdown<ItemType>(
                          name: "itemType",
                          initialValue: item.type,
                          items: ItemType.forEntryType(item.ohType)
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.toString())))
                              .toList(),
                          validator: FormBuilderValidators.required(),
                          label: S.of(context).itemType,
                          helperText: S.of(context).itemTypeHelp,
                          hintText: S.current.select,
                        ),
                      ),
                      const Gap(listSpacing),
                      Expanded(
                        child: BaseFormIconPicker(
                          iconPack: iconPackItems,
                          onChange: model.setIcon,
                          selectedIcon: model.itemIcon,
                          helperText: S.of(context).optional,
                        ),
                      ),
                    ],
                  ),
                  const Gap(listSpacing),
                  StreamBuilder<List<Room>>(
                      stream: model.roomsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return BaseFormDropdown<int>(
                              name: "roomId",
                              label: S.of(context).room,
                              helperText: S.of(context).roomHelp,
                              hintText: S.current.select,
                              initialValue: model.addRoomId ?? item.roomId,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    _onRoomAdd(context, model);
                                  },
                                  child: Icon(LineIcons.plus,
                                      color: DynamicTheme.of(context)!
                                          .theme
                                          .colorScheme
                                          .primary)),
                              items: snapshot.data!
                                  .map((e) => DropdownMenuItem(
                                      value: e.id, child: Text(e.name)))
                                  .toList(),
                              validator: FormBuilderValidators.required());
                        }
                        return const SizedBox();
                      }),
                  const Gap(listSpacing),
                  BaseFormTextField(
                    name: "customLabel",
                    label: S.of(context).customLabel,
                    helperText: S.of(context).customLabelHelp,
                    hintText: item.ohLabel,
                    initialValue: item.label,
                  ),
                  const SizedBox(height: 16),
                  BaseElevatedButton(
                      text: S.current.save,
                      onPressed: () {
                        model.save().then((value) {
                          if (value) {
                            Navigator.of(context).pop();
                          }
                        });
                      })
                ],
              ));
        });
  }

  Future<void> _onRoomAdd(BuildContext context, ItemEditViewModel model) async {
    final roomId = await showBarModalBottomSheet<int?>(
        context: context, builder: (context) => const RoomAddSheet());
    model.onRoomAdd(roomId);
  }
}
