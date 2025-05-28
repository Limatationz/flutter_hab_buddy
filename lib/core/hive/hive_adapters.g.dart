// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ItemStateAdapter extends TypeAdapter<ItemState> {
  @override
  final typeId = 0;

  @override
  ItemState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemState(
      ohName: fields[5] as String,
      state: fields[0] as String,
      transformedState: fields[1] as String?,
      stateDescription: fields[2] as StateDescription?,
      commandDescription: fields[3] as CommandDescription?,
      ohUnitSymbol: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemState obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.state)
      ..writeByte(1)
      ..write(obj.transformedState)
      ..writeByte(2)
      ..write(obj.stateDescription)
      ..writeByte(3)
      ..write(obj.commandDescription)
      ..writeByte(4)
      ..write(obj.ohUnitSymbol)
      ..writeByte(5)
      ..write(obj.ohName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SensorHistoryDataBeanAdapter extends TypeAdapter<SensorHistoryDataBean> {
  @override
  final typeId = 1;

  @override
  SensorHistoryDataBean read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SensorHistoryDataBean(
      fields[0] as DateTime,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SensorHistoryDataBean obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SensorHistoryDataBeanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StateDescriptionAdapter extends TypeAdapter<StateDescription> {
  @override
  final typeId = 2;

  @override
  StateDescription read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StateDescription(
      minimum: (fields[0] as num?)?.toDouble(),
      maximum: (fields[1] as num?)?.toDouble(),
      step: (fields[2] as num?)?.toDouble(),
      pattern: fields[3] as String?,
      readOnly: fields[4] as bool?,
      options: (fields[5] as List?)?.cast<StateOption>(),
    );
  }

  @override
  void write(BinaryWriter writer, StateDescription obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.minimum)
      ..writeByte(1)
      ..write(obj.maximum)
      ..writeByte(2)
      ..write(obj.step)
      ..writeByte(3)
      ..write(obj.pattern)
      ..writeByte(4)
      ..write(obj.readOnly)
      ..writeByte(5)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateDescriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CommandDescriptionAdapter extends TypeAdapter<CommandDescription> {
  @override
  final typeId = 3;

  @override
  CommandDescription read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommandDescription(
      commandOptions: (fields[0] as List?)?.cast<CommandOption>(),
    );
  }

  @override
  void write(BinaryWriter writer, CommandDescription obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.commandOptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommandDescriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StateOptionAdapter extends TypeAdapter<StateOption> {
  @override
  final typeId = 4;

  @override
  StateOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StateOption(
      $value: fields[0] as String?,
      label: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StateOption obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.$value)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CommandOptionAdapter extends TypeAdapter<CommandOption> {
  @override
  final typeId = 5;

  @override
  CommandOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommandOption(
      command: fields[0] as String?,
      label: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CommandOption obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.command)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommandOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
