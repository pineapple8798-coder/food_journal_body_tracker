// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MealRecordsTable extends MealRecords
    with TableInfo<$MealRecordsTable, MealRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    mealType,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MealRecordsTable createAlias(String alias) {
    return $MealRecordsTable(attachedDatabase, alias);
  }
}

class MealRecord extends DataClass implements Insertable<MealRecord> {
  final String id;
  final String date;
  final String mealType;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MealRecord({
    required this.id,
    required this.date,
    required this.mealType,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['meal_type'] = Variable<String>(mealType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MealRecordsCompanion toCompanion(bool nullToAbsent) {
    return MealRecordsCompanion(
      id: Value(id),
      date: Value(date),
      mealType: Value(mealType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MealRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealRecord(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      mealType: serializer.fromJson<String>(json['mealType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'mealType': serializer.toJson<String>(mealType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MealRecord copyWith({
    String? id,
    String? date,
    String? mealType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MealRecord(
    id: id ?? this.id,
    date: date ?? this.date,
    mealType: mealType ?? this.mealType,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MealRecord copyWithCompanion(MealRecordsCompanion data) {
    return MealRecord(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealRecord(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('mealType: $mealType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, mealType, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealRecord &&
          other.id == this.id &&
          other.date == this.date &&
          other.mealType == this.mealType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MealRecordsCompanion extends UpdateCompanion<MealRecord> {
  final Value<String> id;
  final Value<String> date;
  final Value<String> mealType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MealRecordsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.mealType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealRecordsCompanion.insert({
    required String id,
    required String date,
    required String mealType,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       mealType = Value(mealType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MealRecord> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? mealType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (mealType != null) 'meal_type': mealType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? date,
    Value<String>? mealType,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MealRecordsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealRecordsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('mealType: $mealType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodItemsTable extends FoodItems
    with TableInfo<$FoodItemsTable, FoodItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealRecordIdMeta = const VerificationMeta(
    'mealRecordId',
  );
  @override
  late final GeneratedColumn<String> mealRecordId = GeneratedColumn<String>(
    'meal_record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_records (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _aiRecognizedMeta = const VerificationMeta(
    'aiRecognized',
  );
  @override
  late final GeneratedColumn<bool> aiRecognized = GeneratedColumn<bool>(
    'ai_recognized',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ai_recognized" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _aiConfidenceMeta = const VerificationMeta(
    'aiConfidence',
  );
  @override
  late final GeneratedColumn<double> aiConfidence = GeneratedColumn<double>(
    'ai_confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealRecordId,
    imagePath,
    name,
    comment,
    aiRecognized,
    aiConfidence,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('meal_record_id')) {
      context.handle(
        _mealRecordIdMeta,
        mealRecordId.isAcceptableOrUnknown(
          data['meal_record_id']!,
          _mealRecordIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mealRecordIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('ai_recognized')) {
      context.handle(
        _aiRecognizedMeta,
        aiRecognized.isAcceptableOrUnknown(
          data['ai_recognized']!,
          _aiRecognizedMeta,
        ),
      );
    }
    if (data.containsKey('ai_confidence')) {
      context.handle(
        _aiConfidenceMeta,
        aiConfidence.isAcceptableOrUnknown(
          data['ai_confidence']!,
          _aiConfidenceMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mealRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_record_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
      aiRecognized: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ai_recognized'],
      )!,
      aiConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ai_confidence'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FoodItemsTable createAlias(String alias) {
    return $FoodItemsTable(attachedDatabase, alias);
  }
}

class FoodItem extends DataClass implements Insertable<FoodItem> {
  final String id;
  final String mealRecordId;
  final String imagePath;
  final String name;
  final String comment;
  final bool aiRecognized;
  final double? aiConfidence;
  final DateTime createdAt;
  const FoodItem({
    required this.id,
    required this.mealRecordId,
    required this.imagePath,
    required this.name,
    required this.comment,
    required this.aiRecognized,
    this.aiConfidence,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['meal_record_id'] = Variable<String>(mealRecordId);
    map['image_path'] = Variable<String>(imagePath);
    map['name'] = Variable<String>(name);
    map['comment'] = Variable<String>(comment);
    map['ai_recognized'] = Variable<bool>(aiRecognized);
    if (!nullToAbsent || aiConfidence != null) {
      map['ai_confidence'] = Variable<double>(aiConfidence);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FoodItemsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemsCompanion(
      id: Value(id),
      mealRecordId: Value(mealRecordId),
      imagePath: Value(imagePath),
      name: Value(name),
      comment: Value(comment),
      aiRecognized: Value(aiRecognized),
      aiConfidence: aiConfidence == null && nullToAbsent
          ? const Value.absent()
          : Value(aiConfidence),
      createdAt: Value(createdAt),
    );
  }

  factory FoodItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItem(
      id: serializer.fromJson<String>(json['id']),
      mealRecordId: serializer.fromJson<String>(json['mealRecordId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      name: serializer.fromJson<String>(json['name']),
      comment: serializer.fromJson<String>(json['comment']),
      aiRecognized: serializer.fromJson<bool>(json['aiRecognized']),
      aiConfidence: serializer.fromJson<double?>(json['aiConfidence']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mealRecordId': serializer.toJson<String>(mealRecordId),
      'imagePath': serializer.toJson<String>(imagePath),
      'name': serializer.toJson<String>(name),
      'comment': serializer.toJson<String>(comment),
      'aiRecognized': serializer.toJson<bool>(aiRecognized),
      'aiConfidence': serializer.toJson<double?>(aiConfidence),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FoodItem copyWith({
    String? id,
    String? mealRecordId,
    String? imagePath,
    String? name,
    String? comment,
    bool? aiRecognized,
    Value<double?> aiConfidence = const Value.absent(),
    DateTime? createdAt,
  }) => FoodItem(
    id: id ?? this.id,
    mealRecordId: mealRecordId ?? this.mealRecordId,
    imagePath: imagePath ?? this.imagePath,
    name: name ?? this.name,
    comment: comment ?? this.comment,
    aiRecognized: aiRecognized ?? this.aiRecognized,
    aiConfidence: aiConfidence.present ? aiConfidence.value : this.aiConfidence,
    createdAt: createdAt ?? this.createdAt,
  );
  FoodItem copyWithCompanion(FoodItemsCompanion data) {
    return FoodItem(
      id: data.id.present ? data.id.value : this.id,
      mealRecordId: data.mealRecordId.present
          ? data.mealRecordId.value
          : this.mealRecordId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      name: data.name.present ? data.name.value : this.name,
      comment: data.comment.present ? data.comment.value : this.comment,
      aiRecognized: data.aiRecognized.present
          ? data.aiRecognized.value
          : this.aiRecognized,
      aiConfidence: data.aiConfidence.present
          ? data.aiConfidence.value
          : this.aiConfidence,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItem(')
          ..write('id: $id, ')
          ..write('mealRecordId: $mealRecordId, ')
          ..write('imagePath: $imagePath, ')
          ..write('name: $name, ')
          ..write('comment: $comment, ')
          ..write('aiRecognized: $aiRecognized, ')
          ..write('aiConfidence: $aiConfidence, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mealRecordId,
    imagePath,
    name,
    comment,
    aiRecognized,
    aiConfidence,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItem &&
          other.id == this.id &&
          other.mealRecordId == this.mealRecordId &&
          other.imagePath == this.imagePath &&
          other.name == this.name &&
          other.comment == this.comment &&
          other.aiRecognized == this.aiRecognized &&
          other.aiConfidence == this.aiConfidence &&
          other.createdAt == this.createdAt);
}

class FoodItemsCompanion extends UpdateCompanion<FoodItem> {
  final Value<String> id;
  final Value<String> mealRecordId;
  final Value<String> imagePath;
  final Value<String> name;
  final Value<String> comment;
  final Value<bool> aiRecognized;
  final Value<double?> aiConfidence;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FoodItemsCompanion({
    this.id = const Value.absent(),
    this.mealRecordId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.name = const Value.absent(),
    this.comment = const Value.absent(),
    this.aiRecognized = const Value.absent(),
    this.aiConfidence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodItemsCompanion.insert({
    required String id,
    required String mealRecordId,
    required String imagePath,
    required String name,
    this.comment = const Value.absent(),
    this.aiRecognized = const Value.absent(),
    this.aiConfidence = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mealRecordId = Value(mealRecordId),
       imagePath = Value(imagePath),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<FoodItem> custom({
    Expression<String>? id,
    Expression<String>? mealRecordId,
    Expression<String>? imagePath,
    Expression<String>? name,
    Expression<String>? comment,
    Expression<bool>? aiRecognized,
    Expression<double>? aiConfidence,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealRecordId != null) 'meal_record_id': mealRecordId,
      if (imagePath != null) 'image_path': imagePath,
      if (name != null) 'name': name,
      if (comment != null) 'comment': comment,
      if (aiRecognized != null) 'ai_recognized': aiRecognized,
      if (aiConfidence != null) 'ai_confidence': aiConfidence,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? mealRecordId,
    Value<String>? imagePath,
    Value<String>? name,
    Value<String>? comment,
    Value<bool>? aiRecognized,
    Value<double?>? aiConfidence,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FoodItemsCompanion(
      id: id ?? this.id,
      mealRecordId: mealRecordId ?? this.mealRecordId,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      comment: comment ?? this.comment,
      aiRecognized: aiRecognized ?? this.aiRecognized,
      aiConfidence: aiConfidence ?? this.aiConfidence,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mealRecordId.present) {
      map['meal_record_id'] = Variable<String>(mealRecordId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (aiRecognized.present) {
      map['ai_recognized'] = Variable<bool>(aiRecognized.value);
    }
    if (aiConfidence.present) {
      map['ai_confidence'] = Variable<double>(aiConfidence.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemsCompanion(')
          ..write('id: $id, ')
          ..write('mealRecordId: $mealRecordId, ')
          ..write('imagePath: $imagePath, ')
          ..write('name: $name, ')
          ..write('comment: $comment, ')
          ..write('aiRecognized: $aiRecognized, ')
          ..write('aiConfidence: $aiConfidence, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BodyFeedbacksTable extends BodyFeedbacks
    with TableInfo<$BodyFeedbacksTable, BodyFeedback> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyFeedbacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _energyScoreMeta = const VerificationMeta(
    'energyScore',
  );
  @override
  late final GeneratedColumn<int> energyScore = GeneratedColumn<int>(
    'energy_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _digestionScoreMeta = const VerificationMeta(
    'digestionScore',
  );
  @override
  late final GeneratedColumn<int> digestionScore = GeneratedColumn<int>(
    'digestion_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepScoreMeta = const VerificationMeta(
    'sleepScore',
  );
  @override
  late final GeneratedColumn<int> sleepScore = GeneratedColumn<int>(
    'sleep_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stomachScoreMeta = const VerificationMeta(
    'stomachScore',
  );
  @override
  late final GeneratedColumn<int> stomachScore = GeneratedColumn<int>(
    'stomach_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skinScoreMeta = const VerificationMeta(
    'skinScore',
  );
  @override
  late final GeneratedColumn<int> skinScore = GeneratedColumn<int>(
    'skin_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    energyScore,
    digestionScore,
    sleepScore,
    stomachScore,
    skinScore,
    weight,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_feedbacks';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyFeedback> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('energy_score')) {
      context.handle(
        _energyScoreMeta,
        energyScore.isAcceptableOrUnknown(
          data['energy_score']!,
          _energyScoreMeta,
        ),
      );
    }
    if (data.containsKey('digestion_score')) {
      context.handle(
        _digestionScoreMeta,
        digestionScore.isAcceptableOrUnknown(
          data['digestion_score']!,
          _digestionScoreMeta,
        ),
      );
    }
    if (data.containsKey('sleep_score')) {
      context.handle(
        _sleepScoreMeta,
        sleepScore.isAcceptableOrUnknown(data['sleep_score']!, _sleepScoreMeta),
      );
    }
    if (data.containsKey('stomach_score')) {
      context.handle(
        _stomachScoreMeta,
        stomachScore.isAcceptableOrUnknown(
          data['stomach_score']!,
          _stomachScoreMeta,
        ),
      );
    }
    if (data.containsKey('skin_score')) {
      context.handle(
        _skinScoreMeta,
        skinScore.isAcceptableOrUnknown(data['skin_score']!, _skinScoreMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyFeedback map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyFeedback(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      energyScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_score'],
      ),
      digestionScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}digestion_score'],
      ),
      sleepScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_score'],
      ),
      stomachScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stomach_score'],
      ),
      skinScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skin_score'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BodyFeedbacksTable createAlias(String alias) {
    return $BodyFeedbacksTable(attachedDatabase, alias);
  }
}

class BodyFeedback extends DataClass implements Insertable<BodyFeedback> {
  final String id;
  final String date;
  final int? energyScore;
  final int? digestionScore;
  final int? sleepScore;
  final int? stomachScore;
  final int? skinScore;
  final double? weight;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BodyFeedback({
    required this.id,
    required this.date,
    this.energyScore,
    this.digestionScore,
    this.sleepScore,
    this.stomachScore,
    this.skinScore,
    this.weight,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || energyScore != null) {
      map['energy_score'] = Variable<int>(energyScore);
    }
    if (!nullToAbsent || digestionScore != null) {
      map['digestion_score'] = Variable<int>(digestionScore);
    }
    if (!nullToAbsent || sleepScore != null) {
      map['sleep_score'] = Variable<int>(sleepScore);
    }
    if (!nullToAbsent || stomachScore != null) {
      map['stomach_score'] = Variable<int>(stomachScore);
    }
    if (!nullToAbsent || skinScore != null) {
      map['skin_score'] = Variable<int>(skinScore);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    map['note'] = Variable<String>(note);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BodyFeedbacksCompanion toCompanion(bool nullToAbsent) {
    return BodyFeedbacksCompanion(
      id: Value(id),
      date: Value(date),
      energyScore: energyScore == null && nullToAbsent
          ? const Value.absent()
          : Value(energyScore),
      digestionScore: digestionScore == null && nullToAbsent
          ? const Value.absent()
          : Value(digestionScore),
      sleepScore: sleepScore == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepScore),
      stomachScore: stomachScore == null && nullToAbsent
          ? const Value.absent()
          : Value(stomachScore),
      skinScore: skinScore == null && nullToAbsent
          ? const Value.absent()
          : Value(skinScore),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      note: Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BodyFeedback.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyFeedback(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      energyScore: serializer.fromJson<int?>(json['energyScore']),
      digestionScore: serializer.fromJson<int?>(json['digestionScore']),
      sleepScore: serializer.fromJson<int?>(json['sleepScore']),
      stomachScore: serializer.fromJson<int?>(json['stomachScore']),
      skinScore: serializer.fromJson<int?>(json['skinScore']),
      weight: serializer.fromJson<double?>(json['weight']),
      note: serializer.fromJson<String>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'energyScore': serializer.toJson<int?>(energyScore),
      'digestionScore': serializer.toJson<int?>(digestionScore),
      'sleepScore': serializer.toJson<int?>(sleepScore),
      'stomachScore': serializer.toJson<int?>(stomachScore),
      'skinScore': serializer.toJson<int?>(skinScore),
      'weight': serializer.toJson<double?>(weight),
      'note': serializer.toJson<String>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BodyFeedback copyWith({
    String? id,
    String? date,
    Value<int?> energyScore = const Value.absent(),
    Value<int?> digestionScore = const Value.absent(),
    Value<int?> sleepScore = const Value.absent(),
    Value<int?> stomachScore = const Value.absent(),
    Value<int?> skinScore = const Value.absent(),
    Value<double?> weight = const Value.absent(),
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BodyFeedback(
    id: id ?? this.id,
    date: date ?? this.date,
    energyScore: energyScore.present ? energyScore.value : this.energyScore,
    digestionScore: digestionScore.present
        ? digestionScore.value
        : this.digestionScore,
    sleepScore: sleepScore.present ? sleepScore.value : this.sleepScore,
    stomachScore: stomachScore.present ? stomachScore.value : this.stomachScore,
    skinScore: skinScore.present ? skinScore.value : this.skinScore,
    weight: weight.present ? weight.value : this.weight,
    note: note ?? this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BodyFeedback copyWithCompanion(BodyFeedbacksCompanion data) {
    return BodyFeedback(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      energyScore: data.energyScore.present
          ? data.energyScore.value
          : this.energyScore,
      digestionScore: data.digestionScore.present
          ? data.digestionScore.value
          : this.digestionScore,
      sleepScore: data.sleepScore.present
          ? data.sleepScore.value
          : this.sleepScore,
      stomachScore: data.stomachScore.present
          ? data.stomachScore.value
          : this.stomachScore,
      skinScore: data.skinScore.present ? data.skinScore.value : this.skinScore,
      weight: data.weight.present ? data.weight.value : this.weight,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyFeedback(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('energyScore: $energyScore, ')
          ..write('digestionScore: $digestionScore, ')
          ..write('sleepScore: $sleepScore, ')
          ..write('stomachScore: $stomachScore, ')
          ..write('skinScore: $skinScore, ')
          ..write('weight: $weight, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    energyScore,
    digestionScore,
    sleepScore,
    stomachScore,
    skinScore,
    weight,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyFeedback &&
          other.id == this.id &&
          other.date == this.date &&
          other.energyScore == this.energyScore &&
          other.digestionScore == this.digestionScore &&
          other.sleepScore == this.sleepScore &&
          other.stomachScore == this.stomachScore &&
          other.skinScore == this.skinScore &&
          other.weight == this.weight &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BodyFeedbacksCompanion extends UpdateCompanion<BodyFeedback> {
  final Value<String> id;
  final Value<String> date;
  final Value<int?> energyScore;
  final Value<int?> digestionScore;
  final Value<int?> sleepScore;
  final Value<int?> stomachScore;
  final Value<int?> skinScore;
  final Value<double?> weight;
  final Value<String> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BodyFeedbacksCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.energyScore = const Value.absent(),
    this.digestionScore = const Value.absent(),
    this.sleepScore = const Value.absent(),
    this.stomachScore = const Value.absent(),
    this.skinScore = const Value.absent(),
    this.weight = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BodyFeedbacksCompanion.insert({
    required String id,
    required String date,
    this.energyScore = const Value.absent(),
    this.digestionScore = const Value.absent(),
    this.sleepScore = const Value.absent(),
    this.stomachScore = const Value.absent(),
    this.skinScore = const Value.absent(),
    this.weight = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BodyFeedback> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<int>? energyScore,
    Expression<int>? digestionScore,
    Expression<int>? sleepScore,
    Expression<int>? stomachScore,
    Expression<int>? skinScore,
    Expression<double>? weight,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (energyScore != null) 'energy_score': energyScore,
      if (digestionScore != null) 'digestion_score': digestionScore,
      if (sleepScore != null) 'sleep_score': sleepScore,
      if (stomachScore != null) 'stomach_score': stomachScore,
      if (skinScore != null) 'skin_score': skinScore,
      if (weight != null) 'weight': weight,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BodyFeedbacksCompanion copyWith({
    Value<String>? id,
    Value<String>? date,
    Value<int?>? energyScore,
    Value<int?>? digestionScore,
    Value<int?>? sleepScore,
    Value<int?>? stomachScore,
    Value<int?>? skinScore,
    Value<double?>? weight,
    Value<String>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BodyFeedbacksCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      energyScore: energyScore ?? this.energyScore,
      digestionScore: digestionScore ?? this.digestionScore,
      sleepScore: sleepScore ?? this.sleepScore,
      stomachScore: stomachScore ?? this.stomachScore,
      skinScore: skinScore ?? this.skinScore,
      weight: weight ?? this.weight,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (energyScore.present) {
      map['energy_score'] = Variable<int>(energyScore.value);
    }
    if (digestionScore.present) {
      map['digestion_score'] = Variable<int>(digestionScore.value);
    }
    if (sleepScore.present) {
      map['sleep_score'] = Variable<int>(sleepScore.value);
    }
    if (stomachScore.present) {
      map['stomach_score'] = Variable<int>(stomachScore.value);
    }
    if (skinScore.present) {
      map['skin_score'] = Variable<int>(skinScore.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyFeedbacksCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('energyScore: $energyScore, ')
          ..write('digestionScore: $digestionScore, ')
          ..write('sleepScore: $sleepScore, ')
          ..write('stomachScore: $stomachScore, ')
          ..write('skinScore: $skinScore, ')
          ..write('weight: $weight, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GutSymptomsTable extends GutSymptoms
    with TableInfo<$GutSymptomsTable, GutSymptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GutSymptomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedbackIdMeta = const VerificationMeta(
    'feedbackId',
  );
  @override
  late final GeneratedColumn<String> feedbackId = GeneratedColumn<String>(
    'feedback_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES body_feedbacks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, feedbackId, type, severity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gut_symptoms';
  @override
  VerificationContext validateIntegrity(
    Insertable<GutSymptom> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feedback_id')) {
      context.handle(
        _feedbackIdMeta,
        feedbackId.isAcceptableOrUnknown(data['feedback_id']!, _feedbackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_feedbackIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GutSymptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GutSymptom(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      feedbackId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feedback_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
    );
  }

  @override
  $GutSymptomsTable createAlias(String alias) {
    return $GutSymptomsTable(attachedDatabase, alias);
  }
}

class GutSymptom extends DataClass implements Insertable<GutSymptom> {
  final String id;
  final String feedbackId;
  final String type;
  final String severity;
  const GutSymptom({
    required this.id,
    required this.feedbackId,
    required this.type,
    required this.severity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feedback_id'] = Variable<String>(feedbackId);
    map['type'] = Variable<String>(type);
    map['severity'] = Variable<String>(severity);
    return map;
  }

  GutSymptomsCompanion toCompanion(bool nullToAbsent) {
    return GutSymptomsCompanion(
      id: Value(id),
      feedbackId: Value(feedbackId),
      type: Value(type),
      severity: Value(severity),
    );
  }

  factory GutSymptom.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GutSymptom(
      id: serializer.fromJson<String>(json['id']),
      feedbackId: serializer.fromJson<String>(json['feedbackId']),
      type: serializer.fromJson<String>(json['type']),
      severity: serializer.fromJson<String>(json['severity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'feedbackId': serializer.toJson<String>(feedbackId),
      'type': serializer.toJson<String>(type),
      'severity': serializer.toJson<String>(severity),
    };
  }

  GutSymptom copyWith({
    String? id,
    String? feedbackId,
    String? type,
    String? severity,
  }) => GutSymptom(
    id: id ?? this.id,
    feedbackId: feedbackId ?? this.feedbackId,
    type: type ?? this.type,
    severity: severity ?? this.severity,
  );
  GutSymptom copyWithCompanion(GutSymptomsCompanion data) {
    return GutSymptom(
      id: data.id.present ? data.id.value : this.id,
      feedbackId: data.feedbackId.present
          ? data.feedbackId.value
          : this.feedbackId,
      type: data.type.present ? data.type.value : this.type,
      severity: data.severity.present ? data.severity.value : this.severity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GutSymptom(')
          ..write('id: $id, ')
          ..write('feedbackId: $feedbackId, ')
          ..write('type: $type, ')
          ..write('severity: $severity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, feedbackId, type, severity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GutSymptom &&
          other.id == this.id &&
          other.feedbackId == this.feedbackId &&
          other.type == this.type &&
          other.severity == this.severity);
}

class GutSymptomsCompanion extends UpdateCompanion<GutSymptom> {
  final Value<String> id;
  final Value<String> feedbackId;
  final Value<String> type;
  final Value<String> severity;
  final Value<int> rowid;
  const GutSymptomsCompanion({
    this.id = const Value.absent(),
    this.feedbackId = const Value.absent(),
    this.type = const Value.absent(),
    this.severity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GutSymptomsCompanion.insert({
    required String id,
    required String feedbackId,
    required String type,
    required String severity,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       feedbackId = Value(feedbackId),
       type = Value(type),
       severity = Value(severity);
  static Insertable<GutSymptom> custom({
    Expression<String>? id,
    Expression<String>? feedbackId,
    Expression<String>? type,
    Expression<String>? severity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (feedbackId != null) 'feedback_id': feedbackId,
      if (type != null) 'type': type,
      if (severity != null) 'severity': severity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GutSymptomsCompanion copyWith({
    Value<String>? id,
    Value<String>? feedbackId,
    Value<String>? type,
    Value<String>? severity,
    Value<int>? rowid,
  }) {
    return GutSymptomsCompanion(
      id: id ?? this.id,
      feedbackId: feedbackId ?? this.feedbackId,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (feedbackId.present) {
      map['feedback_id'] = Variable<String>(feedbackId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GutSymptomsCompanion(')
          ..write('id: $id, ')
          ..write('feedbackId: $feedbackId, ')
          ..write('type: $type, ')
          ..write('severity: $severity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AdviceRecordsTable extends AdviceRecords
    with TableInfo<$AdviceRecordsTable, AdviceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdviceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queryTextMeta = const VerificationMeta(
    'queryText',
  );
  @override
  late final GeneratedColumn<String> queryText = GeneratedColumn<String>(
    'query_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queryImagePathMeta = const VerificationMeta(
    'queryImagePath',
  );
  @override
  late final GeneratedColumn<String> queryImagePath = GeneratedColumn<String>(
    'query_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conclusionMeta = const VerificationMeta(
    'conclusion',
  );
  @override
  late final GeneratedColumn<String> conclusion = GeneratedColumn<String>(
    'conclusion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskFactorsMeta = const VerificationMeta(
    'riskFactors',
  );
  @override
  late final GeneratedColumn<String> riskFactors = GeneratedColumn<String>(
    'risk_factors',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    queryText,
    queryImagePath,
    conclusion,
    reason,
    riskFactors,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'advice_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdviceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('query_text')) {
      context.handle(
        _queryTextMeta,
        queryText.isAcceptableOrUnknown(data['query_text']!, _queryTextMeta),
      );
    } else if (isInserting) {
      context.missing(_queryTextMeta);
    }
    if (data.containsKey('query_image_path')) {
      context.handle(
        _queryImagePathMeta,
        queryImagePath.isAcceptableOrUnknown(
          data['query_image_path']!,
          _queryImagePathMeta,
        ),
      );
    }
    if (data.containsKey('conclusion')) {
      context.handle(
        _conclusionMeta,
        conclusion.isAcceptableOrUnknown(data['conclusion']!, _conclusionMeta),
      );
    } else if (isInserting) {
      context.missing(_conclusionMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('risk_factors')) {
      context.handle(
        _riskFactorsMeta,
        riskFactors.isAcceptableOrUnknown(
          data['risk_factors']!,
          _riskFactorsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AdviceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdviceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      queryText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}query_text'],
      )!,
      queryImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}query_image_path'],
      ),
      conclusion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conclusion'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      riskFactors: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_factors'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AdviceRecordsTable createAlias(String alias) {
    return $AdviceRecordsTable(attachedDatabase, alias);
  }
}

class AdviceRecord extends DataClass implements Insertable<AdviceRecord> {
  final String id;
  final String queryText;
  final String? queryImagePath;
  final String conclusion;
  final String reason;
  final String riskFactors;
  final DateTime createdAt;
  const AdviceRecord({
    required this.id,
    required this.queryText,
    this.queryImagePath,
    required this.conclusion,
    required this.reason,
    required this.riskFactors,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['query_text'] = Variable<String>(queryText);
    if (!nullToAbsent || queryImagePath != null) {
      map['query_image_path'] = Variable<String>(queryImagePath);
    }
    map['conclusion'] = Variable<String>(conclusion);
    map['reason'] = Variable<String>(reason);
    map['risk_factors'] = Variable<String>(riskFactors);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AdviceRecordsCompanion toCompanion(bool nullToAbsent) {
    return AdviceRecordsCompanion(
      id: Value(id),
      queryText: Value(queryText),
      queryImagePath: queryImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(queryImagePath),
      conclusion: Value(conclusion),
      reason: Value(reason),
      riskFactors: Value(riskFactors),
      createdAt: Value(createdAt),
    );
  }

  factory AdviceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdviceRecord(
      id: serializer.fromJson<String>(json['id']),
      queryText: serializer.fromJson<String>(json['queryText']),
      queryImagePath: serializer.fromJson<String?>(json['queryImagePath']),
      conclusion: serializer.fromJson<String>(json['conclusion']),
      reason: serializer.fromJson<String>(json['reason']),
      riskFactors: serializer.fromJson<String>(json['riskFactors']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'queryText': serializer.toJson<String>(queryText),
      'queryImagePath': serializer.toJson<String?>(queryImagePath),
      'conclusion': serializer.toJson<String>(conclusion),
      'reason': serializer.toJson<String>(reason),
      'riskFactors': serializer.toJson<String>(riskFactors),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AdviceRecord copyWith({
    String? id,
    String? queryText,
    Value<String?> queryImagePath = const Value.absent(),
    String? conclusion,
    String? reason,
    String? riskFactors,
    DateTime? createdAt,
  }) => AdviceRecord(
    id: id ?? this.id,
    queryText: queryText ?? this.queryText,
    queryImagePath: queryImagePath.present
        ? queryImagePath.value
        : this.queryImagePath,
    conclusion: conclusion ?? this.conclusion,
    reason: reason ?? this.reason,
    riskFactors: riskFactors ?? this.riskFactors,
    createdAt: createdAt ?? this.createdAt,
  );
  AdviceRecord copyWithCompanion(AdviceRecordsCompanion data) {
    return AdviceRecord(
      id: data.id.present ? data.id.value : this.id,
      queryText: data.queryText.present ? data.queryText.value : this.queryText,
      queryImagePath: data.queryImagePath.present
          ? data.queryImagePath.value
          : this.queryImagePath,
      conclusion: data.conclusion.present
          ? data.conclusion.value
          : this.conclusion,
      reason: data.reason.present ? data.reason.value : this.reason,
      riskFactors: data.riskFactors.present
          ? data.riskFactors.value
          : this.riskFactors,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdviceRecord(')
          ..write('id: $id, ')
          ..write('queryText: $queryText, ')
          ..write('queryImagePath: $queryImagePath, ')
          ..write('conclusion: $conclusion, ')
          ..write('reason: $reason, ')
          ..write('riskFactors: $riskFactors, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    queryText,
    queryImagePath,
    conclusion,
    reason,
    riskFactors,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdviceRecord &&
          other.id == this.id &&
          other.queryText == this.queryText &&
          other.queryImagePath == this.queryImagePath &&
          other.conclusion == this.conclusion &&
          other.reason == this.reason &&
          other.riskFactors == this.riskFactors &&
          other.createdAt == this.createdAt);
}

class AdviceRecordsCompanion extends UpdateCompanion<AdviceRecord> {
  final Value<String> id;
  final Value<String> queryText;
  final Value<String?> queryImagePath;
  final Value<String> conclusion;
  final Value<String> reason;
  final Value<String> riskFactors;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AdviceRecordsCompanion({
    this.id = const Value.absent(),
    this.queryText = const Value.absent(),
    this.queryImagePath = const Value.absent(),
    this.conclusion = const Value.absent(),
    this.reason = const Value.absent(),
    this.riskFactors = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AdviceRecordsCompanion.insert({
    required String id,
    required String queryText,
    this.queryImagePath = const Value.absent(),
    required String conclusion,
    required String reason,
    this.riskFactors = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       queryText = Value(queryText),
       conclusion = Value(conclusion),
       reason = Value(reason),
       createdAt = Value(createdAt);
  static Insertable<AdviceRecord> custom({
    Expression<String>? id,
    Expression<String>? queryText,
    Expression<String>? queryImagePath,
    Expression<String>? conclusion,
    Expression<String>? reason,
    Expression<String>? riskFactors,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (queryText != null) 'query_text': queryText,
      if (queryImagePath != null) 'query_image_path': queryImagePath,
      if (conclusion != null) 'conclusion': conclusion,
      if (reason != null) 'reason': reason,
      if (riskFactors != null) 'risk_factors': riskFactors,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AdviceRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? queryText,
    Value<String?>? queryImagePath,
    Value<String>? conclusion,
    Value<String>? reason,
    Value<String>? riskFactors,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AdviceRecordsCompanion(
      id: id ?? this.id,
      queryText: queryText ?? this.queryText,
      queryImagePath: queryImagePath ?? this.queryImagePath,
      conclusion: conclusion ?? this.conclusion,
      reason: reason ?? this.reason,
      riskFactors: riskFactors ?? this.riskFactors,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (queryText.present) {
      map['query_text'] = Variable<String>(queryText.value);
    }
    if (queryImagePath.present) {
      map['query_image_path'] = Variable<String>(queryImagePath.value);
    }
    if (conclusion.present) {
      map['conclusion'] = Variable<String>(conclusion.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (riskFactors.present) {
      map['risk_factors'] = Variable<String>(riskFactors.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdviceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('queryText: $queryText, ')
          ..write('queryImagePath: $queryImagePath, ')
          ..write('conclusion: $conclusion, ')
          ..write('reason: $reason, ')
          ..write('riskFactors: $riskFactors, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MealRecordsTable mealRecords = $MealRecordsTable(this);
  late final $FoodItemsTable foodItems = $FoodItemsTable(this);
  late final $BodyFeedbacksTable bodyFeedbacks = $BodyFeedbacksTable(this);
  late final $GutSymptomsTable gutSymptoms = $GutSymptomsTable(this);
  late final $AdviceRecordsTable adviceRecords = $AdviceRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    mealRecords,
    foodItems,
    bodyFeedbacks,
    gutSymptoms,
    adviceRecords,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('food_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'body_feedbacks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('gut_symptoms', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MealRecordsTableCreateCompanionBuilder =
    MealRecordsCompanion Function({
      required String id,
      required String date,
      required String mealType,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MealRecordsTableUpdateCompanionBuilder =
    MealRecordsCompanion Function({
      Value<String> id,
      Value<String> date,
      Value<String> mealType,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MealRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $MealRecordsTable, MealRecord> {
  $$MealRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FoodItemsTable, List<FoodItem>>
  _foodItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.foodItems,
    aliasName: $_aliasNameGenerator(
      db.mealRecords.id,
      db.foodItems.mealRecordId,
    ),
  );

  $$FoodItemsTableProcessedTableManager get foodItemsRefs {
    final manager = $$FoodItemsTableTableManager(
      $_db,
      $_db.foodItems,
    ).filter((f) => f.mealRecordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_foodItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MealRecordsTable> {
  $$MealRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> foodItemsRefs(
    Expression<bool> Function($$FoodItemsTableFilterComposer f) f,
  ) {
    final $$FoodItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.mealRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableFilterComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealRecordsTable> {
  $$MealRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealRecordsTable> {
  $$MealRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> foodItemsRefs<T extends Object>(
    Expression<T> Function($$FoodItemsTableAnnotationComposer a) f,
  ) {
    final $$FoodItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.mealRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealRecordsTable,
          MealRecord,
          $$MealRecordsTableFilterComposer,
          $$MealRecordsTableOrderingComposer,
          $$MealRecordsTableAnnotationComposer,
          $$MealRecordsTableCreateCompanionBuilder,
          $$MealRecordsTableUpdateCompanionBuilder,
          (MealRecord, $$MealRecordsTableReferences),
          MealRecord,
          PrefetchHooks Function({bool foodItemsRefs})
        > {
  $$MealRecordsTableTableManager(_$AppDatabase db, $MealRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealRecordsCompanion(
                id: id,
                date: date,
                mealType: mealType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String date,
                required String mealType,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MealRecordsCompanion.insert(
                id: id,
                date: date,
                mealType: mealType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (foodItemsRefs) db.foodItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (foodItemsRefs)
                    await $_getPrefetchedData<
                      MealRecord,
                      $MealRecordsTable,
                      FoodItem
                    >(
                      currentTable: table,
                      referencedTable: $$MealRecordsTableReferences
                          ._foodItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MealRecordsTableReferences(
                            db,
                            table,
                            p0,
                          ).foodItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.mealRecordId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealRecordsTable,
      MealRecord,
      $$MealRecordsTableFilterComposer,
      $$MealRecordsTableOrderingComposer,
      $$MealRecordsTableAnnotationComposer,
      $$MealRecordsTableCreateCompanionBuilder,
      $$MealRecordsTableUpdateCompanionBuilder,
      (MealRecord, $$MealRecordsTableReferences),
      MealRecord,
      PrefetchHooks Function({bool foodItemsRefs})
    >;
typedef $$FoodItemsTableCreateCompanionBuilder =
    FoodItemsCompanion Function({
      required String id,
      required String mealRecordId,
      required String imagePath,
      required String name,
      Value<String> comment,
      Value<bool> aiRecognized,
      Value<double?> aiConfidence,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$FoodItemsTableUpdateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<String> id,
      Value<String> mealRecordId,
      Value<String> imagePath,
      Value<String> name,
      Value<String> comment,
      Value<bool> aiRecognized,
      Value<double?> aiConfidence,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$FoodItemsTableReferences
    extends BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem> {
  $$FoodItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MealRecordsTable _mealRecordIdTable(_$AppDatabase db) =>
      db.mealRecords.createAlias(
        $_aliasNameGenerator(db.foodItems.mealRecordId, db.mealRecords.id),
      );

  $$MealRecordsTableProcessedTableManager get mealRecordId {
    final $_column = $_itemColumn<String>('meal_record_id')!;

    final manager = $$MealRecordsTableTableManager(
      $_db,
      $_db.mealRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FoodItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aiRecognized => $composableBuilder(
    column: $table.aiRecognized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MealRecordsTableFilterComposer get mealRecordId {
    final $$MealRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealRecordId,
      referencedTable: $db.mealRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealRecordsTableFilterComposer(
            $db: $db,
            $table: $db.mealRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aiRecognized => $composableBuilder(
    column: $table.aiRecognized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealRecordsTableOrderingComposer get mealRecordId {
    final $$MealRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealRecordId,
      referencedTable: $db.mealRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.mealRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<bool> get aiRecognized => $composableBuilder(
    column: $table.aiRecognized,
    builder: (column) => column,
  );

  GeneratedColumn<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MealRecordsTableAnnotationComposer get mealRecordId {
    final $$MealRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealRecordId,
      referencedTable: $db.mealRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemsTable,
          FoodItem,
          $$FoodItemsTableFilterComposer,
          $$FoodItemsTableOrderingComposer,
          $$FoodItemsTableAnnotationComposer,
          $$FoodItemsTableCreateCompanionBuilder,
          $$FoodItemsTableUpdateCompanionBuilder,
          (FoodItem, $$FoodItemsTableReferences),
          FoodItem,
          PrefetchHooks Function({bool mealRecordId})
        > {
  $$FoodItemsTableTableManager(_$AppDatabase db, $FoodItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mealRecordId = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> comment = const Value.absent(),
                Value<bool> aiRecognized = const Value.absent(),
                Value<double?> aiConfidence = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodItemsCompanion(
                id: id,
                mealRecordId: mealRecordId,
                imagePath: imagePath,
                name: name,
                comment: comment,
                aiRecognized: aiRecognized,
                aiConfidence: aiConfidence,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mealRecordId,
                required String imagePath,
                required String name,
                Value<String> comment = const Value.absent(),
                Value<bool> aiRecognized = const Value.absent(),
                Value<double?> aiConfidence = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => FoodItemsCompanion.insert(
                id: id,
                mealRecordId: mealRecordId,
                imagePath: imagePath,
                name: name,
                comment: comment,
                aiRecognized: aiRecognized,
                aiConfidence: aiConfidence,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealRecordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (mealRecordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mealRecordId,
                                referencedTable: $$FoodItemsTableReferences
                                    ._mealRecordIdTable(db),
                                referencedColumn: $$FoodItemsTableReferences
                                    ._mealRecordIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FoodItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemsTable,
      FoodItem,
      $$FoodItemsTableFilterComposer,
      $$FoodItemsTableOrderingComposer,
      $$FoodItemsTableAnnotationComposer,
      $$FoodItemsTableCreateCompanionBuilder,
      $$FoodItemsTableUpdateCompanionBuilder,
      (FoodItem, $$FoodItemsTableReferences),
      FoodItem,
      PrefetchHooks Function({bool mealRecordId})
    >;
typedef $$BodyFeedbacksTableCreateCompanionBuilder =
    BodyFeedbacksCompanion Function({
      required String id,
      required String date,
      Value<int?> energyScore,
      Value<int?> digestionScore,
      Value<int?> sleepScore,
      Value<int?> stomachScore,
      Value<int?> skinScore,
      Value<double?> weight,
      Value<String> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BodyFeedbacksTableUpdateCompanionBuilder =
    BodyFeedbacksCompanion Function({
      Value<String> id,
      Value<String> date,
      Value<int?> energyScore,
      Value<int?> digestionScore,
      Value<int?> sleepScore,
      Value<int?> stomachScore,
      Value<int?> skinScore,
      Value<double?> weight,
      Value<String> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$BodyFeedbacksTableReferences
    extends BaseReferences<_$AppDatabase, $BodyFeedbacksTable, BodyFeedback> {
  $$BodyFeedbacksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$GutSymptomsTable, List<GutSymptom>>
  _gutSymptomsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gutSymptoms,
    aliasName: $_aliasNameGenerator(
      db.bodyFeedbacks.id,
      db.gutSymptoms.feedbackId,
    ),
  );

  $$GutSymptomsTableProcessedTableManager get gutSymptomsRefs {
    final manager = $$GutSymptomsTableTableManager(
      $_db,
      $_db.gutSymptoms,
    ).filter((f) => f.feedbackId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gutSymptomsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BodyFeedbacksTableFilterComposer
    extends Composer<_$AppDatabase, $BodyFeedbacksTable> {
  $$BodyFeedbacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyScore => $composableBuilder(
    column: $table.energyScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get digestionScore => $composableBuilder(
    column: $table.digestionScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepScore => $composableBuilder(
    column: $table.sleepScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stomachScore => $composableBuilder(
    column: $table.stomachScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skinScore => $composableBuilder(
    column: $table.skinScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gutSymptomsRefs(
    Expression<bool> Function($$GutSymptomsTableFilterComposer f) f,
  ) {
    final $$GutSymptomsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gutSymptoms,
      getReferencedColumn: (t) => t.feedbackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GutSymptomsTableFilterComposer(
            $db: $db,
            $table: $db.gutSymptoms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BodyFeedbacksTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyFeedbacksTable> {
  $$BodyFeedbacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyScore => $composableBuilder(
    column: $table.energyScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get digestionScore => $composableBuilder(
    column: $table.digestionScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepScore => $composableBuilder(
    column: $table.sleepScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stomachScore => $composableBuilder(
    column: $table.stomachScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skinScore => $composableBuilder(
    column: $table.skinScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyFeedbacksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyFeedbacksTable> {
  $$BodyFeedbacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get energyScore => $composableBuilder(
    column: $table.energyScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get digestionScore => $composableBuilder(
    column: $table.digestionScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepScore => $composableBuilder(
    column: $table.sleepScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stomachScore => $composableBuilder(
    column: $table.stomachScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get skinScore =>
      $composableBuilder(column: $table.skinScore, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> gutSymptomsRefs<T extends Object>(
    Expression<T> Function($$GutSymptomsTableAnnotationComposer a) f,
  ) {
    final $$GutSymptomsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gutSymptoms,
      getReferencedColumn: (t) => t.feedbackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GutSymptomsTableAnnotationComposer(
            $db: $db,
            $table: $db.gutSymptoms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BodyFeedbacksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyFeedbacksTable,
          BodyFeedback,
          $$BodyFeedbacksTableFilterComposer,
          $$BodyFeedbacksTableOrderingComposer,
          $$BodyFeedbacksTableAnnotationComposer,
          $$BodyFeedbacksTableCreateCompanionBuilder,
          $$BodyFeedbacksTableUpdateCompanionBuilder,
          (BodyFeedback, $$BodyFeedbacksTableReferences),
          BodyFeedback,
          PrefetchHooks Function({bool gutSymptomsRefs})
        > {
  $$BodyFeedbacksTableTableManager(_$AppDatabase db, $BodyFeedbacksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyFeedbacksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyFeedbacksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyFeedbacksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<int?> energyScore = const Value.absent(),
                Value<int?> digestionScore = const Value.absent(),
                Value<int?> sleepScore = const Value.absent(),
                Value<int?> stomachScore = const Value.absent(),
                Value<int?> skinScore = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyFeedbacksCompanion(
                id: id,
                date: date,
                energyScore: energyScore,
                digestionScore: digestionScore,
                sleepScore: sleepScore,
                stomachScore: stomachScore,
                skinScore: skinScore,
                weight: weight,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String date,
                Value<int?> energyScore = const Value.absent(),
                Value<int?> digestionScore = const Value.absent(),
                Value<int?> sleepScore = const Value.absent(),
                Value<int?> stomachScore = const Value.absent(),
                Value<int?> skinScore = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BodyFeedbacksCompanion.insert(
                id: id,
                date: date,
                energyScore: energyScore,
                digestionScore: digestionScore,
                sleepScore: sleepScore,
                stomachScore: stomachScore,
                skinScore: skinScore,
                weight: weight,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BodyFeedbacksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gutSymptomsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (gutSymptomsRefs) db.gutSymptoms],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (gutSymptomsRefs)
                    await $_getPrefetchedData<
                      BodyFeedback,
                      $BodyFeedbacksTable,
                      GutSymptom
                    >(
                      currentTable: table,
                      referencedTable: $$BodyFeedbacksTableReferences
                          ._gutSymptomsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BodyFeedbacksTableReferences(
                            db,
                            table,
                            p0,
                          ).gutSymptomsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.feedbackId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BodyFeedbacksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyFeedbacksTable,
      BodyFeedback,
      $$BodyFeedbacksTableFilterComposer,
      $$BodyFeedbacksTableOrderingComposer,
      $$BodyFeedbacksTableAnnotationComposer,
      $$BodyFeedbacksTableCreateCompanionBuilder,
      $$BodyFeedbacksTableUpdateCompanionBuilder,
      (BodyFeedback, $$BodyFeedbacksTableReferences),
      BodyFeedback,
      PrefetchHooks Function({bool gutSymptomsRefs})
    >;
typedef $$GutSymptomsTableCreateCompanionBuilder =
    GutSymptomsCompanion Function({
      required String id,
      required String feedbackId,
      required String type,
      required String severity,
      Value<int> rowid,
    });
typedef $$GutSymptomsTableUpdateCompanionBuilder =
    GutSymptomsCompanion Function({
      Value<String> id,
      Value<String> feedbackId,
      Value<String> type,
      Value<String> severity,
      Value<int> rowid,
    });

final class $$GutSymptomsTableReferences
    extends BaseReferences<_$AppDatabase, $GutSymptomsTable, GutSymptom> {
  $$GutSymptomsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BodyFeedbacksTable _feedbackIdTable(_$AppDatabase db) =>
      db.bodyFeedbacks.createAlias(
        $_aliasNameGenerator(db.gutSymptoms.feedbackId, db.bodyFeedbacks.id),
      );

  $$BodyFeedbacksTableProcessedTableManager get feedbackId {
    final $_column = $_itemColumn<String>('feedback_id')!;

    final manager = $$BodyFeedbacksTableTableManager(
      $_db,
      $_db.bodyFeedbacks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_feedbackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GutSymptomsTableFilterComposer
    extends Composer<_$AppDatabase, $GutSymptomsTable> {
  $$GutSymptomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  $$BodyFeedbacksTableFilterComposer get feedbackId {
    final $$BodyFeedbacksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feedbackId,
      referencedTable: $db.bodyFeedbacks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BodyFeedbacksTableFilterComposer(
            $db: $db,
            $table: $db.bodyFeedbacks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GutSymptomsTableOrderingComposer
    extends Composer<_$AppDatabase, $GutSymptomsTable> {
  $$GutSymptomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  $$BodyFeedbacksTableOrderingComposer get feedbackId {
    final $$BodyFeedbacksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feedbackId,
      referencedTable: $db.bodyFeedbacks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BodyFeedbacksTableOrderingComposer(
            $db: $db,
            $table: $db.bodyFeedbacks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GutSymptomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GutSymptomsTable> {
  $$GutSymptomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  $$BodyFeedbacksTableAnnotationComposer get feedbackId {
    final $$BodyFeedbacksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feedbackId,
      referencedTable: $db.bodyFeedbacks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BodyFeedbacksTableAnnotationComposer(
            $db: $db,
            $table: $db.bodyFeedbacks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GutSymptomsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GutSymptomsTable,
          GutSymptom,
          $$GutSymptomsTableFilterComposer,
          $$GutSymptomsTableOrderingComposer,
          $$GutSymptomsTableAnnotationComposer,
          $$GutSymptomsTableCreateCompanionBuilder,
          $$GutSymptomsTableUpdateCompanionBuilder,
          (GutSymptom, $$GutSymptomsTableReferences),
          GutSymptom,
          PrefetchHooks Function({bool feedbackId})
        > {
  $$GutSymptomsTableTableManager(_$AppDatabase db, $GutSymptomsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GutSymptomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GutSymptomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GutSymptomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> feedbackId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GutSymptomsCompanion(
                id: id,
                feedbackId: feedbackId,
                type: type,
                severity: severity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String feedbackId,
                required String type,
                required String severity,
                Value<int> rowid = const Value.absent(),
              }) => GutSymptomsCompanion.insert(
                id: id,
                feedbackId: feedbackId,
                type: type,
                severity: severity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GutSymptomsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({feedbackId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (feedbackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.feedbackId,
                                referencedTable: $$GutSymptomsTableReferences
                                    ._feedbackIdTable(db),
                                referencedColumn: $$GutSymptomsTableReferences
                                    ._feedbackIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GutSymptomsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GutSymptomsTable,
      GutSymptom,
      $$GutSymptomsTableFilterComposer,
      $$GutSymptomsTableOrderingComposer,
      $$GutSymptomsTableAnnotationComposer,
      $$GutSymptomsTableCreateCompanionBuilder,
      $$GutSymptomsTableUpdateCompanionBuilder,
      (GutSymptom, $$GutSymptomsTableReferences),
      GutSymptom,
      PrefetchHooks Function({bool feedbackId})
    >;
typedef $$AdviceRecordsTableCreateCompanionBuilder =
    AdviceRecordsCompanion Function({
      required String id,
      required String queryText,
      Value<String?> queryImagePath,
      required String conclusion,
      required String reason,
      Value<String> riskFactors,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$AdviceRecordsTableUpdateCompanionBuilder =
    AdviceRecordsCompanion Function({
      Value<String> id,
      Value<String> queryText,
      Value<String?> queryImagePath,
      Value<String> conclusion,
      Value<String> reason,
      Value<String> riskFactors,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$AdviceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AdviceRecordsTable> {
  $$AdviceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queryText => $composableBuilder(
    column: $table.queryText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queryImagePath => $composableBuilder(
    column: $table.queryImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conclusion => $composableBuilder(
    column: $table.conclusion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskFactors => $composableBuilder(
    column: $table.riskFactors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AdviceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AdviceRecordsTable> {
  $$AdviceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queryText => $composableBuilder(
    column: $table.queryText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queryImagePath => $composableBuilder(
    column: $table.queryImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conclusion => $composableBuilder(
    column: $table.conclusion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskFactors => $composableBuilder(
    column: $table.riskFactors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AdviceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdviceRecordsTable> {
  $$AdviceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get queryText =>
      $composableBuilder(column: $table.queryText, builder: (column) => column);

  GeneratedColumn<String> get queryImagePath => $composableBuilder(
    column: $table.queryImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conclusion => $composableBuilder(
    column: $table.conclusion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get riskFactors => $composableBuilder(
    column: $table.riskFactors,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AdviceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AdviceRecordsTable,
          AdviceRecord,
          $$AdviceRecordsTableFilterComposer,
          $$AdviceRecordsTableOrderingComposer,
          $$AdviceRecordsTableAnnotationComposer,
          $$AdviceRecordsTableCreateCompanionBuilder,
          $$AdviceRecordsTableUpdateCompanionBuilder,
          (
            AdviceRecord,
            BaseReferences<_$AppDatabase, $AdviceRecordsTable, AdviceRecord>,
          ),
          AdviceRecord,
          PrefetchHooks Function()
        > {
  $$AdviceRecordsTableTableManager(_$AppDatabase db, $AdviceRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdviceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AdviceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AdviceRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> queryText = const Value.absent(),
                Value<String?> queryImagePath = const Value.absent(),
                Value<String> conclusion = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> riskFactors = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AdviceRecordsCompanion(
                id: id,
                queryText: queryText,
                queryImagePath: queryImagePath,
                conclusion: conclusion,
                reason: reason,
                riskFactors: riskFactors,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String queryText,
                Value<String?> queryImagePath = const Value.absent(),
                required String conclusion,
                required String reason,
                Value<String> riskFactors = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AdviceRecordsCompanion.insert(
                id: id,
                queryText: queryText,
                queryImagePath: queryImagePath,
                conclusion: conclusion,
                reason: reason,
                riskFactors: riskFactors,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AdviceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AdviceRecordsTable,
      AdviceRecord,
      $$AdviceRecordsTableFilterComposer,
      $$AdviceRecordsTableOrderingComposer,
      $$AdviceRecordsTableAnnotationComposer,
      $$AdviceRecordsTableCreateCompanionBuilder,
      $$AdviceRecordsTableUpdateCompanionBuilder,
      (
        AdviceRecord,
        BaseReferences<_$AppDatabase, $AdviceRecordsTable, AdviceRecord>,
      ),
      AdviceRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MealRecordsTableTableManager get mealRecords =>
      $$MealRecordsTableTableManager(_db, _db.mealRecords);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db, _db.foodItems);
  $$BodyFeedbacksTableTableManager get bodyFeedbacks =>
      $$BodyFeedbacksTableTableManager(_db, _db.bodyFeedbacks);
  $$GutSymptomsTableTableManager get gutSymptoms =>
      $$GutSymptomsTableTableManager(_db, _db.gutSymptoms);
  $$AdviceRecordsTableTableManager get adviceRecords =>
      $$AdviceRecordsTableTableManager(_db, _db.adviceRecords);
}
