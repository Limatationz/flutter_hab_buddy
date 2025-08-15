import 'package:json_annotation/json_annotation.dart';

enum ConfigDescriptionParameterDTOType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TEXT')
  text('TEXT'),
  @JsonValue('INTEGER')
  integer('INTEGER'),
  @JsonValue('DECIMAL')
  decimal('DECIMAL'),
  @JsonValue('BOOLEAN')
  boolean('BOOLEAN');

  final String? value;

  const ConfigDescriptionParameterDTOType(this.value);
}

enum ModuleTypeDTOVisibility {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('VISIBLE')
  visible('VISIBLE'),
  @JsonValue('HIDDEN')
  hidden('HIDDEN'),
  @JsonValue('EXPERT')
  expert('EXPERT');

  final String? value;

  const ModuleTypeDTOVisibility(this.value);
}

enum RuleDTOVisibility {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('VISIBLE')
  visible('VISIBLE'),
  @JsonValue('HIDDEN')
  hidden('HIDDEN'),
  @JsonValue('EXPERT')
  expert('EXPERT');

  final String? value;

  const RuleDTOVisibility(this.value);
}

enum EnrichedRuleDTOVisibility {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('VISIBLE')
  visible('VISIBLE'),
  @JsonValue('HIDDEN')
  hidden('HIDDEN'),
  @JsonValue('EXPERT')
  expert('EXPERT');

  final String? value;

  const EnrichedRuleDTOVisibility(this.value);
}

enum RuleStatusInfoStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('UNINITIALIZED')
  uninitialized('UNINITIALIZED'),
  @JsonValue('INITIALIZING')
  initializing('INITIALIZING'),
  @JsonValue('IDLE')
  idle('IDLE'),
  @JsonValue('RUNNING')
  running('RUNNING');

  final String? value;

  const RuleStatusInfoStatus(this.value);
}

enum RuleStatusInfoStatusDetail {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('NONE')
  none('NONE'),
  @JsonValue('HANDLER_MISSING_ERROR')
  handlerMissingError('HANDLER_MISSING_ERROR'),
  @JsonValue('HANDLER_INITIALIZING_ERROR')
  handlerInitializingError('HANDLER_INITIALIZING_ERROR'),
  @JsonValue('CONFIGURATION_ERROR')
  configurationError('CONFIGURATION_ERROR'),
  @JsonValue('TEMPLATE_MISSING_ERROR')
  templateMissingError('TEMPLATE_MISSING_ERROR'),
  @JsonValue('INVALID_RULE')
  invalidRule('INVALID_RULE'),
  @JsonValue('DISABLED')
  disabled('DISABLED');

  final String? value;

  const RuleStatusInfoStatusDetail(this.value);
}

enum ConfigDescriptionParameterType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TEXT')
  text('TEXT'),
  @JsonValue('INTEGER')
  integer('INTEGER'),
  @JsonValue('DECIMAL')
  decimal('DECIMAL'),
  @JsonValue('BOOLEAN')
  boolean('BOOLEAN');

  final String? value;

  const ConfigDescriptionParameterType(this.value);
}

enum RuleVisibility {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('VISIBLE')
  visible('VISIBLE'),
  @JsonValue('HIDDEN')
  hidden('HIDDEN'),
  @JsonValue('EXPERT')
  expert('EXPERT');

  final String? value;

  const RuleVisibility(this.value);
}

enum TemplateVisibility {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('VISIBLE')
  visible('VISIBLE'),
  @JsonValue('HIDDEN')
  hidden('HIDDEN'),
  @JsonValue('EXPERT')
  expert('EXPERT');

  final String? value;

  const TemplateVisibility(this.value);
}

enum DiscoveryResultDTOFlag {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('NEW')
  $new('NEW'),
  @JsonValue('IGNORED')
  ignored('IGNORED');

  final String? value;

  const DiscoveryResultDTOFlag(this.value);
}

enum ThingStatusInfoStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('UNINITIALIZED')
  uninitialized('UNINITIALIZED'),
  @JsonValue('INITIALIZING')
  initializing('INITIALIZING'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN'),
  @JsonValue('ONLINE')
  online('ONLINE'),
  @JsonValue('OFFLINE')
  offline('OFFLINE'),
  @JsonValue('REMOVING')
  removing('REMOVING'),
  @JsonValue('REMOVED')
  removed('REMOVED');

  final String? value;

  const ThingStatusInfoStatus(this.value);
}

enum ThingStatusInfoStatusDetail {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('NONE')
  none('NONE'),
  @JsonValue('NOT_YET_READY')
  notYetReady('NOT_YET_READY'),
  @JsonValue('HANDLER_MISSING_ERROR')
  handlerMissingError('HANDLER_MISSING_ERROR'),
  @JsonValue('HANDLER_REGISTERING_ERROR')
  handlerRegisteringError('HANDLER_REGISTERING_ERROR'),
  @JsonValue('HANDLER_INITIALIZING_ERROR')
  handlerInitializingError('HANDLER_INITIALIZING_ERROR'),
  @JsonValue('HANDLER_CONFIGURATION_PENDING')
  handlerConfigurationPending('HANDLER_CONFIGURATION_PENDING'),
  @JsonValue('CONFIGURATION_PENDING')
  configurationPending('CONFIGURATION_PENDING'),
  @JsonValue('COMMUNICATION_ERROR')
  communicationError('COMMUNICATION_ERROR'),
  @JsonValue('CONFIGURATION_ERROR')
  configurationError('CONFIGURATION_ERROR'),
  @JsonValue('BRIDGE_OFFLINE')
  bridgeOffline('BRIDGE_OFFLINE'),
  @JsonValue('FIRMWARE_UPDATING')
  firmwareUpdating('FIRMWARE_UPDATING'),
  @JsonValue('DUTY_CYCLE')
  dutyCycle('DUTY_CYCLE'),
  @JsonValue('BRIDGE_UNINITIALIZED')
  bridgeUninitialized('BRIDGE_UNINITIALIZED'),
  @JsonValue('GONE')
  gone('GONE'),
  @JsonValue('DISABLED')
  disabled('DISABLED');

  final String? value;

  const ThingStatusInfoStatusDetail(this.value);
}

enum ConfigStatusMessageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INFORMATION')
  information('INFORMATION'),
  @JsonValue('WARNING')
  warning('WARNING'),
  @JsonValue('ERROR')
  error('ERROR'),
  @JsonValue('PENDING')
  pending('PENDING');

  final String? value;

  const ConfigStatusMessageType(this.value);
}

enum IconSetFormats {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PNG')
  png('PNG'),
  @JsonValue('SVG')
  svg('SVG');

  final String? value;

  const IconSetFormats(this.value);
}
