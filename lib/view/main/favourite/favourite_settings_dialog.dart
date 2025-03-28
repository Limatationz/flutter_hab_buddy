import 'package:flutter/material.dart';

import '../../../core/database/favourites/favourites_view_settings.dart';
import '../../../util/icons/icons.dart';
import '../../util/form/base_form_dropdown.dart';
import 'favourite_viewmodel.dart';

Future<void> showFavouriteSettingsDialog(
        BuildContext context, FavouriteViewModel model) =>
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
                title: Row(children: [
                  const Expanded(child: Text("View settings")),
                  IconButton.filled(
                      onPressed: Navigator.of(context).pop,
                      icon: const Icon(LineIconsV5.xmark))
                ]),
                children: [
                  BaseFormDropdown<FavouriteViewType>(
                      name: "viewType",
                      label: "View type",
                      initialValue: model.viewSettings.viewType,
                      onChanged: (newType) {
                        if (newType != null) {
                          model.onSettingsViewTypeChanged(newType);
                        }
                      },
                      items: FavouriteViewType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name),
                        );
                      }).toList())
                ]));
