import 'package:badges/badges.dart' as badges;
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';

import '../../../util/icons/icons.dart';
import '../inbox/inbox_action_button.dart';
import '../inbox/inbox_view.dart';
import 'favourite_viewmodel.dart';

class FavouriteView extends StatelessWidget {
  static const String routePath = '/favourite';
  static const String routeName = 'FavouriteView';

  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouriteViewModel>.reactive(
        viewModelBuilder: () => FavouriteViewModel(),
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                title: const Text('Favourite'),
                actions: [
                  InboxActionButton(countInbox: model.countInbox),
                ],
              ),
              body: const Center(
                child: Text('Favourite'),
              ),
            ));
  }
}
