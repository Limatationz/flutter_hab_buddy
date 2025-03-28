import 'package:json_annotation/json_annotation.dart';
import 'package:tuple/tuple.dart';

part 'favourites_view_settings.g.dart';

@JsonSerializable()
class FavouriteViewSettings {
  final FavouriteViewType viewType;
  final List<FavouriteViewManualSortOrder> manualRoomsSortOrder;

  FavouriteViewSettings(this.viewType, this.manualRoomsSortOrder)
      : assert(
            viewType != FavouriteViewType.auto || manualRoomsSortOrder.isEmpty);

  static FavouriteViewSettings get defaultAutoSettings =>
      FavouriteViewSettings(FavouriteViewType.auto, []);

  static FavouriteViewSettings getDefaultManualSettings(
          Map<int, Tuple2<List<String>, List<String>>> currentSortOrder) =>
      FavouriteViewSettings(
          FavouriteViewType.manual,
          currentSortOrder.entries
              .map((e) => FavouriteViewManualSortOrder(
                  e.key, e.value.item1, e.value.item2))
              .toList());

  factory FavouriteViewSettings.fromJson(Map<String, dynamic> json) =>
      _$FavouriteViewSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteViewSettingsToJson(this);

  // copyWith()
  FavouriteViewSettings copyWith({
    FavouriteViewType? viewType,
    List<FavouriteViewManualSortOrder>? manualRoomsSortOrder,
  }) =>
      FavouriteViewSettings(
          viewType ?? this.viewType,
          manualRoomsSortOrder ??
              this.manualRoomsSortOrder); // ignore: prefer_collection_literals
}

enum FavouriteViewType {
  auto,
  manual;
}

@JsonSerializable()
class FavouriteViewManualSortOrder {
  final int roomId;
  final List<String> sensorNames;
  final List<String> itemNames;

  FavouriteViewManualSortOrder(this.roomId, this.sensorNames, this.itemNames);

  factory FavouriteViewManualSortOrder.fromJson(Map<String, dynamic> json) => _$FavouriteViewManualSortOrderFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteViewManualSortOrderToJson(this);
}
