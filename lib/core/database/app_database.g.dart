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
  @override
  List<GeneratedColumn> get $columns =>
      [type, name, label, category, tags, groups];
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
}

class InboxEntry extends DataClass implements Insertable<InboxEntry> {
  final InboxEntryType type;
  final String name;
  final String label;
  final String? category;
  final List<String>? tags;
  final List<String>? groups;
  const InboxEntry(
      {required this.type,
      required this.name,
      required this.label,
      this.category,
      this.tags,
      this.groups});
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
    };
  }

  InboxEntry copyWith(
          {InboxEntryType? type,
          String? name,
          String? label,
          Value<String?> category = const Value.absent(),
          Value<List<String>?> tags = const Value.absent(),
          Value<List<String>?> groups = const Value.absent()}) =>
      InboxEntry(
        type: type ?? this.type,
        name: name ?? this.name,
        label: label ?? this.label,
        category: category.present ? category.value : this.category,
        tags: tags.present ? tags.value : this.tags,
        groups: groups.present ? groups.value : this.groups,
      );
  @override
  String toString() {
    return (StringBuffer('InboxEntry(')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('label: $label, ')
          ..write('category: $category, ')
          ..write('tags: $tags, ')
          ..write('groups: $groups')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(type, name, label, category, tags, groups);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InboxEntry &&
          other.type == this.type &&
          other.name == this.name &&
          other.label == this.label &&
          other.category == this.category &&
          other.tags == this.tags &&
          other.groups == this.groups);
}

class InboxTableCompanion extends UpdateCompanion<InboxEntry> {
  final Value<InboxEntryType> type;
  final Value<String> name;
  final Value<String> label;
  final Value<String?> category;
  final Value<List<String>?> tags;
  final Value<List<String>?> groups;
  final Value<int> rowid;
  const InboxTableCompanion({
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.label = const Value.absent(),
    this.category = const Value.absent(),
    this.tags = const Value.absent(),
    this.groups = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InboxTableCompanion.insert({
    required InboxEntryType type,
    required String name,
    required String label,
    this.category = const Value.absent(),
    this.tags = const Value.absent(),
    this.groups = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : type = Value(type),
        name = Value(name),
        label = Value(label);
  static Insertable<InboxEntry> custom({
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? label,
    Expression<String>? category,
    Expression<String>? tags,
    Expression<String>? groups,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (label != null) 'label': label,
      if (category != null) 'category': category,
      if (tags != null) 'tags': tags,
      if (groups != null) 'groups': groups,
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
      Value<int>? rowid}) {
    return InboxTableCompanion(
      type: type ?? this.type,
      name: name ?? this.name,
      label: label ?? this.label,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      groups: groups ?? this.groups,
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
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $InboxTableTable inboxTable = $InboxTableTable(this);
  late final InboxStore inboxStore = InboxStore(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [inboxTable];
}
