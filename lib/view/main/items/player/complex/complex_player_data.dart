import 'package:json_annotation/json_annotation.dart';

part 'complex_player_data.g.dart';

@JsonSerializable()
class ComplexPlayerData {
  final String playerItemName;
  final String totalDurationItemName;
  final String currentDurationItemName;
  final String? volumeDimmerItemName;
  final String? imageItemName;

  const ComplexPlayerData({
    required this.playerItemName,
    required this.totalDurationItemName,
    required this.currentDurationItemName,
    this.volumeDimmerItemName,
    this.imageItemName,
  });

  factory ComplexPlayerData.fromJson(Map<String, dynamic> json) => _$ComplexPlayerDataFromJson(json);

  Map<String, dynamic> toJson() => _$ComplexPlayerDataToJson(this);
}