// Can be generated automatically
import 'package:hive_ce/hive.dart';

import '../generated/openHAB.models.swagger.dart';

part 'persistence.g.dart';

@HiveType(typeId: 1)
class SensorHistoryDataBean {
  @HiveField(0)
  DateTime time;

  @HiveField(1)
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