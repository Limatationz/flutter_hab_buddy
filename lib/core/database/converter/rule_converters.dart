import 'dart:convert';

import 'package:drift/drift.dart';

import '../../network/generated/openHAB.swagger.dart';
import '../rules/rule_trigger.dart';

class StatusDTOConverter extends TypeConverter<RuleStatusInfo?, String?> {
  const StatusDTOConverter();

  @override
  RuleStatusInfo? fromSql(String? fromDb) {
    if (fromDb == null) {
      return null;
    } else {
      return RuleStatusInfo.fromJson(jsonDecode(fromDb));
    }
  }

  @override
  String? toSql(RuleStatusInfo? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(value.toJson());
    }
  }
}

class ActionsDTOListConverter extends TypeConverter<List<ActionDTO>?, String?> {
  const ActionsDTOListConverter();

  @override
  List<ActionDTO>? fromSql(String? fromDb) {
    if (fromDb == null) {
      return null;
    } else {
      // Decode the JSON string into a list of maps
      List<dynamic> jsonList = jsonDecode(fromDb);
      // Convert each map into an ActionDTO object
      return jsonList.map((json) => ActionDTO.fromJson(json)).toList();
    }
  }

  @override
  String? toSql(List<ActionDTO>? value) {
    if (value == null) {
      return null;
    } else {
      // Convert each ActionDTO object to JSON and encode as a JSON string
      return jsonEncode(value.map((action) => action.toJson()).toList());
    }
  }
}

class ConditionDtoListConverter extends TypeConverter<List<ConditionDTO>?, String?> {
  const ConditionDtoListConverter();

  @override
  List<ConditionDTO>? fromSql(String? fromDb) {
    if (fromDb == null) {
      return null;
    } else {
      // Decode the JSON string into a list of maps
      List<dynamic> jsonList = jsonDecode(fromDb);
      // Convert each map into a ConditionDTO object
      return jsonList.map((json) => ConditionDTO.fromJson(json)).toList();
    }
  }

  @override
  String? toSql(List<ConditionDTO>? value) {
    if (value == null) {
      return null;
    } else {
      // Convert each ConditionDTO object to JSON and encode as a JSON string
      return jsonEncode(value.map((condition) => condition.toJson()).toList());
    }
  }
}

class ConfigurationDtoListConverter extends TypeConverter<List<ConfigDescriptionParameterDTO>?, String?> {
  const ConfigurationDtoListConverter();

  @override
  List<ConfigDescriptionParameterDTO>? fromSql(String? fromDb) {
    if (fromDb == null) {
      return null;
    } else {
      // Decode the JSON string into a list of maps
      List<dynamic> jsonList = jsonDecode(fromDb);
      // Convert each map into a ConfigDescriptionParameterDTO object
      return jsonList.map((json) => ConfigDescriptionParameterDTO.fromJson(json)).toList();
    }
  }

  @override
  String? toSql(List<ConfigDescriptionParameterDTO>? value) {
    if (value == null) {
      return null;
    } else {
      // Convert each ConfigDescriptionParameterDTO object to JSON and encode as a JSON string
      return jsonEncode(value.map((config) => config.toJson()).toList());
    }
  }
}

class RuleTriggerListConverter extends TypeConverter<List<RuleTrigger>?, String?> {
  const RuleTriggerListConverter();

  @override
  List<RuleTrigger>? fromSql(String? fromDb) {
    if (fromDb == null) {
      return null;
    } else {
      // Decode the JSON string into a list of maps
      List<dynamic> jsonList = jsonDecode(fromDb);
      // Convert each map into a TriggerDTO object
      return jsonList.map((json) => RuleTrigger.fromJson(json)).toList();
    }
  }

  @override
  String? toSql(List<RuleTrigger>? value) {
    if (value == null) {
      return null;
    } else {
      // Convert each TriggerDTO object to JSON and encode as a JSON string
      return jsonEncode(value.map((trigger) => trigger.toJson()).toList());
    }
  }
}