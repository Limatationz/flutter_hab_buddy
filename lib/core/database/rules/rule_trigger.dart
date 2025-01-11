import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';

import '../../../generated/l10n.dart';
import '../../../util/icons/icons.dart';
import '../../../view/main/automation/edit/automation_edit_viewmodel.dart';
import '../../../view/util/cron/cron_expression.dart';
import '../../../view/util/cron/enums/cron_expression_output_format.dart';
import '../../network/generated/openHAB.models.swagger.dart';
import '../app_database.dart';
import '../items/items_table.dart';

part 'rule_trigger.g.dart';

@JsonSerializable()
class RuleTrigger extends JsonSerializable {
  final String type;

  RuleTriggerType get ruleTriggerType => RuleTriggerType.fromString(type);
  final String id;
  final String? label;
  final String? description;
  @JsonKey(name: 'configuration')
  final Map<String, dynamic> rawConfiguration;
  @JsonKey(
      name: "flutterConfiguration",
      includeFromJson: false,
      toJson: configurationToJson)
  final RuleTriggerConfiguration configuration;

  RuleTrigger({
    required this.type,
    required this.id,
    this.label,
    this.description,
    required this.rawConfiguration,
  }) : configuration = configurationFromJson(rawConfiguration, type);

  factory RuleTrigger.fromJson(Map<String, dynamic> json) =>
      _$RuleTriggerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RuleTriggerToJson(this);

  factory RuleTrigger.fromTriggerDto(TriggerDTO triggerDto) {
    return RuleTrigger.fromJson(triggerDto.toJson());
  }

  factory RuleTrigger.easy(
      {required String type,
      required RuleTriggerConfiguration configuration,
      int id = 0}) {
    return RuleTrigger(
      id: id.toString(),
      type: type,
      rawConfiguration: configuration.toJson(),
    );
  }

  static RuleTriggerConfiguration configurationFromJson(
      Map<String, dynamic> json, String type) {
    switch (RuleTriggerType.fromString(type)) {
      case RuleTriggerType.item:
        return RuleTriggerItemConfiguration.fromJson(json, type);
      case RuleTriggerType.cron:
        return RuleTriggerCronConfiguration.fromJson(json);

      case RuleTriggerType.systemStart:
        return RuleTriggerSystemStartConfiguration.fromJson(json);
      default:
        return RuleTriggerUnknownConfiguration();
    }
  }

  static String typeToJson(RuleTriggerType type) {
    return type.toJson;
  }

  static RuleTriggerType typeFromJson(String type) {
    return RuleTriggerType.fromString(type);
  }

  static Map<String, dynamic> configurationToJson(
      RuleTriggerConfiguration configuration) {
    return configuration.toJson();
  }

  static TriggerDTO toTriggerDto(
    int index,
    RuleTriggerEntry entry,
  ) =>
      TriggerDTO(
        type: entry.configuration.openhabType,
        configuration: entry.configuration.toJson(),
        id: index.toString(),
      );
}

abstract class RuleTriggerConfiguration extends JsonSerializable {
  String get openhabType;

  @override
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class RuleTriggerItemConfiguration extends RuleTriggerConfiguration {
  final String? itemName;
  final dynamic state;
  final dynamic previousState;
  final RuleTriggerItemType type;

  @override
  String get openhabType => type.openHabValue;

  RuleTriggerItemConfiguration(
      {this.itemName, this.state, this.previousState, required this.type});

  factory RuleTriggerItemConfiguration.fromJson(
      Map<String, dynamic> configurationJson, String type) {
    return RuleTriggerItemConfiguration(
      itemName: configurationJson["itemName"],
      state: configurationJson["state"],
      previousState: configurationJson["previousState"],
      type: RuleTriggerItemType.fromString(type),
    );
  }

  @override
  Map<String, dynamic> toJson() => _$RuleTriggerItemConfigurationToJson(this);

  // copyWith
  RuleTriggerItemConfiguration copyWith({
    String? itemName,
    dynamic state,
    dynamic previousState,
    RuleTriggerItemType? type,
  }) {
    return RuleTriggerItemConfiguration(
      itemName: itemName ?? this.itemName,
      state: state ?? this.state,
      previousState: previousState ?? this.previousState,
      type: type ?? this.type,
    );
  }
}

@JsonSerializable()
class RuleTriggerSystemStartConfiguration extends RuleTriggerConfiguration {
  @JsonKey(name: "startlevel")
  final RuleTriggerSystemStartConfigurationLevel startLevel;

  @override
  String get openhabType => "core.SystemStartlevelTrigger";

  RuleTriggerSystemStartConfiguration({required this.startLevel});

  factory RuleTriggerSystemStartConfiguration.fromJson(
          Map<String, dynamic> json) =>
      _$RuleTriggerSystemStartConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$RuleTriggerSystemStartConfigurationToJson(this);
}

enum RuleTriggerItemType {
  @JsonValue("core.ItemStateChangeTrigger")
  stateChanged,
  @JsonValue("core.ItemStateUpdateTrigger")
  stateUpdated,
  @JsonValue("core.ItemCommandTrigger")
  receivedCommand;

  String get openHabValue {
    switch (this) {
      case RuleTriggerItemType.stateChanged:
        return "core.ItemStateChangeTrigger";
      case RuleTriggerItemType.stateUpdated:
        return "core.ItemStateUpdateTrigger";
      case RuleTriggerItemType.receivedCommand:
        return "core.ItemCommandTrigger";
    }
  }

  String get label {
    switch (this) {
      case RuleTriggerItemType.stateChanged:
        return "State changed";
      case RuleTriggerItemType.stateUpdated:
        return "State updated";
      case RuleTriggerItemType.receivedCommand:
        return "Command received";
    }
  }

  static RuleTriggerItemType fromString(String type) {
    switch (type) {
      case "core.ItemStateChangeTrigger":
        return RuleTriggerItemType.stateChanged;
      case "core.ItemStateUpdateTrigger":
        return RuleTriggerItemType.stateUpdated;
      case "core.ItemCommandTrigger":
        return RuleTriggerItemType.receivedCommand;
      default:
        return RuleTriggerItemType.stateChanged;
    }
  }
}

enum RuleTriggerSystemStartConfigurationLevel {
  @JsonValue(40)
  rulesLoaded,
  @JsonValue(50)
  ruleEngineStarted,
  @JsonValue(70)
  userInterfaceStarted,
  @JsonValue(80)
  thingsInitialized,
  @JsonValue(100)
  startupComplete;

  String get localizedValue {
    switch (this) {
      case RuleTriggerSystemStartConfigurationLevel.rulesLoaded:
        return S.current.systemStartTrigger40;
      case RuleTriggerSystemStartConfigurationLevel.ruleEngineStarted:
        return S.current.systemStartTrigger50;
      case RuleTriggerSystemStartConfigurationLevel.userInterfaceStarted:
        return S.current.systemStartTrigger70;
      case RuleTriggerSystemStartConfigurationLevel.thingsInitialized:
        return S.current.systemStartTrigger80;
      case RuleTriggerSystemStartConfigurationLevel.startupComplete:
        return S.current.systemStartTrigger100;
    }
  }

  static RuleTriggerSystemStartConfigurationLevel get defaultValue =>
      RuleTriggerSystemStartConfigurationLevel.rulesLoaded;
}

@JsonSerializable()
class RuleTriggerCronConfiguration extends RuleTriggerConfiguration {
  @JsonKey(fromJson: cronExpressionFromJson, toJson: cronExpressionToJson)
  final CronExpression cronExpression;

  @override
  String get openhabType => "timer.GenericCronTrigger";

  RuleTriggerCronConfiguration({required this.cronExpression});

  factory RuleTriggerCronConfiguration.fromJson(Map<String, dynamic> json) =>
      _$RuleTriggerCronConfigurationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RuleTriggerCronConfigurationToJson(this);

  static CronExpression cronExpressionFromJson(String cronExpression) {
    return CronExpression.fromString(cronExpression);
  }

  static String cronExpressionToJson(CronExpression cronExpression) {
    return cronExpression.toFormatString(CronExpressionOutputFormat.AUTO);
  }
}

@JsonSerializable()
class RuleTriggerUnknownConfiguration extends RuleTriggerConfiguration {
  @override
  String get openhabType => "unknown";
}

enum RuleTriggerType {
  item,
  cron,
  systemStart,
  unknown;

  static List<RuleTriggerType> get regularTypes => [item, cron, systemStart];

  static RuleTriggerType fromString(String type) {
    switch (type) {
      case "core.ItemStateChangeTrigger":
      case "core.ItemStateUpdateTrigger":
      case "core.ItemCommandTrigger":
        return RuleTriggerType.item;
      case "timer.GenericCronTrigger":
        return RuleTriggerType.cron;
      case "core.SystemStartlevelTrigger":
        return RuleTriggerType.systemStart;
      default:
        return RuleTriggerType.unknown;
    }
  }

  String get toJson {
    switch (this) {
      case RuleTriggerType.item:
        return "core.ItemStateChangeTrigger";
      case RuleTriggerType.cron:
        return "timer.GenericCronTrigger";
      case RuleTriggerType.systemStart:
        return "core.SystemStartlevelTrigger";
      case RuleTriggerType.unknown:
        return "unknown";
    }
  }

  String get localized {
    switch (this) {
      case RuleTriggerType.item:
        return "Item State";
      case RuleTriggerType.cron:
        return "Time Cron";
      case RuleTriggerType.systemStart:
        return "System Start";
      case RuleTriggerType.unknown:
        return "unknown";
    }
  }

  IconData get icon {
    switch (this) {
      case RuleTriggerType.cron:
        return LineIconsV5.clock_four;
      case RuleTriggerType.item:
        return LineIconsV5.command;
      case RuleTriggerType.systemStart:
        return LineIconsV5.cloud_arrow_upward;
      case RuleTriggerType.unknown:
        return LineIcons.automation;
    }
  }

  RuleTrigger? defaultTrigger(Item? item) {
    switch (this) {
      case RuleTriggerType.item:
        return RuleTrigger.easy(
            type: RuleTriggerItemType.stateChanged.openHabValue,
            configuration: RuleTriggerItemConfiguration(
                itemName: item?.ohName,
                type: RuleTriggerItemType.stateChanged));
      case RuleTriggerType.cron:
        final configuration = RuleTriggerCronConfiguration(
          cronExpression: CronExpression.now(),
        );
        return RuleTrigger.easy(
            type: configuration.openhabType, configuration: configuration);
      case RuleTriggerType.systemStart:
        final configuration = RuleTriggerSystemStartConfiguration(
          startLevel: RuleTriggerSystemStartConfigurationLevel.rulesLoaded,
        );
        return RuleTrigger.easy(
            type: configuration.openhabType, configuration: configuration);
      case RuleTriggerType.unknown:
        Logger().e("Type is unknown");
        return null;
    }
  }
}
