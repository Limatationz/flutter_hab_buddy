// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $InboxTableTable extends InboxTable
    with TableInfo<$InboxTableTable, InboxEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InboxTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<InboxEntryType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<InboxEntryType>($InboxTableTable.$convertertype);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> tags =
      GeneratedColumn<String>('tags', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($InboxTableTable.$convertertagsn);
  static const VerificationMeta _groupsMeta = const VerificationMeta('groups');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> groups =
      GeneratedColumn<String>('groups', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($InboxTableTable.$convertergroupsn);
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
  static const VerificationMeta _stateDescriptionMeta =
      const VerificationMeta('stateDescription');
  @override
  late final GeneratedColumnWithTypeConverter<StateDescription?, String>
      stateDescription = GeneratedColumn<String>(
              'state_description', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<StateDescription?>(
              $InboxTableTable.$converterstateDescriptionn);
  @override
  List<GeneratedColumn> get $columns => [
        type,
        name,
        label,
        category,
        tags,
        groups,
        state,
        transformedState,
        stateDescription
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inbox_table';
  @override
  VerificationContext validateIntegrity(Insertable<InboxEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    context.handle(_tagsMeta, const VerificationResult.success());
    context.handle(_groupsMeta, const VerificationResult.success());
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
    context.handle(_stateDescriptionMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  InboxEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InboxEntry(
      type: $InboxTableTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      tags: $InboxTableTable.$convertertagsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])),
      groups: $InboxTableTable.$convertergroupsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}groups'])),
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      transformedState: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transformed_state']),
      stateDescription: $InboxTableTable.$converterstateDescriptionn.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}state_description'])),
    );
  }

  @override
  $InboxTableTable createAlias(String alias) {
    return $InboxTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InboxEntryType, String, String> $convertertype =
      const EnumNameConverter<InboxEntryType>(InboxEntryType.values);
  static TypeConverter<List<String>, String> $convertertags =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $convertertagsn =
      NullAwareTypeConverter.wrap($convertertags);
  static TypeConverter<List<String>, String> $convertergroups =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $convertergroupsn =
      NullAwareTypeConverter.wrap($convertergroups);
  static TypeConverter<StateDescription, String> $converterstateDescription =
      const StateDescriptionConverter();
  static TypeConverter<StateDescription?, String?> $converterstateDescriptionn =
      NullAwareTypeConverter.wrap($converterstateDescription);
}

class InboxEntry extends DataClass implements Insertable<InboxEntry> {
  final InboxEntryType type;
  final String name;
  final String label;
  final String? category;
  final List<String>? tags;
  final List<String>? groups;
  final String state;
  final String? transformedState;
  final StateDescription? stateDescription;
  const InboxEntry(
      {required this.type,
      required this.name,
      required this.label,
      this.category,
      this.tags,
      this.groups,
      required this.state,
      this.transformedState,
      this.stateDescription});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $InboxTableTable.$convertertype;
      map['type'] = Variable<String>(converter.toSql(type));
    }
    map['name'] = Variable<String>(name);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || tags != null) {
      final converter = $InboxTableTable.$convertertagsn;
      map['tags'] = Variable<String>(converter.toSql(tags));
    }
    if (!nullToAbsent || groups != null) {
      final converter = $InboxTableTable.$convertergroupsn;
      map['groups'] = Variable<String>(converter.toSql(groups));
    }
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || transformedState != null) {
      map['transformed_state'] = Variable<String>(transformedState);
    }
    if (!nullToAbsent || stateDescription != null) {
      final converter = $InboxTableTable.$converterstateDescriptionn;
      map['state_description'] =
          Variable<String>(converter.toSql(stateDescription));
    }
    return map;
  }

  InboxTableCompanion toCompanion(bool nullToAbsent) {
    return InboxTableCompanion(
      type: Value(type),
      name: Value(name),
      label: Value(label),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      groups:
          groups == null && nullToAbsent ? const Value.absent() : Value(groups),
      state: Value(state),
      transformedState: transformedState == null && nullToAbsent
          ? const Value.absent()
          : Value(transformedState),
      stateDescription: stateDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(stateDescription),
    );
  }

  factory InboxEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InboxEntry(
      type: $InboxTableTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      name: serializer.fromJson<String>(json['name']),
      label: serializer.fromJson<String>(json['label']),
      category: serializer.fromJson<String?>(json['category']),
      tags: serializer.fromJson<List<String>?>(json['tags']),
      groups: serializer.fromJson<List<String>?>(json['groups']),
      state: serializer.fromJson<String>(json['state']),
      transformedState: serializer.fromJson<String?>(json['transformedState']),
      stateDescription:
          serializer.fromJson<StateDescription?>(json['stateDescription']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer
          .toJson<String>($InboxTableTable.$convertertype.toJson(type)),
      'name': serializer.toJson<String>(name),
      'label': serializer.toJson<String>(label),
      'category': serializer.toJson<String?>(category),
      'tags': serializer.toJson<List<String>?>(tags),
      'groups': serializer.toJson<List<String>?>(groups),
      'state': serializer.toJson<String>(state),
      'transformedState': serializer.toJson<String?>(transformedState),
      'stateDescription':
          serializer.toJson<StateDescription?>(stateDescription),
    };
  }

  InboxEntry copyWith(
          {InboxEntryType? type,
          String? name,
          String? label,
          Value<String?> category = const Value.absent(),
          Value<List<String>?> tags = const Value.absent(),
          Value<List<String>?> groups = const Value.absent(),
          String? state,
          Value<String?> transformedState = const Value.absent(),
          Value<StateDescription?> stateDescription = const Value.absent()}) =>
      InboxEntry(
        type: type ?? this.type,
        name: name ?? this.name,
        label: label ?? this.label,
        category: category.present ? category.value : this.category,
        tags: tags.present ? tags.value : this.tags,
        groups: groups.present ? groups.value : this.groups,
        state: state ?? this.state,
        transformedState: transformedState.present
            ? transformedState.value
            : this.transformedState,
        stateDescription: stateDescription.present
            ? stateDescription.value
            : this.stateDescription,
      );
  @override
  String toString() {
    return (StringBuffer('InboxEntry(')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('label: $label, ')
          ..write('category: $category, ')
          ..write('tags: $tags, ')
          ..write('groups: $groups, ')
          ..write('state: $state, ')
          ..write('transformedState: $transformedState, ')
          ..write('stateDescription: $stateDescription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(type, name, label, category, tags, groups,
      state, transformedState, stateDescription);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InboxEntry &&
          other.type == this.type &&
          other.name == this.name &&
          other.label == this.label &&
          other.category == this.category &&
          other.tags == this.tags &&
          other.groups == this.groups &&
          other.state == this.state &&
          other.transformedState == this.transformedState &&
          other.stateDescription == this.stateDescription);
}

class InboxTableCompanion extends UpdateCompanion<InboxEntry> {
  final Value<InboxEntryType> type;
  final Value<String> name;
  final Value<String> label;
  final Value<String?> category;
  final Value<List<String>?> tags;
  final Value<List<String>?> groups;
  final Value<String> state;
  final Value<String?> transformedState;
  final Value<StateDescription?> stateDescription;
  final Value<int> rowid;
  const InboxTableCompanion({
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.label = const Value.absent(),
    this.category = const Value.absent(),
    this.tags = const Value.absent(),
    this.groups = const Value.absent(),
    this.state = const Value.absent(),
    this.transformedState = const Value.absent(),
    this.stateDescription = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InboxTableCompanion.insert({
    required InboxEntryType type,
    required String name,
    required String label,
    this.category = const Value.absent(),
    this.tags = const Value.absent(),
    this.groups = const Value.absent(),
    required String state,
    this.transformedState = const Value.absent(),
    this.stateDescription = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : type = Value(type),
        name = Value(name),
        label = Value(label),
        state = Value(state);
  static Insertable<InboxEntry> custom({
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? label,
    Expression<String>? category,
    Expression<String>? tags,
    Expression<String>? groups,
    Expression<String>? state,
    Expression<String>? transformedState,
    Expression<String>? stateDescription,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (label != null) 'label': label,
      if (category != null) 'category': category,
      if (tags != null) 'tags': tags,
      if (groups != null) 'groups': groups,
      if (state != null) 'state': state,
      if (transformedState != null) 'transformed_state': transformedState,
      if (stateDescription != null) 'state_description': stateDescription,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InboxTableCompanion copyWith(
      {Value<InboxEntryType>? type,
      Value<String>? name,
      Value<String>? label,
      Value<String?>? category,
      Value<List<String>?>? tags,
      Value<List<String>?>? groups,
      Value<String>? state,
      Value<String?>? transformedState,
      Value<StateDescription?>? stateDescription,
      Value<int>? rowid}) {
    return InboxTableCompanion(
      type: type ?? this.type,
      name: name ?? this.name,
      label: label ?? this.label,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      groups: groups ?? this.groups,
      state: state ?? this.state,
      transformedState: transformedState ?? this.transformedState,
      stateDescription: stateDescription ?? this.stateDescription,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      final converter = $InboxTableTable.$convertertype;

      map['type'] = Variable<String>(converter.toSql(type.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (tags.present) {
      final converter = $InboxTableTable.$convertertagsn;

      map['tags'] = Variable<String>(converter.toSql(tags.value));
    }
    if (groups.present) {
      final converter = $InboxTableTable.$convertergroupsn;

      map['groups'] = Variable<String>(converter.toSql(groups.value));
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (transformedState.present) {
      map['transformed_state'] = Variable<String>(transformedState.value);
    }
    if (stateDescription.present) {
      final converter = $InboxTableTable.$converterstateDescriptionn;

      map['state_description'] =
          Variable<String>(converter.toSql(stateDescription.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InboxTableCompanion(')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('label: $label, ')
          ..write('category: $category, ')
          ..write('tags: $tags, ')
          ..write('groups: $groups, ')
          ..write('state: $state, ')
          ..write('transformedState: $transformedState, ')
          ..write('stateDescription: $stateDescription, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, icon, color, level];
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
    context.handle(_iconMeta, const VerificationResult.success());
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
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
}

class Room extends DataClass implements Insertable<Room> {
  final int id;
  final String name;
  final String? description;
  final IconData? icon;
  final String? color;
  final int? level;
  const Room(
      {required this.id,
      required this.name,
      this.description,
      this.icon,
      this.color,
      this.level});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || icon != null) {
      final converter = $RoomsTableTable.$convertericonn;
      map['icon'] = Variable<String>(converter.toSql(icon));
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || level != null) {
      map['level'] = Variable<int>(level);
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
    };
  }

  Room copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<IconData?> icon = const Value.absent(),
          Value<String?> color = const Value.absent(),
          Value<int?> level = const Value.absent()}) =>
      Room(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        icon: icon.present ? icon.value : this.icon,
        color: color.present ? color.value : this.color,
        level: level.present ? level.value : this.level,
      );
  @override
  String toString() {
    return (StringBuffer('Room(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, icon, color, level);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Room &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.level == this.level);
}

class RoomsTableCompanion extends UpdateCompanion<Room> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<IconData?> icon;
  final Value<String?> color;
  final Value<int?> level;
  const RoomsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.level = const Value.absent(),
  });
  RoomsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.level = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Room> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<int>? level,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (level != null) 'level': level,
    });
  }

  RoomsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<IconData?>? icon,
      Value<String?>? color,
      Value<int?>? level}) {
    return RoomsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      level: level ?? this.level,
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
      final converter = $RoomsTableTable.$convertericonn;

      map['icon'] = Variable<String>(converter.toSql(icon.value));
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
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
          ..write('level: $level')
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ItemType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ItemType>($ItemsTableTable.$convertertype);
  static const VerificationMeta _ohTypeMeta = const VerificationMeta('ohType');
  @override
  late final GeneratedColumnWithTypeConverter<InboxEntryType, String> ohType =
      GeneratedColumn<String>('oh_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<InboxEntryType>($ItemsTableTable.$converterohType);
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
  static const VerificationMeta _ohTagsMeta = const VerificationMeta('ohTags');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> ohTags =
      GeneratedColumn<String>('oh_tags', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($ItemsTableTable.$converterohTagsn);
  static const VerificationMeta _ohGroupsMeta =
      const VerificationMeta('ohGroups');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> ohGroups =
      GeneratedColumn<String>('oh_groups', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($ItemsTableTable.$converterohGroupsn);
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<int> roomId = GeneratedColumn<int>(
      'room_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumnWithTypeConverter<IconData?, String> icon =
      GeneratedColumn<String>('icon', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<IconData?>($ItemsTableTable.$convertericonn);
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
  static const VerificationMeta _stateDescriptionMeta =
      const VerificationMeta('stateDescription');
  @override
  late final GeneratedColumnWithTypeConverter<StateDescription?, String>
      stateDescription = GeneratedColumn<String>(
              'state_description', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<StateDescription?>(
              $ItemsTableTable.$converterstateDescriptionn);
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
        state,
        transformedState,
        stateDescription
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
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_ohTypeMeta, const VerificationResult.success());
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
    context.handle(_ohTagsMeta, const VerificationResult.success());
    context.handle(_ohGroupsMeta, const VerificationResult.success());
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    context.handle(_iconMeta, const VerificationResult.success());
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
    context.handle(_stateDescriptionMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ohName};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      type: $ItemsTableTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
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
          .read(DriftSqlType.int, data['${effectivePrefix}room_id'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      icon: $ItemsTableTable.$convertericonn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])),
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      transformedState: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transformed_state']),
      stateDescription: $ItemsTableTable.$converterstateDescriptionn.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}state_description'])),
    );
  }

  @override
  $ItemsTableTable createAlias(String alias) {
    return $ItemsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ItemType, String, String> $convertertype =
      const EnumNameConverter<ItemType>(ItemType.values);
  static JsonTypeConverter2<InboxEntryType, String, String> $converterohType =
      const EnumNameConverter<InboxEntryType>(InboxEntryType.values);
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
  static TypeConverter<StateDescription, String> $converterstateDescription =
      const StateDescriptionConverter();
  static TypeConverter<StateDescription?, String?> $converterstateDescriptionn =
      NullAwareTypeConverter.wrap($converterstateDescription);
}

class Item extends DataClass implements Insertable<Item> {
  final ItemType type;
  final InboxEntryType ohType;
  final String ohName;
  final String ohLabel;
  final String? customLabel;
  final String? ohCategory;
  final List<String>? ohTags;
  final List<String>? ohGroups;
  final int roomId;
  final bool isFavorite;
  final IconData? icon;
  final String state;
  final String? transformedState;
  final StateDescription? stateDescription;
  const Item(
      {required this.type,
      required this.ohType,
      required this.ohName,
      required this.ohLabel,
      this.customLabel,
      this.ohCategory,
      this.ohTags,
      this.ohGroups,
      required this.roomId,
      required this.isFavorite,
      this.icon,
      required this.state,
      this.transformedState,
      this.stateDescription});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $ItemsTableTable.$convertertype;
      map['type'] = Variable<String>(converter.toSql(type));
    }
    {
      final converter = $ItemsTableTable.$converterohType;
      map['oh_type'] = Variable<String>(converter.toSql(ohType));
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
      final converter = $ItemsTableTable.$converterohTagsn;
      map['oh_tags'] = Variable<String>(converter.toSql(ohTags));
    }
    if (!nullToAbsent || ohGroups != null) {
      final converter = $ItemsTableTable.$converterohGroupsn;
      map['oh_groups'] = Variable<String>(converter.toSql(ohGroups));
    }
    map['room_id'] = Variable<int>(roomId);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || icon != null) {
      final converter = $ItemsTableTable.$convertericonn;
      map['icon'] = Variable<String>(converter.toSql(icon));
    }
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || transformedState != null) {
      map['transformed_state'] = Variable<String>(transformedState);
    }
    if (!nullToAbsent || stateDescription != null) {
      final converter = $ItemsTableTable.$converterstateDescriptionn;
      map['state_description'] =
          Variable<String>(converter.toSql(stateDescription));
    }
    return map;
  }

  ItemsTableCompanion toCompanion(bool nullToAbsent) {
    return ItemsTableCompanion(
      type: Value(type),
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
      roomId: Value(roomId),
      isFavorite: Value(isFavorite),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      state: Value(state),
      transformedState: transformedState == null && nullToAbsent
          ? const Value.absent()
          : Value(transformedState),
      stateDescription: stateDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(stateDescription),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      type: $ItemsTableTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      ohType: $ItemsTableTable.$converterohType
          .fromJson(serializer.fromJson<String>(json['ohType'])),
      ohName: serializer.fromJson<String>(json['ohName']),
      ohLabel: serializer.fromJson<String>(json['ohLabel']),
      customLabel: serializer.fromJson<String?>(json['customLabel']),
      ohCategory: serializer.fromJson<String?>(json['ohCategory']),
      ohTags: serializer.fromJson<List<String>?>(json['ohTags']),
      ohGroups: serializer.fromJson<List<String>?>(json['ohGroups']),
      roomId: serializer.fromJson<int>(json['roomId']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      icon: serializer.fromJson<IconData?>(json['icon']),
      state: serializer.fromJson<String>(json['state']),
      transformedState: serializer.fromJson<String?>(json['transformedState']),
      stateDescription:
          serializer.fromJson<StateDescription?>(json['stateDescription']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer
          .toJson<String>($ItemsTableTable.$convertertype.toJson(type)),
      'ohType': serializer
          .toJson<String>($ItemsTableTable.$converterohType.toJson(ohType)),
      'ohName': serializer.toJson<String>(ohName),
      'ohLabel': serializer.toJson<String>(ohLabel),
      'customLabel': serializer.toJson<String?>(customLabel),
      'ohCategory': serializer.toJson<String?>(ohCategory),
      'ohTags': serializer.toJson<List<String>?>(ohTags),
      'ohGroups': serializer.toJson<List<String>?>(ohGroups),
      'roomId': serializer.toJson<int>(roomId),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'icon': serializer.toJson<IconData?>(icon),
      'state': serializer.toJson<String>(state),
      'transformedState': serializer.toJson<String?>(transformedState),
      'stateDescription':
          serializer.toJson<StateDescription?>(stateDescription),
    };
  }

  Item copyWith(
          {ItemType? type,
          InboxEntryType? ohType,
          String? ohName,
          String? ohLabel,
          Value<String?> customLabel = const Value.absent(),
          Value<String?> ohCategory = const Value.absent(),
          Value<List<String>?> ohTags = const Value.absent(),
          Value<List<String>?> ohGroups = const Value.absent(),
          int? roomId,
          bool? isFavorite,
          Value<IconData?> icon = const Value.absent(),
          String? state,
          Value<String?> transformedState = const Value.absent(),
          Value<StateDescription?> stateDescription = const Value.absent()}) =>
      Item(
        type: type ?? this.type,
        ohType: ohType ?? this.ohType,
        ohName: ohName ?? this.ohName,
        ohLabel: ohLabel ?? this.ohLabel,
        customLabel: customLabel.present ? customLabel.value : this.customLabel,
        ohCategory: ohCategory.present ? ohCategory.value : this.ohCategory,
        ohTags: ohTags.present ? ohTags.value : this.ohTags,
        ohGroups: ohGroups.present ? ohGroups.value : this.ohGroups,
        roomId: roomId ?? this.roomId,
        isFavorite: isFavorite ?? this.isFavorite,
        icon: icon.present ? icon.value : this.icon,
        state: state ?? this.state,
        transformedState: transformedState.present
            ? transformedState.value
            : this.transformedState,
        stateDescription: stateDescription.present
            ? stateDescription.value
            : this.stateDescription,
      );
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
          ..write('state: $state, ')
          ..write('transformedState: $transformedState, ')
          ..write('stateDescription: $stateDescription')
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
      state,
      transformedState,
      stateDescription);
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
          other.state == this.state &&
          other.transformedState == this.transformedState &&
          other.stateDescription == this.stateDescription);
}

class ItemsTableCompanion extends UpdateCompanion<Item> {
  final Value<ItemType> type;
  final Value<InboxEntryType> ohType;
  final Value<String> ohName;
  final Value<String> ohLabel;
  final Value<String?> customLabel;
  final Value<String?> ohCategory;
  final Value<List<String>?> ohTags;
  final Value<List<String>?> ohGroups;
  final Value<int> roomId;
  final Value<bool> isFavorite;
  final Value<IconData?> icon;
  final Value<String> state;
  final Value<String?> transformedState;
  final Value<StateDescription?> stateDescription;
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
    this.state = const Value.absent(),
    this.transformedState = const Value.absent(),
    this.stateDescription = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsTableCompanion.insert({
    required ItemType type,
    required InboxEntryType ohType,
    required String ohName,
    required String ohLabel,
    this.customLabel = const Value.absent(),
    this.ohCategory = const Value.absent(),
    this.ohTags = const Value.absent(),
    this.ohGroups = const Value.absent(),
    required int roomId,
    this.isFavorite = const Value.absent(),
    this.icon = const Value.absent(),
    required String state,
    this.transformedState = const Value.absent(),
    this.stateDescription = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : type = Value(type),
        ohType = Value(ohType),
        ohName = Value(ohName),
        ohLabel = Value(ohLabel),
        roomId = Value(roomId),
        state = Value(state);
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
    Expression<String>? state,
    Expression<String>? transformedState,
    Expression<String>? stateDescription,
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
      if (state != null) 'state': state,
      if (transformedState != null) 'transformed_state': transformedState,
      if (stateDescription != null) 'state_description': stateDescription,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsTableCompanion copyWith(
      {Value<ItemType>? type,
      Value<InboxEntryType>? ohType,
      Value<String>? ohName,
      Value<String>? ohLabel,
      Value<String?>? customLabel,
      Value<String?>? ohCategory,
      Value<List<String>?>? ohTags,
      Value<List<String>?>? ohGroups,
      Value<int>? roomId,
      Value<bool>? isFavorite,
      Value<IconData?>? icon,
      Value<String>? state,
      Value<String?>? transformedState,
      Value<StateDescription?>? stateDescription,
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
      state: state ?? this.state,
      transformedState: transformedState ?? this.transformedState,
      stateDescription: stateDescription ?? this.stateDescription,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      final converter = $ItemsTableTable.$convertertype;

      map['type'] = Variable<String>(converter.toSql(type.value));
    }
    if (ohType.present) {
      final converter = $ItemsTableTable.$converterohType;

      map['oh_type'] = Variable<String>(converter.toSql(ohType.value));
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
      final converter = $ItemsTableTable.$converterohTagsn;

      map['oh_tags'] = Variable<String>(converter.toSql(ohTags.value));
    }
    if (ohGroups.present) {
      final converter = $ItemsTableTable.$converterohGroupsn;

      map['oh_groups'] = Variable<String>(converter.toSql(ohGroups.value));
    }
    if (roomId.present) {
      map['room_id'] = Variable<int>(roomId.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (icon.present) {
      final converter = $ItemsTableTable.$convertericonn;

      map['icon'] = Variable<String>(converter.toSql(icon.value));
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (transformedState.present) {
      map['transformed_state'] = Variable<String>(transformedState.value);
    }
    if (stateDescription.present) {
      final converter = $ItemsTableTable.$converterstateDescriptionn;

      map['state_description'] =
          Variable<String>(converter.toSql(stateDescription.value));
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
          ..write('state: $state, ')
          ..write('transformedState: $transformedState, ')
          ..write('stateDescription: $stateDescription, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $InboxTableTable inboxTable = $InboxTableTable(this);
  late final $RoomsTableTable roomsTable = $RoomsTableTable(this);
  late final $ItemsTableTable itemsTable = $ItemsTableTable(this);
  late final InboxStore inboxStore = InboxStore(this as AppDatabase);
  late final RoomsStore roomsStore = RoomsStore(this as AppDatabase);
  late final ItemsStore itemsStore = ItemsStore(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [inboxTable, roomsTable, itemsTable];
}
