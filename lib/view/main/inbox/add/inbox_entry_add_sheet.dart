import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/items/item_type.dart';
import '../../../../util/icons/icons.dart';
import '../../../util/general/bar_bottom_sheet.dart';
import '../../../util/general/base_elevated_button.dart';
import '../../../util/general/headline_value_icon.dart';
import '../../rooms/add/room_add_sheet.dart';
import 'inbox_entry_add_viewmodel.dart';

class InboxEntryAddSheet extends StatelessWidget {
  final InboxEntry entry;

  const InboxEntryAddSheet({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InboxEntryAddViewModel>.reactive(
        viewModelBuilder: () => InboxEntryAddViewModel(entry),
        builder: (context, model, _) {
          return FormBuilder(
              key: model.fbKey,
              child: Column(
                children: [
                  HeadlineValueIcon(title: "Name", data: entry.name),
                  HeadlineValueIcon(title: "Label", data: entry.label),
                  if (entry.category != null)
                    HeadlineValueIcon(title: "Category", data: entry.category!),
                  if (entry.groups?.isNotEmpty ?? false)
                    HeadlineValueIcon(
                        title: "Category", data: entry.groups!.join(", ")),
                  if (entry.tags?.isNotEmpty ?? false)
                    HeadlineValueIcon(
                        title: "Tags", data: entry.tags!.join(", ")),
                  FormBuilderDropdown(
                    name: "itemType",
                    items: ItemType.forEntryType(entry.type)
                        .map((e) =>
                        DropdownMenuItem(
                            value: e, child: Text(e.toString())))
                        .toList(),
                    validator: FormBuilderValidators.required(),
                  ),
                  StreamBuilder<List<Room>>(
                      stream: model.roomsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return FormBuilderDropdown(
                            decoration: InputDecoration(
                                labelText: "Room",
                                suffix: IconButton(
                                    onPressed: () {
                                      _onRoomAdd(context);
                                    },
                                    icon: Icon(LineIcons.plus,
                                        color: DynamicTheme
                                            .of(context)!
                                            .theme
                                            .colorScheme
                                            .onSurface))),
                            name: "roomId",
                            items: snapshot.data!
                                .map((e) =>
                                DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                            validator: FormBuilderValidators.required(),
                          );
                        }
                        return const SizedBox();
                      }),
                  const SizedBox(height: 16),
                  BaseElevatedButton(text: "Save", onPressed: () {
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

  void _onRoomAdd(BuildContext context) {
    showBarModalBottomSheet(
        context: context, builder: (context) => const RoomAddSheet());
  }
}
