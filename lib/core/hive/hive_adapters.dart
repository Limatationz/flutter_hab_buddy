import 'package:hive_ce/hive.dart';

import '../network/overrides/general.dart';
import 'sensor_history_data_bean/sensor_history_data_bean.dart';
import 'state/item_state.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<ItemState>(),
  AdapterSpec<SensorHistoryDataBean>(),
  AdapterSpec<StateDescription>(),
  AdapterSpec<StateOption>(),
  AdapterSpec<CommandDescription>(),
  AdapterSpec<CommandOption>(),
])

class HiveAdapters {}