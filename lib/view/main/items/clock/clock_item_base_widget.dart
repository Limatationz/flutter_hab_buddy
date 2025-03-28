import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

import '../../../../../locator.dart';
import '../../../../../repository/item_repository.dart';
import '../../../../generated/l10n.dart';
import '../../../util/general/widget_container.dart';
import '../general/item_widget.dart';
import '../general/item_widget_factory.dart';
import 'clock_data.dart';

class ClockItemBaseWidget extends MediumWidthItemWidget {
  final Stream<String>? clockFormatStream;
  final bool disableTap;

  ClockItemBaseWidget({
    super.key,
    required super.item,
    required super.colorScheme,
    this.clockFormatStream,
    this.disableTap = false,
  });

  @override
  bool get isMock => item == null;
  final _itemRepository = locator<ItemRepository>();

  @override
  Widget build(BuildContext context) {
    final config = item?.complexJson != null
        ? ClockData.fromJson(item!.complexJson!)
        : null;
    return StreamBuilder2(
        streams: StreamTuple2(_itemRepository.clockStream,
            clockFormatStream ?? Stream.value(null)),
        builder: (context, snapshot) {
          final time = snapshot.snapshot1.data ?? DateTime.now();
          final format = config?.format ?? snapshot.snapshot2.data;

          final clockWidget = AutoHyphenatingText(
              DateFormat(format ?? "HH:mm").format(time),
              maxLines: 3,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge);

          return WidgetContainer(
              key: ValueKey(time.toIso8601String()),
              colorScheme: colorScheme,
              onLongTap: config != null ? () => onLongTap(context) : null,
              disableTap: disableTap,
              child: isMock
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.current.clock,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        const Spacer(),
                        Align(child: clockWidget),
                        const Spacer()
                      ],
                    )
                  : Center(child: clockWidget));
        });
  }

  void onLongTap(BuildContext context) => ItemWidgetFactory.openEditSheet(
        context,
        item!,
      );
}
