import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../util/icons/icons.dart';
import '../../util/constants.dart';
import '../../util/general/bar_bottom_sheet.dart';
import 'add/inbox_entry_add_sheet.dart';
import 'inbox_list_item.dart';
import 'inbox_viewmodel.dart';

class InboxView extends StatelessWidget {
  static const routeName = 'InboxView';
  static const routePath = '/inbox';

  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InboxViewModel>.reactive(
      viewModelBuilder: () => InboxViewModel(),
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Inbox'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(paddingScaffold),
              child: Column(
                children: [
                  Autocomplete<InboxEntry>(optionsBuilder:
                      (TextEditingValue textEditingValue) async {
                    if (textEditingValue.text == '') {
                      return const Iterable<InboxEntry>.empty();
                    }
                    return model.autoComplete(textEditingValue.text);
                  }, onSelected: (InboxEntry selection) {
                    print('You just selected ${selection.label}');
                  }, fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onSubmitted: (String value) {
                        onFieldSubmitted();
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        suffix: (textEditingController.text.isNotEmpty)
                            ? IconButton(
                                onPressed: () {
                                  textEditingController.clear();
                                },
                                icon: Icon(LineIcons.close))
                            : null,
                      ),
                    );
                  }, optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<InboxEntry> onSelected,
                      Iterable<InboxEntry> options) {
                    return Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: paddingScaffold * 2),
                          child: Material(
                            elevation: 4.0,
                            child: SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final InboxEntry option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: InboxListItem(entry: option),
                                  );
                                },
                              ),
                            ),
                          ),
                        ));
                  }, displayStringForOption: (InboxEntry option) {
                    return option.label;
                  }),
                  const Gap(12),
                  Expanded(
                    child: StreamBuilder(
                      stream: model.inbox,
                      builder:
                          (context, AsyncSnapshot<List<InboxEntry>> snapshot) {
                        if (snapshot.hasData) {
                          return Scrollbar(
                              controller: model.scrollController,
                              thumbVisibility: true,
                              trackVisibility: true,
                              child: ListView.builder(
                                controller: model.scrollController,
                                padding: const EdgeInsets.all(0),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final entry = snapshot.data![index];
                                  return InboxListItem(
                                    entry: entry,
                                    onTap: () => _onEntryTap(context, entry),
                                  );
                                },
                              ));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _onEntryTap(BuildContext context, InboxEntry entry) {
    showBarModalBottomSheet(
        context: context,
        builder: (context) => InboxEntryAddSheet(entry: entry));
  }
}
