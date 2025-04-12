import 'package:hive_ce/hive.dart';

import '../../network/generated/openHAB.models.swagger.dart';

class SensorHistoryDataBean extends HiveObject {
  DateTime time;

  String state;

  SensorHistoryDataBean(this.time, this.state);

  static SensorHistoryDataBean? fromNetworkModel(HistoryDataBean data) {
    if(data.time == null || data.state == null) {
      return null;
    }
    return SensorHistoryDataBean(
      DateTime.fromMillisecondsSinceEpoch(data.time!),
      data.state!,
    );
  }
}