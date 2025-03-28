// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RoomsTableTable extends RoomsTable
    with TableInfo<$RoomsTableTable, Room> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<IconData?, String> icon =
      GeneratedColumn<String>('icon', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<IconData?>($RoomsTableTable.$convertericonn);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sortKeyMeta =
      const VerificationMeta('sortKey');
  @override
  late final GeneratedColumn<int> sortKey = GeneratedColumn<int>(
      'sort_key', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<RoomItemsSortOption, String>
      itemsSortOption = GeneratedColumn<String>(
              'items_sort_option', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<RoomItemsSortOption>(
              $RoomsTableTable.$converteritemsSortOption);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, icon, color, level, sortKey, itemsSortOption];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rooms_table';
  @override
  VerificationContext validateIntegrity(Insertable<Room> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('sort_key')) {
      context.handle(_sortKeyMeta,
          sortKey.isAcceptableOrUnknown(data['sort_key']!, _sortKeyMeta));
    } else if (isInserting) {
      context.missing(_sortKeyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Room map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Room(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      icon: $RoomsTableTable.$convertericonn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level']),
      sortKey: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_key'])!,
      itemsSortOption: $RoomsTableTable.$converteritemsSortOption.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}items_sort_option'])!),
    );
  }

  @override
  $RoomsTableTable createAlias(String alias) {
    return $RoomsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<IconData, String> $convertericon =
      const IconDataConverter();
  static TypeConverter<IconData?, String?> $convertericonn =
      NullAwareTypeConverter.wrap($convertericon);
  static JsonTypeConverter2<RoomItemsSortOption, String, String>
      $converteritemsSortOption =
      const EnumNameConverter<RoomItemsSortOption>(RoomItemsSortOption.values);
}

class Room extends DataClass implements Insertable<Room> {
  final int id;
  final String name;
  final String? description;
  final IconData? icon;
  final String? color;
  final int? level;
  final int sortKey;
  final RoomItemsSortOption itemsSortOption;
  const Room(
      {required this.id,
      required this.name,
      this.description,
      this.icon,
      this.color,
      this.level,
      required this.sortKey,
      required this.itemsSortOption});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] =
          Variable<String>($RoomsTableTable.$convertericonn.toSql(icon));
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || level != null) {
      map['level'] = Variable<int>(level);
    }
    map['sort_key'] = Variable<int>(sortKey);
    {
      map['items_sort_option'] = Variable<String>(
          $RoomsTableTable.$converteritemsSortOption.toSql(itemsSortOption));
    }
    return map;
  }

  RoomsTableCompanion toCompanion(bool nullToAbsent) {
    return RoomsTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
      sortKey: Value(sortKey),
      itemsSortOption: Value(itemsSortOption),
    );
  }

  factory Room.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Room(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      icon: serializer.fromJson<IconData?>(json['icon']),
      color: serializer.fromJson<String?>(json['color']),
      level: serializer.fromJson<int?>(json['level']),
      sortKey: serializer.fromJson<int>(json['sortKey']),
      itemsSortOption: $RoomsTableTable.$converteritemsSortOption
          .fromJson(serializer.fromJson<String>(json['itemsSortOption'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'icon': serializer.toJson<IconData?>(icon),
      'color': serializer.toJson<String?>(color),
      'level': serializer.toJson<int?>(level),
      'sortKey': serializer.toJson<int>(sortKey),
      'itemsSortOption': serializer.toJson<String>(
          $RoomsTableTable.$converteritemsSortOption.toJson(itemsSortOption)),
    };
  }

  Room copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<IconData?> icon = const Value.absent(),
          Value<String?> color = const Value.absent(),
          Value<int?> level = const Value.absent(),
          int? sortKey,
          RoomItemsSortOption? itemsSortOption}) =>
      Room(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        icon: icon.present ? icon.value : this.icon,
        color: color.present ? color.value : this.color,
        level: level.present ? level.value : this.level,
        sortKey: sortKey ?? this.sortKey,
        itemsSortOption: itemsSortOption ?? this.itemsSortOption,
      );
  Room copyWithCompanion(RoomsTableCompanion data) {
    return Room(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      level: data.level.present ? data.level.value : this.level,
      sortKey: data.sortKey.present ? data.sortKey.value : this.sortKey,
      itemsSortOption: data.itemsSortOption.present
          ? data.itemsSortOption.value
          : this.itemsSortOption,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Room(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('level: $level, ')
          ..write('sortKey: $sortKey, ')
          ..write('itemsSortOption: $itemsSortOption')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, description, icon, color, level, sortKey, itemsSortOption);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Room &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.level == this.level &&
          other.sortKey == this.sortKey &&
          other.itemsSortOption == this.itemsSortOption);
}

class RoomsTableCompanion extends UpdateCompanion<Room> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<IconData?> icon;
  final Value<String?> color;
  final Value<int?> level;
  final Value<int> sortKey;
  final Value<RoomItemsSortOption> itemsSortOption;
  const RoomsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.level = const Value.absent(),
    this.sortKey = const Value.absent(),
    this.itemsSortOption = const Value.absent(),
  });
  RoomsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.level = const Value.absent(),
    required int sortKey,
    required RoomItemsSortOption itemsSortOption,
  })  : name = Value(name),
        sortKey = Value(sortKey),
        itemsSortOption = Value(itemsSortOption);
  static Insertable<Room> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<int>? level,
    Expression<int>? sortKey,
    Expression<String>? itemsSortOption,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (level != null) 'level': level,
      if (sortKey != null) 'sort_key': sortKey,
      if (itemsSortOption != null) 'items_sort_option': itemsSortOption,
    });
  }

  RoomsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<IconData?>? icon,
      Value<String?>? color,
      Value<int?>? level,
      Value<int>? sortKey,
      Value<RoomItemsSortOption>? itemsSortOption}) {
    return RoomsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      level: level ?? this.level,
      sortKey: sortKey ?? this.sortKey,
      itemsSortOption: itemsSortOption ?? this.itemsSortOption,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] =
          Variable<String>($RoomsTableTable.$convertericonn.toSql(icon.value));
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (sortKey.present) {
      map['sort_key'] = Variable<int>(sortKey.value);
    }
    if (itemsSortOption.present) {
      map['items_sort_option'] = Variable<String>($RoomsTableTable
          .$converteritemsSortOption
          .toSql(itemsSortOption.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('level: $level, ')
          ..write('sortKey: $sortKey, ')
          ..write('itemsSortOption: $itemsSortOption')
          ..write(')'))
        .toString();
  }
}

class $ItemsTableTable extends ItemsTable
    with TableInfo<$ItemsTableTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTableTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<ItemType?, String> type =
      GeneratedColumn<String>('type', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ItemType?>($ItemsTableTable.$convertertypen);
  @override
  late final GeneratedColumnWithTypeConverter<OhItemType, String> ohType =
      GeneratedColumn<String>('oh_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<OhItemType>($ItemsTableTable.$converterohType);
  static const VerificationMeta _ohNameMeta = const VerificationMeta('ohName');
  @override
  late final GeneratedColumn<String> ohName = GeneratedColumn<String>(
      'oh_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ohLabelMeta =
      const VerificationMeta('ohLabel');
  @override
  late final GeneratedColumn<String> ohLabel = GeneratedColumn<String>(
      'oh_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customLabelMeta =
      const VerificationMeta('customLabel');
  @override
  late final GeneratedColumn<String> customLabel = GeneratedColumn<String>(
      'custom_label', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ohCategoryMeta =
      const VerificationMeta('ohCategory');
  @override
  late final GeneratedColumn<String> ohCategory = GeneratedColumn<String>(
      'oh_category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> ohTags =
      GeneratedColumn<String>('oh_tags', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($ItemsTableTable.$converterohTagsn);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> ohGroups =
      GeneratedColumn<String>('oh_groups', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($ItemsTableTable.$converterohGroupsn);
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<int> roomId = GeneratedColumn<int>(
      'room_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES rooms_table (id)'));
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<IconData?, String> icon =
      GeneratedColumn<String>('icon', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<IconData?>($ItemsTableTable.$convertericonn);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
      'score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _newScoreMeta =
      const VerificationMeta('newScore');
  @override
  late final GeneratedColumn<double> newScore = GeneratedColumn<double>(
      'new_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _manualOrderIndexMeta =
      const VerificationMeta('manualOrderIndex');
  @override
  late final GeneratedColumn<int> manualOrderIndex = GeneratedColumn<int>(
      'manual_order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      complexJson = GeneratedColumn<String>('complex_json', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $ItemsTableTable.$convertercomplexJson);
  @override
  List<GeneratedColumn> get $columns => [
        type,
        ohType,
        ohName,
        ohLabel,
        customLabel,
        ohCategory,
        ohTags,
        ohGroups,
        roomId,
        isFavorite,
        icon,
        score,
        newScore,
        manualOrderIndex,
        complexJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items_table';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('oh_name')) {
      context.handle(_ohNameMeta,
          ohName.isAcceptableOrUnknown(data['oh_name']!, _ohNameMeta));
    } else if (isInserting) {
      context.missing(_ohNameMeta);
    }
    if (data.containsKey('oh_label')) {
      context.handle(_ohLabelMeta,
          ohLabel.isAcceptableOrUnknown(data['oh_label']!, _ohLabelMeta));
    } else if (isInserting) {
      context.missing(_ohLabelMeta);
    }
    if (data.containsKey('custom_label')) {
      context.handle(
          _customLabelMeta,
          customLabel.isAcceptableOrUnknown(
              data['custom_label']!, _customLabelMeta));
    }
    if (data.containsKey('oh_category')) {
      context.handle(
          _ohCategoryMeta,
          ohCategory.isAcceptableOrUnknown(
              data['oh_category']!, _ohCategoryMeta));
    }
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('new_score')) {
      context.handle(_newScoreMeta,
          newScore.isAcceptableOrUnknown(data['new_score']!, _newScoreMeta));
    }
    if (data.containsKey('manual_order_index')) {
      context.handle(
          _manualOrderIndexMeta,
          manualOrderIndex.isAcceptableOrUnknown(
              data['manual_order_index']!, _manualOrderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ohName};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      type: $ItemsTableTable.$convertertypen.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])),
      ohType: $ItemsTableTable.$converterohType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oh_type'])!),
      ohName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oh_name'])!,
      ohLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oh_label'])!,
      customLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}custom_label']),
      ohCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oh_category']),
      ohTags: $ItemsTableTable.$converterohTagsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oh_tags'])),
      ohGroups: $ItemsTableTable.$converterohGroupsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oh_groups'])),
      roomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}room_id']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      icon: $ItemsTableTable.$convertericonn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])),
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}score'])!,
      newScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}new_score'])!,
      manualOrderIndex: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}manual_order_index'])!,
      complexJson: $ItemsTableTable.$convertercomplexJson.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}complex_json'])),
    );
  }

  @override
  $ItemsTableTable createAlias(String alias) {
    return $ItemsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ItemType, String, String> $convertertype =
      const EnumNameConverter<ItemType>(ItemType.values);
  static JsonTypeConverter2<ItemType?, String?, String?> $convertertypen =
      JsonTypeConverter2.asNullable($convertertype);
  static JsonTypeConverter2<OhItemType, String, String> $converterohType =
      const EnumNameConverter<OhItemType>(OhItemType.values);
  static TypeConverter<List<String>, String> $converterohTags =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converterohTagsn =
      NullAwareTypeConverter.wrap($converterohTags);
  static TypeConverter<List<String>, String> $converterohGroups =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converterohGroupsn =
      NullAwareTypeConverter.wrap($converterohGroups);
  static TypeConverter<IconData, String> $convertericon =
      const IconDataConverter();
  static TypeConverter<IconData?, String?> $convertericonn =
      NullAwareTypeConverter.wrap($convertericon);
  static TypeConverter<Map<String, dynamic>?, String?> $convertercomplexJson =
      const JsonConverter();
}

class Item extends DataClass implements Insertable<Item> {
  final ItemType? type;
  final OhItemType ohType;
  final String ohName;
  final String ohLabel;
  final String? customLabel;
  final String? ohCategory;
  final List<String>? ohTags;
  final List<String>? ohGroups;
  final int? roomId;
  final bool isFavorite;
  final IconData? icon;
  final double score;
  final double newScore;
  final int manualOrderIndex;
  final Map<String, dynamic>? complexJson;
  const Item(
      {this.type,
      required this.ohType,
      required this.ohName,
      required this.ohLabel,
      this.customLabel,
      this.ohCategory,
      this.ohTags,
      this.ohGroups,
      this.roomId,
      required this.isFavorite,
      this.icon,
      required this.score,
      required this.newScore,
      required this.manualOrderIndex,
      this.complexJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || type != null) {
      map['type'] =
          Variable<String>($ItemsTableTable.$convertertypen.toSql(type));
    }
    {
      map['oh_type'] =
          Variable<String>($ItemsTableTable.$converterohType.toSql(ohType));
    }
    map['oh_name'] = Variable<String>(ohName);
    map['oh_label'] = Variable<String>(ohLabel);
    if (!nullToAbsent || customLabel != null) {
      map['custom_label'] = Variable<String>(customLabel);
    }
    if (!nullToAbsent || ohCategory != null) {
      map['oh_category'] = Variable<String>(ohCategory);
    }
    if (!nullToAbsent || ohTags != null) {
      map['oh_tags'] =
          Variable<String>($ItemsTableTable.$converterohTagsn.toSql(ohTags));
    }
    if (!nullToAbsent || ohGroups != null) {
      map['oh_groups'] = Variable<String>(
          $ItemsTableTable.$converterohGroupsn.toSql(ohGroups));
    }
    if (!nullToAbsent || roomId != null) {
      map['room_id'] = Variable<int>(roomId);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || icon != null) {
      map['icon'] =
          Variable<String>($ItemsTableTable.$convertericonn.toSql(icon));
    }
    map['score'] = Variable<double>(score);
    map['new_score'] = Variable<double>(newScore);
    map['manual_order_index'] = Variable<int>(manualOrderIndex);
    if (!nullToAbsent || complexJson != null) {
      map['complex_json'] = Variable<String>(
          $ItemsTableTable.$convertercomplexJson.toSql(complexJson));
    }
    return map;
  }

  ItemsTableCompanion toCompanion(bool nullToAbsent) {
    return ItemsTableCompanion(
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      ohType: Value(ohType),
      ohName: Value(ohName),
      ohLabel: Value(ohLabel),
      customLabel: customLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(customLabel),
      ohCategory: ohCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(ohCategory),
      ohTags:
          ohTags == null && nullToAbsent ? const Value.absent() : Value(ohTags),
      ohGroups: ohGroups == null && nullToAbsent
          ? const Value.absent()
          : Value(ohGroups),
      roomId:
          roomId == null && nullToAbsent ? const Value.absent() : Value(roomId),
      isFavorite: Value(isFavorite),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      score: Value(score),
      newScore: Value(newScore),
      manualOrderIndex: Value(manualOrderIndex),
      complexJson: complexJson == null && nullToAbsent
          ? const Value.absent()
          : Value(complexJson),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      type: $ItemsTableTable.$convertertypen
          .fromJson(serializer.fromJson<String?>(json['type'])),
      ohType: $ItemsTableTable.$converterohType
          .fromJson(serializer.fromJson<String>(json['ohType'])),
      ohName: serializer.fromJson<String>(json['ohName']),
      ohLabel: serializer.fromJson<String>(json['ohLabel']),
      customLabel: serializer.fromJson<String?>(json['customLabel']),
      ohCategory: serializer.fromJson<String?>(json['ohCategory']),
      ohTags: serializer.fromJson<List<String>?>(json['ohTags']),
      ohGroups: serializer.fromJson<List<String>?>(json['ohGroups']),
      roomId: serializer.fromJson<int?>(json['roomId']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      icon: serializer.fromJson<IconData?>(json['icon']),
      score: serializer.fromJson<double>(json['score']),
      newScore: serializer.fromJson<double>(json['newScore']),
      manualOrderIndex: serializer.fromJson<int>(json['manualOrderIndex']),
      complexJson:
          serializer.fromJson<Map<String, dynamic>?>(json['complexJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer
          .toJson<String?>($ItemsTableTable.$convertertypen.toJson(type)),
      'ohType': serializer
          .toJson<String>($ItemsTableTable.$converterohType.toJson(ohType)),
      'ohName': serializer.toJson<String>(ohName),
      'ohLabel': serializer.toJson<String>(ohLabel),
      'customLabel': serializer.toJson<String?>(customLabel),
      'ohCategory': serializer.toJson<String?>(ohCategory),
      'ohTags': serializer.toJson<List<String>?>(ohTags),
      'ohGroups': serializer.toJson<List<String>?>(ohGroups),
      'roomId': serializer.toJson<int?>(roomId),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'icon': serializer.toJson<IconData?>(icon),
      'score': serializer.toJson<double>(score),
      'newScore': serializer.toJson<double>(newScore),
      'manualOrderIndex': serializer.toJson<int>(manualOrderIndex),
      'complexJson': serializer.toJson<Map<String, dynamic>?>(complexJson),
    };
  }

  Item copyWith(
          {Value<ItemType?> type = const Value.absent(),
          OhItemType? ohType,
          String? ohName,
          String? ohLabel,
          Value<String?> customLabel = const Value.absent(),
          Value<String?> ohCategory = const Value.absent(),
          Value<List<String>?> ohTags = const Value.absent(),
          Value<List<String>?> ohGroups = const Value.absent(),
          Value<int?> roomId = const Value.absent(),
          bool? isFavorite,
          Value<IconData?> icon = const Value.absent(),
          double? score,
          double? newScore,
          int? manualOrderIndex,
          Value<Map<String, dynamic>?> complexJson = const Value.absent()}) =>
      Item(
        type: type.present ? type.value : this.type,
        ohType: ohType ?? this.ohType,
        ohName: ohName ?? this.ohName,
        ohLabel: ohLabel ?? this.ohLabel,
        customLabel: customLabel.present ? customLabel.value : this.customLabel,
        ohCategory: ohCategory.present ? ohCategory.value : this.ohCategory,
        ohTags: ohTags.present ? ohTags.value : this.ohTags,
        ohGroups: ohGroups.present ? ohGroups.value : this.ohGroups,
        roomId: roomId.present ? roomId.value : this.roomId,
        isFavorite: isFavorite ?? this.isFavorite,
        icon: icon.present ? icon.value : this.icon,
        score: score ?? this.score,
        newScore: newScore ?? this.newScore,
        manualOrderIndex: manualOrderIndex ?? this.manualOrderIndex,
        complexJson: complexJson.present ? complexJson.value : this.complexJson,
      );
  Item copyWithCompanion(ItemsTableCompanion data) {
    return Item(
      type: data.type.present ? data.type.value : this.type,
      ohType: data.ohType.present ? data.ohType.value : this.ohType,
      ohName: data.ohName.present ? data.ohName.value : this.ohName,
      ohLabel: data.ohLabel.present ? data.ohLabel.value : this.ohLabel,
      customLabel:
          data.customLabel.present ? data.customLabel.value : this.customLabel,
      ohCategory:
          data.ohCategory.present ? data.ohCategory.value : this.ohCategory,
      ohTags: data.ohTags.present ? data.ohTags.value : this.ohTags,
      ohGroups: data.ohGroups.present ? data.ohGroups.value : this.ohGroups,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      icon: data.icon.present ? data.icon.value : this.icon,
      score: data.score.present ? data.score.value : this.score,
      newScore: data.newScore.present ? data.newScore.value : this.newScore,
      manualOrderIndex: data.manualOrderIndex.present
          ? data.manualOrderIndex.value
          : this.manualOrderIndex,
      complexJson:
          data.complexJson.present ? data.complexJson.value : this.complexJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('type: $type, ')
          ..write('ohType: $ohType, ')
          ..write('ohName: $ohName, ')
          ..write('ohLabel: $ohLabel, ')
          ..write('customLabel: $customLabel, ')
          ..write('ohCategory: $ohCategory, ')
          ..write('ohTags: $ohTags, ')
          ..write('ohGroups: $ohGroups, ')
          ..write('roomId: $roomId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('icon: $icon, ')
          ..write('score: $score, ')
          ..write('newScore: $newScore, ')
          ..write('manualOrderIndex: $manualOrderIndex, ')
          ..write('complexJson: $complexJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      type,
      ohType,
      ohName,
      ohLabel,
      customLabel,
      ohCategory,
      ohTags,
      ohGroups,
      roomId,
      isFavorite,
      icon,
      score,
      newScore,
      manualOrderIndex,
      complexJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.type == this.type &&
          other.ohType == this.ohType &&
          other.ohName == this.ohName &&
          other.ohLabel == this.ohLabel &&
          other.customLabel == this.customLabel &&
          other.ohCategory == this.ohCategory &&
          other.ohTags == this.ohTags &&
          other.ohGroups == this.ohGroups &&
          other.roomId == this.roomId &&
          other.isFavorite == this.isFavorite &&
          other.icon == this.icon &&
          other.score == this.score &&
          other.newScore == this.newScore &&
          other.manualOrderIndex == this.manualOrderIndex &&
          other.complexJson == this.complexJson);
}

class ItemsTableCompanion extends UpdateCompanion<Item> {
  final Value<ItemType?> type;
  final Value<OhItemType> ohType;
  final Value<String> ohName;
  final Value<String> ohLabel;
  final Value<String?> customLabel;
  final Value<String?> ohCategory;
  final Value<List<String>?> ohTags;
  final Value<List<String>?> ohGroups;
  final Value<int?> roomId;
  final Value<bool> isFavorite;
  final Value<IconData?> icon;
  final Value<double> score;
  final Value<double> newScore;
  final Value<int> manualOrderIndex;
  final Value<Map<String, dynamic>?> complexJson;
  final Value<int> rowid;
  const ItemsTableCompanion({
    this.type = const Value.absent(),
    this.ohType = const Value.absent(),
    this.ohName = const Value.absent(),
    this.ohLabel = const Value.absent(),
    this.customLabel = const Value.absent(),
    this.ohCategory = const Value.absent(),
    this.ohTags = const Value.absent(),
    this.ohGroups = const Value.absent(),
    this.roomId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.icon = const Value.absent(),
    this.score = const Value.absent(),
    this.newScore = const Value.absent(),
    this.manualOrderIndex = const Value.absent(),
    this.complexJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsTableCompanion.insert({
    this.type = const Value.absent(),
    required OhItemType ohType,
    required String ohName,
    required String ohLabel,
    this.customLabel = const Value.absent(),
    this.ohCategory = const Value.absent(),
    this.ohTags = const Value.absent(),
    this.ohGroups = const Value.absent(),
    this.roomId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.icon = const Value.absent(),
    this.score = const Value.absent(),
    this.newScore = const Value.absent(),
    this.manualOrderIndex = const Value.absent(),
    this.complexJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : ohType = Value(ohType),
        ohName = Value(ohName),
        ohLabel = Value(ohLabel);
  static Insertable<Item> custom({
    Expression<String>? type,
    Expression<String>? ohType,
    Expression<String>? ohName,
    Expression<String>? ohLabel,
    Expression<String>? customLabel,
    Expression<String>? ohCategory,
    Expression<String>? ohTags,
    Expression<String>? ohGroups,
    Expression<int>? roomId,
    Expression<bool>? isFavorite,
    Expression<String>? icon,
    Expression<double>? score,
    Expression<double>? newScore,
    Expression<int>? manualOrderIndex,
    Expression<String>? complexJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (ohType != null) 'oh_type': ohType,
      if (ohName != null) 'oh_name': ohName,
      if (ohLabel != null) 'oh_label': ohLabel,
      if (customLabel != null) 'custom_label': customLabel,
      if (ohCategory != null) 'oh_category': ohCategory,
      if (ohTags != null) 'oh_tags': ohTags,
      if (ohGroups != null) 'oh_groups': ohGroups,
      if (roomId != null) 'room_id': roomId,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (icon != null) 'icon': icon,
      if (score != null) 'score': score,
      if (newScore != null) 'new_score': newScore,
      if (manualOrderIndex != null) 'manual_order_index': manualOrderIndex,
      if (complexJson != null) 'complex_json': complexJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsTableCompanion copyWith(
      {Value<ItemType?>? type,
      Value<OhItemType>? ohType,
      Value<String>? ohName,
      Value<String>? ohLabel,
      Value<String?>? customLabel,
      Value<String?>? ohCategory,
      Value<List<String>?>? ohTags,
      Value<List<String>?>? ohGroups,
      Value<int?>? roomId,
      Value<bool>? isFavorite,
      Value<IconData?>? icon,
      Value<double>? score,
      Value<double>? newScore,
      Value<int>? manualOrderIndex,
      Value<Map<String, dynamic>?>? complexJson,
      Value<int>? rowid}) {
    return ItemsTableCompanion(
      type: type ?? this.type,
      ohType: ohType ?? this.ohType,
      ohName: ohName ?? this.ohName,
      ohLabel: ohLabel ?? this.ohLabel,
      customLabel: customLabel ?? this.customLabel,
      ohCategory: ohCategory ?? this.ohCategory,
      ohTags: ohTags ?? this.ohTags,
      ohGroups: ohGroups ?? this.ohGroups,
      roomId: roomId ?? this.roomId,
      isFavorite: isFavorite ?? this.isFavorite,
      icon: icon ?? this.icon,
      score: score ?? this.score,
      newScore: newScore ?? this.newScore,
      manualOrderIndex: manualOrderIndex ?? this.manualOrderIndex,
      complexJson: complexJson ?? this.complexJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      map['type'] =
          Variable<String>($ItemsTableTable.$convertertypen.toSql(type.value));
    }
    if (ohType.present) {
      map['oh_type'] = Variable<String>(
          $ItemsTableTable.$converterohType.toSql(ohType.value));
    }
    if (ohName.present) {
      map['oh_name'] = Variable<String>(ohName.value);
    }
    if (ohLabel.present) {
      map['oh_label'] = Variable<String>(ohLabel.value);
    }
    if (customLabel.present) {
      map['custom_label'] = Variable<String>(customLabel.value);
    }
    if (ohCategory.present) {
      map['oh_category'] = Variable<String>(ohCategory.value);
    }
    if (ohTags.present) {
      map['oh_tags'] = Variable<String>(
          $ItemsTableTable.$converterohTagsn.toSql(ohTags.value));
    }
    if (ohGroups.present) {
      map['oh_groups'] = Variable<String>(
          $ItemsTableTable.$converterohGroupsn.toSql(ohGroups.value));
    }
    if (roomId.present) {
      map['room_id'] = Variable<int>(roomId.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (icon.present) {
      map['icon'] =
          Variable<String>($ItemsTableTable.$convertericonn.toSql(icon.value));
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (newScore.present) {
      map['new_score'] = Variable<double>(newScore.value);
    }
    if (manualOrderIndex.present) {
      map['manual_order_index'] = Variable<int>(manualOrderIndex.value);
    }
    if (complexJson.present) {
      map['complex_json'] = Variable<String>(
          $ItemsTableTable.$convertercomplexJson.toSql(complexJson.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsTableCompanion(')
          ..write('type: $type, ')
          ..write('ohType: $ohType, ')
          ..write('ohName: $ohName, ')
          ..write('ohLabel: $ohLabel, ')
          ..write('customLabel: $customLabel, ')
          ..write('ohCategory: $ohCategory, ')
          ..write('ohTags: $ohTags, ')
          ..write('ohGroups: $ohGroups, ')
          ..write('roomId: $roomId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('icon: $icon, ')
          ..write('score: $score, ')
          ..write('newScore: $newScore, ')
          ..write('manualOrderIndex: $manualOrderIndex, ')
          ..write('complexJson: $complexJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemStatesTableTable extends ItemStatesTable
    with TableInfo<$ItemStatesTableTable, ItemState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemStatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ohNameMeta = const VerificationMeta('ohName');
  @override
  late final GeneratedColumn<String> ohName = GeneratedColumn<String>(
      'oh_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES items_table (oh_name)'));
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transformedStateMeta =
      const VerificationMeta('transformedState');
  @override
  late final GeneratedColumn<String> transformedState = GeneratedColumn<String>(
      'transformed_state', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<StateDescription?, String>
      stateDescription = GeneratedColumn<String>(
              'state_description', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<StateDescription?>(
              $ItemStatesTableTable.$converterstateDescriptionn);
  @override
  late final GeneratedColumnWithTypeConverter<CommandDescription?, String>
      commandDescription = GeneratedColumn<String>(
              'command_description', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<CommandDescription?>(
              $ItemStatesTableTable.$convertercommandDescriptionn);
  static const VerificationMeta _ohUnitSymbolMeta =
      const VerificationMeta('ohUnitSymbol');
  @override
  late final GeneratedColumn<String> ohUnitSymbol = GeneratedColumn<String>(
      'oh_unit_symbol', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        ohName,
        state,
        transformedState,
        stateDescription,
        commandDescription,
        ohUnitSymbol
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_states_table';
  @override
  VerificationContext validateIntegrity(Insertable<ItemState> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('oh_name')) {
      context.handle(_ohNameMeta,
          ohName.isAcceptableOrUnknown(data['oh_name']!, _ohNameMeta));
    } else if (isInserting) {
      context.missing(_ohNameMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('transformed_state')) {
      context.handle(
          _transformedStateMeta,
          transformedState.isAcceptableOrUnknown(
              data['transformed_state']!, _transformedStateMeta));
    }
    if (data.containsKey('oh_unit_symbol')) {
      context.handle(
          _ohUnitSymbolMeta,
          ohUnitSymbol.isAcceptableOrUnknown(
              data['oh_unit_symbol']!, _ohUnitSymbolMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ohName};
  @override
  ItemState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemState(
      ohName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oh_name'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      transformedState: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transformed_state']),
      stateDescription: $ItemStatesTableTable.$converterstateDescriptionn
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}state_description'])),
      commandDescription: $ItemStatesTableTable.$convertercommandDescriptionn
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}command_description'])),
      ohUnitSymbol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oh_unit_symbol']),
    );
  }

  @override
  $ItemStatesTableTable createAlias(String alias) {
    return $ItemStatesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<StateDescription, String> $converterstateDescription =
      const StateDescriptionConverter();
  static TypeConverter<StateDescription?, String?> $converterstateDescriptionn =
      NullAwareTypeConverter.wrap($converterstateDescription);
  static TypeConverter<CommandDescription, String>
      $convertercommandDescription = const CommandDescriptionConverter();
  static TypeConverter<CommandDescription?, String?>
      $convertercommandDescriptionn =
      NullAwareTypeConverter.wrap($convertercommandDescription);
}

class ItemState extends DataClass implements Insertable<ItemState> {
  final String ohName;
  final String state;
  final String? transformedState;
  final StateDescription? stateDescription;
  final CommandDescription? commandDescription;
  final String? ohUnitSymbol;
  const ItemState(
      {required this.ohName,
      required this.state,
      this.transformedState,
      this.stateDescription,
      this.commandDescription,
      this.ohUnitSymbol});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['oh_name'] = Variable<String>(ohName);
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || transformedState != null) {
      map['transformed_state'] = Variable<String>(transformedState);
    }
    if (!nullToAbsent || stateDescription != null) {
      map['state_description'] = Variable<String>($ItemStatesTableTable
          .$converterstateDescriptionn
          .toSql(stateDescription));
    }
    if (!nullToAbsent || commandDescription != null) {
      map['command_description'] = Variable<String>($ItemStatesTableTable
          .$convertercommandDescriptionn
          .toSql(commandDescription));
    }
    if (!nullToAbsent || ohUnitSymbol != null) {
      map['oh_unit_symbol'] = Variable<String>(ohUnitSymbol);
    }
    return map;
  }

  ItemStatesTableCompanion toCompanion(bool nullToAbsent) {
    return ItemStatesTableCompanion(
      ohName: Value(ohName),
      state: Value(state),
      transformedState: transformedState == null && nullToAbsent
          ? const Value.absent()
          : Value(transformedState),
      stateDescription: stateDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(stateDescription),
      commandDescription: commandDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(commandDescription),
      ohUnitSymbol: ohUnitSymbol == null && nullToAbsent
          ? const Value.absent()
          : Value(ohUnitSymbol),
    );
  }

  factory ItemState.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemState(
      ohName: serializer.fromJson<String>(json['ohName']),
      state: serializer.fromJson<String>(json['state']),
      transformedState: serializer.fromJson<String?>(json['transformedState']),
      stateDescription:
          serializer.fromJson<StateDescription?>(json['stateDescription']),
      commandDescription:
          serializer.fromJson<CommandDescription?>(json['commandDescription']),
      ohUnitSymbol: serializer.fromJson<String?>(json['ohUnitSymbol']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ohName': serializer.toJson<String>(ohName),
      'state': serializer.toJson<String>(state),
      'transformedState': serializer.toJson<String?>(transformedState),
      'stateDescription':
          serializer.toJson<StateDescription?>(stateDescription),
      'commandDescription':
          serializer.toJson<CommandDescription?>(commandDescription),
      'ohUnitSymbol': serializer.toJson<String?>(ohUnitSymbol),
    };
  }

  ItemState copyWith(
          {String? ohName,
          String? state,
          Value<String?> transformedState = const Value.absent(),
          Value<StateDescription?> stateDescription = const Value.absent(),
          Value<CommandDescription?> commandDescription = const Value.absent(),
          Value<String?> ohUnitSymbol = const Value.absent()}) =>
      ItemState(
        ohName: ohName ?? this.ohName,
        state: state ?? this.state,
        transformedState: transformedState.present
            ? transformedState.value
            : this.transformedState,
        stateDescription: stateDescription.present
            ? stateDescription.value
            : this.stateDescription,
        commandDescription: commandDescription.present
            ? commandDescription.value
            : this.commandDescription,
        ohUnitSymbol:
            ohUnitSymbol.present ? ohUnitSymbol.value : this.ohUnitSymbol,
      );
  ItemState copyWithCompanion(ItemStatesTableCompanion data) {
    return ItemState(
      ohName: data.ohName.present ? data.ohName.value : this.ohName,
      state: data.state.present ? data.state.value : this.state,
      transformedState: data.transformedState.present
          ? data.transformedState.value
          : this.transformedState,
      stateDescription: data.stateDescription.present
          ? data.stateDescription.value
          : this.stateDescription,
      commandDescription: data.commandDescription.present
          ? data.commandDescription.value
          : this.commandDescription,
      ohUnitSymbol: data.ohUnitSymbol.present
          ? data.ohUnitSymbol.value
          : this.ohUnitSymbol,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemState(')
          ..write('ohName: $ohName, ')
          ..write('state: $state, ')
          ..write('transformedState: $transformedState, ')
          ..write('stateDescription: $stateDescription, ')
          ..write('commandDescription: $commandDescription, ')
          ..write('ohUnitSymbol: $ohUnitSymbol')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ohName, state, transformedState,
      stateDescription, commandDescription, ohUnitSymbol);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemState &&
          other.ohName == this.ohName &&
          other.state == this.state &&
          other.transformedState == this.transformedState &&
          other.stateDescription == this.stateDescription &&
          other.commandDescription == this.commandDescription &&
          other.ohUnitSymbol == this.ohUnitSymbol);
}

class ItemStatesTableCompanion extends UpdateCompanion<ItemState> {
  final Value<String> ohName;
  final Value<String> state;
  final Value<String?> transformedState;
  final Value<StateDescription?> stateDescription;
  final Value<CommandDescription?> commandDescription;
  final Value<String?> ohUnitSymbol;
  final Value<int> rowid;
  const ItemStatesTableCompanion({
    this.ohName = const Value.absent(),
    this.state = const Value.absent(),
    this.transformedState = const Value.absent(),
    this.stateDescription = const Value.absent(),
    this.commandDescription = const Value.absent(),
    this.ohUnitSymbol = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemStatesTableCompanion.insert({
    required String ohName,
    required String state,
    this.transformedState = const Value.absent(),
    this.stateDescription = const Value.absent(),
    this.commandDescription = const Value.absent(),
    this.ohUnitSymbol = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : ohName = Value(ohName),
        state = Value(state);
  static Insertable<ItemState> custom({
    Expression<String>? ohName,
    Expression<String>? state,
    Expression<String>? transformedState,
    Expression<String>? stateDescription,
    Expression<String>? commandDescription,
    Expression<String>? ohUnitSymbol,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ohName != null) 'oh_name': ohName,
      if (state != null) 'state': state,
      if (transformedState != null) 'transformed_state': transformedState,
      if (stateDescription != null) 'state_description': stateDescription,
      if (commandDescription != null) 'command_description': commandDescription,
      if (ohUnitSymbol != null) 'oh_unit_symbol': ohUnitSymbol,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemStatesTableCompanion copyWith(
      {Value<String>? ohName,
      Value<String>? state,
      Value<String?>? transformedState,
      Value<StateDescription?>? stateDescription,
      Value<CommandDescription?>? commandDescription,
      Value<String?>? ohUnitSymbol,
      Value<int>? rowid}) {
    return ItemStatesTableCompanion(
      ohName: ohName ?? this.ohName,
      state: state ?? this.state,
      transformedState: transformedState ?? this.transformedState,
      stateDescription: stateDescription ?? this.stateDescription,
      commandDescription: commandDescription ?? this.commandDescription,
      ohUnitSymbol: ohUnitSymbol ?? this.ohUnitSymbol,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ohName.present) {
      map['oh_name'] = Variable<String>(ohName.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (transformedState.present) {
      map['transformed_state'] = Variable<String>(transformedState.value);
    }
    if (stateDescription.present) {
      map['state_description'] = Variable<String>($ItemStatesTableTable
          .$converterstateDescriptionn
          .toSql(stateDescription.value));
    }
    if (commandDescription.present) {
      map['command_description'] = Variable<String>($ItemStatesTableTable
          .$convertercommandDescriptionn
          .toSql(commandDescription.value));
    }
    if (ohUnitSymbol.present) {
      map['oh_unit_symbol'] = Variable<String>(ohUnitSymbol.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemStatesTableCompanion(')
          ..write('ohName: $ohName, ')
          ..write('state: $state, ')
          ..write('transformedState: $transformedState, ')
          ..write('stateDescription: $stateDescription, ')
          ..write('commandDescription: $commandDescription, ')
          ..write('ohUnitSymbol: $ohUnitSymbol, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RulesTableTable extends RulesTable
    with TableInfo<$RulesTableTable, Rule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> tags =
      GeneratedColumn<String>('tags', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($RulesTableTable.$convertertagsn);
  @override
  late final GeneratedColumnWithTypeConverter<RuleStatusInfo?, String> status =
      GeneratedColumn<String>('status', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<RuleStatusInfo?>($RulesTableTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<List<ActionDTO>?, String>
      actions = GeneratedColumn<String>('actions', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<ActionDTO>?>($RulesTableTable.$converteractions);
  @override
  late final GeneratedColumnWithTypeConverter<List<ConditionDTO>?, String>
      conditions = GeneratedColumn<String>('conditions', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<ConditionDTO>?>(
              $RulesTableTable.$converterconditions);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      configuration = GeneratedColumn<String>(
              'configuration', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Map<String, dynamic>?>(
              $RulesTableTable.$converterconfiguration);
  @override
  late final GeneratedColumnWithTypeConverter<
          List<ConfigDescriptionParameterDTO>?, String> configDescriptions =
      GeneratedColumn<String>('config_descriptions', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<ConfigDescriptionParameterDTO>?>(
              $RulesTableTable.$converterconfigDescriptions);
  @override
  late final GeneratedColumnWithTypeConverter<List<RuleTrigger>?, String>
      triggers = GeneratedColumn<String>('triggers', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<RuleTrigger>?>(
              $RulesTableTable.$convertertriggers);
  static const VerificationMeta _editableMeta =
      const VerificationMeta('editable');
  @override
  late final GeneratedColumn<bool> editable = GeneratedColumn<bool>(
      'editable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("editable" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        name,
        tags,
        status,
        actions,
        conditions,
        configuration,
        configDescriptions,
        triggers,
        editable
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules_table';
  @override
  VerificationContext validateIntegrity(Insertable<Rule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('editable')) {
      context.handle(_editableMeta,
          editable.isAcceptableOrUnknown(data['editable']!, _editableMeta));
    } else if (isInserting) {
      context.missing(_editableMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  Rule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rule(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      tags: $RulesTableTable.$convertertagsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])),
      status: $RulesTableTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])),
      actions: $RulesTableTable.$converteractions.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}actions'])),
      conditions: $RulesTableTable.$converterconditions.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}conditions'])),
      configuration: $RulesTableTable.$converterconfiguration.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}configuration'])),
      configDescriptions: $RulesTableTable.$converterconfigDescriptions.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}config_descriptions'])),
      triggers: $RulesTableTable.$convertertriggers.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}triggers'])),
      editable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}editable'])!,
    );
  }

  @override
  $RulesTableTable createAlias(String alias) {
    return $RulesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertertags =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $convertertagsn =
      NullAwareTypeConverter.wrap($convertertags);
  static TypeConverter<RuleStatusInfo?, String?> $converterstatus =
      const StatusDTOConverter();
  static TypeConverter<List<ActionDTO>?, String?> $converteractions =
      const ActionsDTOListConverter();
  static TypeConverter<List<ConditionDTO>?, String?> $converterconditions =
      const ConditionDtoListConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $converterconfiguration =
      const JsonConverter();
  static TypeConverter<List<ConfigDescriptionParameterDTO>?, String?>
      $converterconfigDescriptions = const ConfigurationDtoListConverter();
  static TypeConverter<List<RuleTrigger>?, String?> $convertertriggers =
      const RuleTriggerListConverter();
}

class Rule extends DataClass implements Insertable<Rule> {
  final String uid;
  final String? name;
  final List<String>? tags;
  final RuleStatusInfo? status;
  final List<ActionDTO>? actions;
  final List<ConditionDTO>? conditions;
  final Map<String, dynamic>? configuration;
  final List<ConfigDescriptionParameterDTO>? configDescriptions;
  final List<RuleTrigger>? triggers;
  final bool editable;
  const Rule(
      {required this.uid,
      this.name,
      this.tags,
      this.status,
      this.actions,
      this.conditions,
      this.configuration,
      this.configDescriptions,
      this.triggers,
      required this.editable});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] =
          Variable<String>($RulesTableTable.$convertertagsn.toSql(tags));
    }
    if (!nullToAbsent || status != null) {
      map['status'] =
          Variable<String>($RulesTableTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || actions != null) {
      map['actions'] =
          Variable<String>($RulesTableTable.$converteractions.toSql(actions));
    }
    if (!nullToAbsent || conditions != null) {
      map['conditions'] = Variable<String>(
          $RulesTableTable.$converterconditions.toSql(conditions));
    }
    if (!nullToAbsent || configuration != null) {
      map['configuration'] = Variable<String>(
          $RulesTableTable.$converterconfiguration.toSql(configuration));
    }
    if (!nullToAbsent || configDescriptions != null) {
      map['config_descriptions'] = Variable<String>($RulesTableTable
          .$converterconfigDescriptions
          .toSql(configDescriptions));
    }
    if (!nullToAbsent || triggers != null) {
      map['triggers'] =
          Variable<String>($RulesTableTable.$convertertriggers.toSql(triggers));
    }
    map['editable'] = Variable<bool>(editable);
    return map;
  }

  RulesTableCompanion toCompanion(bool nullToAbsent) {
    return RulesTableCompanion(
      uid: Value(uid),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      actions: actions == null && nullToAbsent
          ? const Value.absent()
          : Value(actions),
      conditions: conditions == null && nullToAbsent
          ? const Value.absent()
          : Value(conditions),
      configuration: configuration == null && nullToAbsent
          ? const Value.absent()
          : Value(configuration),
      configDescriptions: configDescriptions == null && nullToAbsent
          ? const Value.absent()
          : Value(configDescriptions),
      triggers: triggers == null && nullToAbsent
          ? const Value.absent()
          : Value(triggers),
      editable: Value(editable),
    );
  }

  factory Rule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rule(
      uid: serializer.fromJson<String>(json['uid']),
      name: serializer.fromJson<String?>(json['name']),
      tags: serializer.fromJson<List<String>?>(json['tags']),
      status: serializer.fromJson<RuleStatusInfo?>(json['status']),
      actions: serializer.fromJson<List<ActionDTO>?>(json['actions']),
      conditions: serializer.fromJson<List<ConditionDTO>?>(json['conditions']),
      configuration:
          serializer.fromJson<Map<String, dynamic>?>(json['configuration']),
      configDescriptions:
          serializer.fromJson<List<ConfigDescriptionParameterDTO>?>(
              json['configDescriptions']),
      triggers: serializer.fromJson<List<RuleTrigger>?>(json['triggers']),
      editable: serializer.fromJson<bool>(json['editable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'name': serializer.toJson<String?>(name),
      'tags': serializer.toJson<List<String>?>(tags),
      'status': serializer.toJson<RuleStatusInfo?>(status),
      'actions': serializer.toJson<List<ActionDTO>?>(actions),
      'conditions': serializer.toJson<List<ConditionDTO>?>(conditions),
      'configuration': serializer.toJson<Map<String, dynamic>?>(configuration),
      'configDescriptions': serializer
          .toJson<List<ConfigDescriptionParameterDTO>?>(configDescriptions),
      'triggers': serializer.toJson<List<RuleTrigger>?>(triggers),
      'editable': serializer.toJson<bool>(editable),
    };
  }

  Rule copyWith(
          {String? uid,
          Value<String?> name = const Value.absent(),
          Value<List<String>?> tags = const Value.absent(),
          Value<RuleStatusInfo?> status = const Value.absent(),
          Value<List<ActionDTO>?> actions = const Value.absent(),
          Value<List<ConditionDTO>?> conditions = const Value.absent(),
          Value<Map<String, dynamic>?> configuration = const Value.absent(),
          Value<List<ConfigDescriptionParameterDTO>?> configDescriptions =
              const Value.absent(),
          Value<List<RuleTrigger>?> triggers = const Value.absent(),
          bool? editable}) =>
      Rule(
        uid: uid ?? this.uid,
        name: name.present ? name.value : this.name,
        tags: tags.present ? tags.value : this.tags,
        status: status.present ? status.value : this.status,
        actions: actions.present ? actions.value : this.actions,
        conditions: conditions.present ? conditions.value : this.conditions,
        configuration:
            configuration.present ? configuration.value : this.configuration,
        configDescriptions: configDescriptions.present
            ? configDescriptions.value
            : this.configDescriptions,
        triggers: triggers.present ? triggers.value : this.triggers,
        editable: editable ?? this.editable,
      );
  Rule copyWithCompanion(RulesTableCompanion data) {
    return Rule(
      uid: data.uid.present ? data.uid.value : this.uid,
      name: data.name.present ? data.name.value : this.name,
      tags: data.tags.present ? data.tags.value : this.tags,
      status: data.status.present ? data.status.value : this.status,
      actions: data.actions.present ? data.actions.value : this.actions,
      conditions:
          data.conditions.present ? data.conditions.value : this.conditions,
      configuration: data.configuration.present
          ? data.configuration.value
          : this.configuration,
      configDescriptions: data.configDescriptions.present
          ? data.configDescriptions.value
          : this.configDescriptions,
      triggers: data.triggers.present ? data.triggers.value : this.triggers,
      editable: data.editable.present ? data.editable.value : this.editable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Rule(')
          ..write('uid: $uid, ')
          ..write('name: $name, ')
          ..write('tags: $tags, ')
          ..write('status: $status, ')
          ..write('actions: $actions, ')
          ..write('conditions: $conditions, ')
          ..write('configuration: $configuration, ')
          ..write('configDescriptions: $configDescriptions, ')
          ..write('triggers: $triggers, ')
          ..write('editable: $editable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, name, tags, status, actions, conditions,
      configuration, configDescriptions, triggers, editable);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rule &&
          other.uid == this.uid &&
          other.name == this.name &&
          other.tags == this.tags &&
          other.status == this.status &&
          other.actions == this.actions &&
          other.conditions == this.conditions &&
          other.configuration == this.configuration &&
          other.configDescriptions == this.configDescriptions &&
          other.triggers == this.triggers &&
          other.editable == this.editable);
}

class RulesTableCompanion extends UpdateCompanion<Rule> {
  final Value<String> uid;
  final Value<String?> name;
  final Value<List<String>?> tags;
  final Value<RuleStatusInfo?> status;
  final Value<List<ActionDTO>?> actions;
  final Value<List<ConditionDTO>?> conditions;
  final Value<Map<String, dynamic>?> configuration;
  final Value<List<ConfigDescriptionParameterDTO>?> configDescriptions;
  final Value<List<RuleTrigger>?> triggers;
  final Value<bool> editable;
  final Value<int> rowid;
  const RulesTableCompanion({
    this.uid = const Value.absent(),
    this.name = const Value.absent(),
    this.tags = const Value.absent(),
    this.status = const Value.absent(),
    this.actions = const Value.absent(),
    this.conditions = const Value.absent(),
    this.configuration = const Value.absent(),
    this.configDescriptions = const Value.absent(),
    this.triggers = const Value.absent(),
    this.editable = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RulesTableCompanion.insert({
    required String uid,
    this.name = const Value.absent(),
    this.tags = const Value.absent(),
    this.status = const Value.absent(),
    this.actions = const Value.absent(),
    this.conditions = const Value.absent(),
    this.configuration = const Value.absent(),
    this.configDescriptions = const Value.absent(),
    this.triggers = const Value.absent(),
    required bool editable,
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        editable = Value(editable);
  static Insertable<Rule> custom({
    Expression<String>? uid,
    Expression<String>? name,
    Expression<String>? tags,
    Expression<String>? status,
    Expression<String>? actions,
    Expression<String>? conditions,
    Expression<String>? configuration,
    Expression<String>? configDescriptions,
    Expression<String>? triggers,
    Expression<bool>? editable,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (name != null) 'name': name,
      if (tags != null) 'tags': tags,
      if (status != null) 'status': status,
      if (actions != null) 'actions': actions,
      if (conditions != null) 'conditions': conditions,
      if (configuration != null) 'configuration': configuration,
      if (configDescriptions != null) 'config_descriptions': configDescriptions,
      if (triggers != null) 'triggers': triggers,
      if (editable != null) 'editable': editable,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RulesTableCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? name,
      Value<List<String>?>? tags,
      Value<RuleStatusInfo?>? status,
      Value<List<ActionDTO>?>? actions,
      Value<List<ConditionDTO>?>? conditions,
      Value<Map<String, dynamic>?>? configuration,
      Value<List<ConfigDescriptionParameterDTO>?>? configDescriptions,
      Value<List<RuleTrigger>?>? triggers,
      Value<bool>? editable,
      Value<int>? rowid}) {
    return RulesTableCompanion(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      actions: actions ?? this.actions,
      conditions: conditions ?? this.conditions,
      configuration: configuration ?? this.configuration,
      configDescriptions: configDescriptions ?? this.configDescriptions,
      triggers: triggers ?? this.triggers,
      editable: editable ?? this.editable,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tags.present) {
      map['tags'] =
          Variable<String>($RulesTableTable.$convertertagsn.toSql(tags.value));
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $RulesTableTable.$converterstatus.toSql(status.value));
    }
    if (actions.present) {
      map['actions'] = Variable<String>(
          $RulesTableTable.$converteractions.toSql(actions.value));
    }
    if (conditions.present) {
      map['conditions'] = Variable<String>(
          $RulesTableTable.$converterconditions.toSql(conditions.value));
    }
    if (configuration.present) {
      map['configuration'] = Variable<String>(
          $RulesTableTable.$converterconfiguration.toSql(configuration.value));
    }
    if (configDescriptions.present) {
      map['config_descriptions'] = Variable<String>($RulesTableTable
          .$converterconfigDescriptions
          .toSql(configDescriptions.value));
    }
    if (triggers.present) {
      map['triggers'] = Variable<String>(
          $RulesTableTable.$convertertriggers.toSql(triggers.value));
    }
    if (editable.present) {
      map['editable'] = Variable<bool>(editable.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RulesTableCompanion(')
          ..write('uid: $uid, ')
          ..write('name: $name, ')
          ..write('tags: $tags, ')
          ..write('status: $status, ')
          ..write('actions: $actions, ')
          ..write('conditions: $conditions, ')
          ..write('configuration: $configuration, ')
          ..write('configDescriptions: $configDescriptions, ')
          ..write('triggers: $triggers, ')
          ..write('editable: $editable, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoomsTableTable roomsTable = $RoomsTableTable(this);
  late final $ItemsTableTable itemsTable = $ItemsTableTable(this);
  late final $ItemStatesTableTable itemStatesTable =
      $ItemStatesTableTable(this);
  late final $RulesTableTable rulesTable = $RulesTableTable(this);
  late final RoomsStore roomsStore = RoomsStore(this as AppDatabase);
  late final ItemsStore itemsStore = ItemsStore(this as AppDatabase);
  late final RulesStore rulesStore = RulesStore(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [roomsTable, itemsTable, itemStatesTable, rulesTable];
}

typedef $$RoomsTableTableCreateCompanionBuilder = RoomsTableCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<IconData?> icon,
  Value<String?> color,
  Value<int?> level,
  required int sortKey,
  required RoomItemsSortOption itemsSortOption,
});
typedef $$RoomsTableTableUpdateCompanionBuilder = RoomsTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<IconData?> icon,
  Value<String?> color,
  Value<int?> level,
  Value<int> sortKey,
  Value<RoomItemsSortOption> itemsSortOption,
});

final class $$RoomsTableTableReferences
    extends BaseReferences<_$AppDatabase, $RoomsTableTable, Room> {
  $$RoomsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemsTableTable, List<Item>> _itemsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.itemsTable,
          aliasName:
              $_aliasNameGenerator(db.roomsTable.id, db.itemsTable.roomId));

  $$ItemsTableTableProcessedTableManager get itemsTableRefs {
    final manager = $$ItemsTableTableTableManager($_db, $_db.itemsTable)
        .filter((f) => f.roomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RoomsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<IconData?, IconData, String> get icon =>
      $composableBuilder(
          column: $table.icon,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortKey => $composableBuilder(
      column: $table.sortKey, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<RoomItemsSortOption, RoomItemsSortOption,
          String>
      get itemsSortOption => $composableBuilder(
          column: $table.itemsSortOption,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  Expression<bool> itemsTableRefs(
      Expression<bool> Function($$ItemsTableTableFilterComposer f) f) {
    final $$ItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemsTable,
        getReferencedColumn: (t) => t.roomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.itemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoomsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortKey => $composableBuilder(
      column: $table.sortKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemsSortOption => $composableBuilder(
      column: $table.itemsSortOption,
      builder: (column) => ColumnOrderings(column));
}

class $$RoomsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumnWithTypeConverter<IconData?, String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get sortKey =>
      $composableBuilder(column: $table.sortKey, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoomItemsSortOption, String>
      get itemsSortOption => $composableBuilder(
          column: $table.itemsSortOption, builder: (column) => column);

  Expression<T> itemsTableRefs<T extends Object>(
      Expression<T> Function($$ItemsTableTableAnnotationComposer a) f) {
    final $$ItemsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemsTable,
        getReferencedColumn: (t) => t.roomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.itemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoomsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoomsTableTable,
    Room,
    $$RoomsTableTableFilterComposer,
    $$RoomsTableTableOrderingComposer,
    $$RoomsTableTableAnnotationComposer,
    $$RoomsTableTableCreateCompanionBuilder,
    $$RoomsTableTableUpdateCompanionBuilder,
    (Room, $$RoomsTableTableReferences),
    Room,
    PrefetchHooks Function({bool itemsTableRefs})> {
  $$RoomsTableTableTableManager(_$AppDatabase db, $RoomsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<IconData?> icon = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int?> level = const Value.absent(),
            Value<int> sortKey = const Value.absent(),
            Value<RoomItemsSortOption> itemsSortOption = const Value.absent(),
          }) =>
              RoomsTableCompanion(
            id: id,
            name: name,
            description: description,
            icon: icon,
            color: color,
            level: level,
            sortKey: sortKey,
            itemsSortOption: itemsSortOption,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<IconData?> icon = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int?> level = const Value.absent(),
            required int sortKey,
            required RoomItemsSortOption itemsSortOption,
          }) =>
              RoomsTableCompanion.insert(
            id: id,
            name: name,
            description: description,
            icon: icon,
            color: color,
            level: level,
            sortKey: sortKey,
            itemsSortOption: itemsSortOption,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RoomsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({itemsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (itemsTableRefs) db.itemsTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemsTableRefs)
                    await $_getPrefetchedData<Room, $RoomsTableTable, Item>(
                        currentTable: table,
                        referencedTable: $$RoomsTableTableReferences
                            ._itemsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoomsTableTableReferences(db, table, p0)
                                .itemsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roomId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoomsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RoomsTableTable,
    Room,
    $$RoomsTableTableFilterComposer,
    $$RoomsTableTableOrderingComposer,
    $$RoomsTableTableAnnotationComposer,
    $$RoomsTableTableCreateCompanionBuilder,
    $$RoomsTableTableUpdateCompanionBuilder,
    (Room, $$RoomsTableTableReferences),
    Room,
    PrefetchHooks Function({bool itemsTableRefs})>;
typedef $$ItemsTableTableCreateCompanionBuilder = ItemsTableCompanion Function({
  Value<ItemType?> type,
  required OhItemType ohType,
  required String ohName,
  required String ohLabel,
  Value<String?> customLabel,
  Value<String?> ohCategory,
  Value<List<String>?> ohTags,
  Value<List<String>?> ohGroups,
  Value<int?> roomId,
  Value<bool> isFavorite,
  Value<IconData?> icon,
  Value<double> score,
  Value<double> newScore,
  Value<int> manualOrderIndex,
  Value<Map<String, dynamic>?> complexJson,
  Value<int> rowid,
});
typedef $$ItemsTableTableUpdateCompanionBuilder = ItemsTableCompanion Function({
  Value<ItemType?> type,
  Value<OhItemType> ohType,
  Value<String> ohName,
  Value<String> ohLabel,
  Value<String?> customLabel,
  Value<String?> ohCategory,
  Value<List<String>?> ohTags,
  Value<List<String>?> ohGroups,
  Value<int?> roomId,
  Value<bool> isFavorite,
  Value<IconData?> icon,
  Value<double> score,
  Value<double> newScore,
  Value<int> manualOrderIndex,
  Value<Map<String, dynamic>?> complexJson,
  Value<int> rowid,
});

final class $$ItemsTableTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTableTable, Item> {
  $$ItemsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoomsTableTable _roomIdTable(_$AppDatabase db) =>
      db.roomsTable.createAlias(
          $_aliasNameGenerator(db.itemsTable.roomId, db.roomsTable.id));

  $$RoomsTableTableProcessedTableManager? get roomId {
    final $_column = $_itemColumn<int>('room_id');
    if ($_column == null) return null;
    final manager = $$RoomsTableTableTableManager($_db, $_db.roomsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ItemStatesTableTable, List<ItemState>>
      _itemStatesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.itemStatesTable,
              aliasName: $_aliasNameGenerator(
                  db.itemsTable.ohName, db.itemStatesTable.ohName));

  $$ItemStatesTableTableProcessedTableManager get itemStatesTableRefs {
    final manager =
        $$ItemStatesTableTableTableManager($_db, $_db.itemStatesTable).filter(
            (f) => f.ohName.ohName.sqlEquals($_itemColumn<String>('oh_name')!));

    final cache =
        $_typedResult.readTableOrNull(_itemStatesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ItemsTableTable> {
  $$ItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<ItemType?, ItemType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<OhItemType, OhItemType, String> get ohType =>
      $composableBuilder(
          column: $table.ohType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get ohName => $composableBuilder(
      column: $table.ohName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ohLabel => $composableBuilder(
      column: $table.ohLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customLabel => $composableBuilder(
      column: $table.customLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ohCategory => $composableBuilder(
      column: $table.ohCategory, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
      get ohTags => $composableBuilder(
          column: $table.ohTags,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
      get ohGroups => $composableBuilder(
          column: $table.ohGroups,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<IconData?, IconData, String> get icon =>
      $composableBuilder(
          column: $table.icon,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get newScore => $composableBuilder(
      column: $table.newScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get manualOrderIndex => $composableBuilder(
      column: $table.manualOrderIndex,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get complexJson => $composableBuilder(
          column: $table.complexJson,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$RoomsTableTableFilterComposer get roomId {
    final $$RoomsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.roomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableTableFilterComposer(
              $db: $db,
              $table: $db.roomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> itemStatesTableRefs(
      Expression<bool> Function($$ItemStatesTableTableFilterComposer f) f) {
    final $$ItemStatesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ohName,
        referencedTable: $db.itemStatesTable,
        getReferencedColumn: (t) => t.ohName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemStatesTableTableFilterComposer(
              $db: $db,
              $table: $db.itemStatesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTableTable> {
  $$ItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ohType => $composableBuilder(
      column: $table.ohType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ohName => $composableBuilder(
      column: $table.ohName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ohLabel => $composableBuilder(
      column: $table.ohLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customLabel => $composableBuilder(
      column: $table.customLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ohCategory => $composableBuilder(
      column: $table.ohCategory, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ohTags => $composableBuilder(
      column: $table.ohTags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ohGroups => $composableBuilder(
      column: $table.ohGroups, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get newScore => $composableBuilder(
      column: $table.newScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get manualOrderIndex => $composableBuilder(
      column: $table.manualOrderIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get complexJson => $composableBuilder(
      column: $table.complexJson, builder: (column) => ColumnOrderings(column));

  $$RoomsTableTableOrderingComposer get roomId {
    final $$RoomsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.roomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableTableOrderingComposer(
              $db: $db,
              $table: $db.roomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTableTable> {
  $$ItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<ItemType?, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OhItemType, String> get ohType =>
      $composableBuilder(column: $table.ohType, builder: (column) => column);

  GeneratedColumn<String> get ohName =>
      $composableBuilder(column: $table.ohName, builder: (column) => column);

  GeneratedColumn<String> get ohLabel =>
      $composableBuilder(column: $table.ohLabel, builder: (column) => column);

  GeneratedColumn<String> get customLabel => $composableBuilder(
      column: $table.customLabel, builder: (column) => column);

  GeneratedColumn<String> get ohCategory => $composableBuilder(
      column: $table.ohCategory, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get ohTags =>
      $composableBuilder(column: $table.ohTags, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get ohGroups =>
      $composableBuilder(column: $table.ohGroups, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumnWithTypeConverter<IconData?, String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<double> get newScore =>
      $composableBuilder(column: $table.newScore, builder: (column) => column);

  GeneratedColumn<int> get manualOrderIndex => $composableBuilder(
      column: $table.manualOrderIndex, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      get complexJson => $composableBuilder(
          column: $table.complexJson, builder: (column) => column);

  $$RoomsTableTableAnnotationComposer get roomId {
    final $$RoomsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roomId,
        referencedTable: $db.roomsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoomsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.roomsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> itemStatesTableRefs<T extends Object>(
      Expression<T> Function($$ItemStatesTableTableAnnotationComposer a) f) {
    final $$ItemStatesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ohName,
        referencedTable: $db.itemStatesTable,
        getReferencedColumn: (t) => t.ohName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemStatesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.itemStatesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ItemsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemsTableTable,
    Item,
    $$ItemsTableTableFilterComposer,
    $$ItemsTableTableOrderingComposer,
    $$ItemsTableTableAnnotationComposer,
    $$ItemsTableTableCreateCompanionBuilder,
    $$ItemsTableTableUpdateCompanionBuilder,
    (Item, $$ItemsTableTableReferences),
    Item,
    PrefetchHooks Function({bool roomId, bool itemStatesTableRefs})> {
  $$ItemsTableTableTableManager(_$AppDatabase db, $ItemsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<ItemType?> type = const Value.absent(),
            Value<OhItemType> ohType = const Value.absent(),
            Value<String> ohName = const Value.absent(),
            Value<String> ohLabel = const Value.absent(),
            Value<String?> customLabel = const Value.absent(),
            Value<String?> ohCategory = const Value.absent(),
            Value<List<String>?> ohTags = const Value.absent(),
            Value<List<String>?> ohGroups = const Value.absent(),
            Value<int?> roomId = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<IconData?> icon = const Value.absent(),
            Value<double> score = const Value.absent(),
            Value<double> newScore = const Value.absent(),
            Value<int> manualOrderIndex = const Value.absent(),
            Value<Map<String, dynamic>?> complexJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemsTableCompanion(
            type: type,
            ohType: ohType,
            ohName: ohName,
            ohLabel: ohLabel,
            customLabel: customLabel,
            ohCategory: ohCategory,
            ohTags: ohTags,
            ohGroups: ohGroups,
            roomId: roomId,
            isFavorite: isFavorite,
            icon: icon,
            score: score,
            newScore: newScore,
            manualOrderIndex: manualOrderIndex,
            complexJson: complexJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<ItemType?> type = const Value.absent(),
            required OhItemType ohType,
            required String ohName,
            required String ohLabel,
            Value<String?> customLabel = const Value.absent(),
            Value<String?> ohCategory = const Value.absent(),
            Value<List<String>?> ohTags = const Value.absent(),
            Value<List<String>?> ohGroups = const Value.absent(),
            Value<int?> roomId = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<IconData?> icon = const Value.absent(),
            Value<double> score = const Value.absent(),
            Value<double> newScore = const Value.absent(),
            Value<int> manualOrderIndex = const Value.absent(),
            Value<Map<String, dynamic>?> complexJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemsTableCompanion.insert(
            type: type,
            ohType: ohType,
            ohName: ohName,
            ohLabel: ohLabel,
            customLabel: customLabel,
            ohCategory: ohCategory,
            ohTags: ohTags,
            ohGroups: ohGroups,
            roomId: roomId,
            isFavorite: isFavorite,
            icon: icon,
            score: score,
            newScore: newScore,
            manualOrderIndex: manualOrderIndex,
            complexJson: complexJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ItemsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {roomId = false, itemStatesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (itemStatesTableRefs) db.itemStatesTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (roomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roomId,
                    referencedTable:
                        $$ItemsTableTableReferences._roomIdTable(db),
                    referencedColumn:
                        $$ItemsTableTableReferences._roomIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemStatesTableRefs)
                    await $_getPrefetchedData<Item, $ItemsTableTable,
                            ItemState>(
                        currentTable: table,
                        referencedTable: $$ItemsTableTableReferences
                            ._itemStatesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableTableReferences(db, table, p0)
                                .itemStatesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.ohName == item.ohName),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ItemsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemsTableTable,
    Item,
    $$ItemsTableTableFilterComposer,
    $$ItemsTableTableOrderingComposer,
    $$ItemsTableTableAnnotationComposer,
    $$ItemsTableTableCreateCompanionBuilder,
    $$ItemsTableTableUpdateCompanionBuilder,
    (Item, $$ItemsTableTableReferences),
    Item,
    PrefetchHooks Function({bool roomId, bool itemStatesTableRefs})>;
typedef $$ItemStatesTableTableCreateCompanionBuilder = ItemStatesTableCompanion
    Function({
  required String ohName,
  required String state,
  Value<String?> transformedState,
  Value<StateDescription?> stateDescription,
  Value<CommandDescription?> commandDescription,
  Value<String?> ohUnitSymbol,
  Value<int> rowid,
});
typedef $$ItemStatesTableTableUpdateCompanionBuilder = ItemStatesTableCompanion
    Function({
  Value<String> ohName,
  Value<String> state,
  Value<String?> transformedState,
  Value<StateDescription?> stateDescription,
  Value<CommandDescription?> commandDescription,
  Value<String?> ohUnitSymbol,
  Value<int> rowid,
});

final class $$ItemStatesTableTableReferences
    extends BaseReferences<_$AppDatabase, $ItemStatesTableTable, ItemState> {
  $$ItemStatesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTableTable _ohNameTable(_$AppDatabase db) =>
      db.itemsTable.createAlias($_aliasNameGenerator(
          db.itemStatesTable.ohName, db.itemsTable.ohName));

  $$ItemsTableTableProcessedTableManager get ohName {
    final $_column = $_itemColumn<String>('oh_name')!;

    final manager = $$ItemsTableTableTableManager($_db, $_db.itemsTable)
        .filter((f) => f.ohName.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ohNameTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ItemStatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ItemStatesTableTable> {
  $$ItemStatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transformedState => $composableBuilder(
      column: $table.transformedState,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<StateDescription?, StateDescription, String>
      get stateDescription => $composableBuilder(
          column: $table.stateDescription,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<CommandDescription?, CommandDescription,
          String>
      get commandDescription => $composableBuilder(
          column: $table.commandDescription,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get ohUnitSymbol => $composableBuilder(
      column: $table.ohUnitSymbol, builder: (column) => ColumnFilters(column));

  $$ItemsTableTableFilterComposer get ohName {
    final $$ItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ohName,
        referencedTable: $db.itemsTable,
        getReferencedColumn: (t) => t.ohName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.itemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemStatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemStatesTableTable> {
  $$ItemStatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transformedState => $composableBuilder(
      column: $table.transformedState,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stateDescription => $composableBuilder(
      column: $table.stateDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commandDescription => $composableBuilder(
      column: $table.commandDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ohUnitSymbol => $composableBuilder(
      column: $table.ohUnitSymbol,
      builder: (column) => ColumnOrderings(column));

  $$ItemsTableTableOrderingComposer get ohName {
    final $$ItemsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ohName,
        referencedTable: $db.itemsTable,
        getReferencedColumn: (t) => t.ohName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableTableOrderingComposer(
              $db: $db,
              $table: $db.itemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemStatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemStatesTableTable> {
  $$ItemStatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get transformedState => $composableBuilder(
      column: $table.transformedState, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StateDescription?, String>
      get stateDescription => $composableBuilder(
          column: $table.stateDescription, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CommandDescription?, String>
      get commandDescription => $composableBuilder(
          column: $table.commandDescription, builder: (column) => column);

  GeneratedColumn<String> get ohUnitSymbol => $composableBuilder(
      column: $table.ohUnitSymbol, builder: (column) => column);

  $$ItemsTableTableAnnotationComposer get ohName {
    final $$ItemsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ohName,
        referencedTable: $db.itemsTable,
        getReferencedColumn: (t) => t.ohName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.itemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemStatesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemStatesTableTable,
    ItemState,
    $$ItemStatesTableTableFilterComposer,
    $$ItemStatesTableTableOrderingComposer,
    $$ItemStatesTableTableAnnotationComposer,
    $$ItemStatesTableTableCreateCompanionBuilder,
    $$ItemStatesTableTableUpdateCompanionBuilder,
    (ItemState, $$ItemStatesTableTableReferences),
    ItemState,
    PrefetchHooks Function({bool ohName})> {
  $$ItemStatesTableTableTableManager(
      _$AppDatabase db, $ItemStatesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemStatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemStatesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemStatesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> ohName = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<String?> transformedState = const Value.absent(),
            Value<StateDescription?> stateDescription = const Value.absent(),
            Value<CommandDescription?> commandDescription =
                const Value.absent(),
            Value<String?> ohUnitSymbol = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemStatesTableCompanion(
            ohName: ohName,
            state: state,
            transformedState: transformedState,
            stateDescription: stateDescription,
            commandDescription: commandDescription,
            ohUnitSymbol: ohUnitSymbol,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String ohName,
            required String state,
            Value<String?> transformedState = const Value.absent(),
            Value<StateDescription?> stateDescription = const Value.absent(),
            Value<CommandDescription?> commandDescription =
                const Value.absent(),
            Value<String?> ohUnitSymbol = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemStatesTableCompanion.insert(
            ohName: ohName,
            state: state,
            transformedState: transformedState,
            stateDescription: stateDescription,
            commandDescription: commandDescription,
            ohUnitSymbol: ohUnitSymbol,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ItemStatesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ohName = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ohName) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ohName,
                    referencedTable:
                        $$ItemStatesTableTableReferences._ohNameTable(db),
                    referencedColumn: $$ItemStatesTableTableReferences
                        ._ohNameTable(db)
                        .ohName,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ItemStatesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemStatesTableTable,
    ItemState,
    $$ItemStatesTableTableFilterComposer,
    $$ItemStatesTableTableOrderingComposer,
    $$ItemStatesTableTableAnnotationComposer,
    $$ItemStatesTableTableCreateCompanionBuilder,
    $$ItemStatesTableTableUpdateCompanionBuilder,
    (ItemState, $$ItemStatesTableTableReferences),
    ItemState,
    PrefetchHooks Function({bool ohName})>;
typedef $$RulesTableTableCreateCompanionBuilder = RulesTableCompanion Function({
  required String uid,
  Value<String?> name,
  Value<List<String>?> tags,
  Value<RuleStatusInfo?> status,
  Value<List<ActionDTO>?> actions,
  Value<List<ConditionDTO>?> conditions,
  Value<Map<String, dynamic>?> configuration,
  Value<List<ConfigDescriptionParameterDTO>?> configDescriptions,
  Value<List<RuleTrigger>?> triggers,
  required bool editable,
  Value<int> rowid,
});
typedef $$RulesTableTableUpdateCompanionBuilder = RulesTableCompanion Function({
  Value<String> uid,
  Value<String?> name,
  Value<List<String>?> tags,
  Value<RuleStatusInfo?> status,
  Value<List<ActionDTO>?> actions,
  Value<List<ConditionDTO>?> conditions,
  Value<Map<String, dynamic>?> configuration,
  Value<List<ConfigDescriptionParameterDTO>?> configDescriptions,
  Value<List<RuleTrigger>?> triggers,
  Value<bool> editable,
  Value<int> rowid,
});

class $$RulesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RulesTableTable> {
  $$RulesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
      get tags => $composableBuilder(
          column: $table.tags,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<RuleStatusInfo?, RuleStatusInfo, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<ActionDTO>?, List<ActionDTO>, String>
      get actions => $composableBuilder(
          column: $table.actions,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<ConditionDTO>?, List<ConditionDTO>,
          String>
      get conditions => $composableBuilder(
          column: $table.conditions,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<Map<String, dynamic>?, Map<String, dynamic>,
          String>
      get configuration => $composableBuilder(
          column: $table.configuration,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<ConfigDescriptionParameterDTO>?,
          List<ConfigDescriptionParameterDTO>, String>
      get configDescriptions => $composableBuilder(
          column: $table.configDescriptions,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<RuleTrigger>?, List<RuleTrigger>, String>
      get triggers => $composableBuilder(
          column: $table.triggers,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get editable => $composableBuilder(
      column: $table.editable, builder: (column) => ColumnFilters(column));
}

class $$RulesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RulesTableTable> {
  $$RulesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actions => $composableBuilder(
      column: $table.actions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conditions => $composableBuilder(
      column: $table.conditions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get configuration => $composableBuilder(
      column: $table.configuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get configDescriptions => $composableBuilder(
      column: $table.configDescriptions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get triggers => $composableBuilder(
      column: $table.triggers, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get editable => $composableBuilder(
      column: $table.editable, builder: (column) => ColumnOrderings(column));
}

class $$RulesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RulesTableTable> {
  $$RulesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleStatusInfo?, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<ActionDTO>?, String> get actions =>
      $composableBuilder(column: $table.actions, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<ConditionDTO>?, String>
      get conditions => $composableBuilder(
          column: $table.conditions, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
      get configuration => $composableBuilder(
          column: $table.configuration, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<ConfigDescriptionParameterDTO>?, String>
      get configDescriptions => $composableBuilder(
          column: $table.configDescriptions, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<RuleTrigger>?, String> get triggers =>
      $composableBuilder(column: $table.triggers, builder: (column) => column);

  GeneratedColumn<bool> get editable =>
      $composableBuilder(column: $table.editable, builder: (column) => column);
}

class $$RulesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RulesTableTable,
    Rule,
    $$RulesTableTableFilterComposer,
    $$RulesTableTableOrderingComposer,
    $$RulesTableTableAnnotationComposer,
    $$RulesTableTableCreateCompanionBuilder,
    $$RulesTableTableUpdateCompanionBuilder,
    (Rule, BaseReferences<_$AppDatabase, $RulesTableTable, Rule>),
    Rule,
    PrefetchHooks Function()> {
  $$RulesTableTableTableManager(_$AppDatabase db, $RulesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<List<String>?> tags = const Value.absent(),
            Value<RuleStatusInfo?> status = const Value.absent(),
            Value<List<ActionDTO>?> actions = const Value.absent(),
            Value<List<ConditionDTO>?> conditions = const Value.absent(),
            Value<Map<String, dynamic>?> configuration = const Value.absent(),
            Value<List<ConfigDescriptionParameterDTO>?> configDescriptions =
                const Value.absent(),
            Value<List<RuleTrigger>?> triggers = const Value.absent(),
            Value<bool> editable = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RulesTableCompanion(
            uid: uid,
            name: name,
            tags: tags,
            status: status,
            actions: actions,
            conditions: conditions,
            configuration: configuration,
            configDescriptions: configDescriptions,
            triggers: triggers,
            editable: editable,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> name = const Value.absent(),
            Value<List<String>?> tags = const Value.absent(),
            Value<RuleStatusInfo?> status = const Value.absent(),
            Value<List<ActionDTO>?> actions = const Value.absent(),
            Value<List<ConditionDTO>?> conditions = const Value.absent(),
            Value<Map<String, dynamic>?> configuration = const Value.absent(),
            Value<List<ConfigDescriptionParameterDTO>?> configDescriptions =
                const Value.absent(),
            Value<List<RuleTrigger>?> triggers = const Value.absent(),
            required bool editable,
            Value<int> rowid = const Value.absent(),
          }) =>
              RulesTableCompanion.insert(
            uid: uid,
            name: name,
            tags: tags,
            status: status,
            actions: actions,
            conditions: conditions,
            configuration: configuration,
            configDescriptions: configDescriptions,
            triggers: triggers,
            editable: editable,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RulesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RulesTableTable,
    Rule,
    $$RulesTableTableFilterComposer,
    $$RulesTableTableOrderingComposer,
    $$RulesTableTableAnnotationComposer,
    $$RulesTableTableCreateCompanionBuilder,
    $$RulesTableTableUpdateCompanionBuilder,
    (Rule, BaseReferences<_$AppDatabase, $RulesTableTable, Rule>),
    Rule,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoomsTableTableTableManager get roomsTable =>
      $$RoomsTableTableTableManager(_db, _db.roomsTable);
  $$ItemsTableTableTableManager get itemsTable =>
      $$ItemsTableTableTableManager(_db, _db.itemsTable);
  $$ItemStatesTableTableTableManager get itemStatesTable =>
      $$ItemStatesTableTableTableManager(_db, _db.itemStatesTable);
  $$RulesTableTableTableManager get rulesTable =>
      $$RulesTableTableTableManager(_db, _db.rulesTable);
}
