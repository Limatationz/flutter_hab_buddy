import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/network/converters/persistence.dart';
import '../core/network/generated/openHAB.swagger.dart';
import '../locator.dart';

class ChartRepository {
  final _api = locator<OpenHAB>();
  late final Box<List> _sensorDataBox;
  late final Box<DateTime> _sensorDataLastUpdateBox;

  ChartRepository() {
    Hive.registerAdapter(SensorHistoryDataBeanAdapter());
    Hive.openBox<List>('sensorBox').then((value) => _sensorDataBox = value);
    Hive.openBox<DateTime>('sensorDataLastUpdateBox')
        .then((value) => _sensorDataLastUpdateBox = value);
  }

  Future<void> fetchChartDataByName(String itemName) async {
    final lastDate = _sensorDataLastUpdateBox.get('$itemName-lastDate') ??
        DateTime.now().subtract(const Duration(days: 7));
    print('Fetching new data for $itemName since $lastDate');
    final lastDateString =
        lastDate.add(const Duration(seconds: 1)).toIso8601String();

    final result = await _api.persistenceItemsItemnameGet(
        itemname: itemName, starttime: lastDateString);
    if (result.isSuccessful) {
      final data = result.body!.data;
      if (data?.isNotEmpty ?? false) {
        print('Fetched ${data!.length} new data points for $itemName');
        final storedData = _sensorDataBox
                .get(itemName)
                ?.map((e) => e as SensorHistoryDataBean) ??
            [];
        final newData = data
            .map((e) => SensorHistoryDataBean.fromNetworkModel(e))
            .whereNotNull()
            .toList();
        await _sensorDataBox.put(itemName, [...storedData, ...newData]);

        // store date of last update
        await _sensorDataLastUpdateBox.put(
            '$itemName-lastDate', newData.last.time);
        print('Stored new last date for $itemName: ${newData.last.time}');
      }
    }
  }

  Future<void> deleteChartDataByName(String itemName) => Future.wait([
        _sensorDataBox.delete(itemName),
        _sensorDataLastUpdateBox.delete('$itemName-lastDate')
      ]);

  List<SensorHistoryDataBean> getChartDataStreamByName(String itemName) =>
      (_sensorDataBox
              .get(itemName)
              ?.map((e) => e as SensorHistoryDataBean)
              .toList() ??
          []);
}
