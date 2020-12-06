// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_stuff_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class FoodStuffRecord extends DataClass implements Insertable<FoodStuffRecord> {
  final int id;
  final String foodStuffId;
  final String localImagePath;
  final String name;
  final String category;
  final String storage;
  final DateTime validDate;
  final int amount;
  final int useAmount;
  final int restAmount;
  FoodStuffRecord(
      {@required this.id,
      @required this.foodStuffId,
      @required this.localImagePath,
      @required this.name,
      this.category,
      this.storage,
      this.validDate,
      @required this.amount,
      @required this.useAmount,
      @required this.restAmount});
  factory FoodStuffRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return FoodStuffRecord(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      foodStuffId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}food_stuff_id']),
      localImagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}local_image_path']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      storage:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}storage']),
      validDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}valid_date']),
      amount: intType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      useAmount:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}use_amount']),
      restAmount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}rest_amount']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || foodStuffId != null) {
      map['food_stuff_id'] = Variable<String>(foodStuffId);
    }
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || storage != null) {
      map['storage'] = Variable<String>(storage);
    }
    if (!nullToAbsent || validDate != null) {
      map['valid_date'] = Variable<DateTime>(validDate);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<int>(amount);
    }
    if (!nullToAbsent || useAmount != null) {
      map['use_amount'] = Variable<int>(useAmount);
    }
    if (!nullToAbsent || restAmount != null) {
      map['rest_amount'] = Variable<int>(restAmount);
    }
    return map;
  }

  FoodStuffRecordsCompanion toCompanion(bool nullToAbsent) {
    return FoodStuffRecordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      foodStuffId: foodStuffId == null && nullToAbsent
          ? const Value.absent()
          : Value(foodStuffId),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      storage: storage == null && nullToAbsent
          ? const Value.absent()
          : Value(storage),
      validDate: validDate == null && nullToAbsent
          ? const Value.absent()
          : Value(validDate),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      useAmount: useAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(useAmount),
      restAmount: restAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(restAmount),
    );
  }

  factory FoodStuffRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FoodStuffRecord(
      id: serializer.fromJson<int>(json['id']),
      foodStuffId: serializer.fromJson<String>(json['foodStuffId']),
      localImagePath: serializer.fromJson<String>(json['localImagePath']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      storage: serializer.fromJson<String>(json['storage']),
      validDate: serializer.fromJson<DateTime>(json['validDate']),
      amount: serializer.fromJson<int>(json['amount']),
      useAmount: serializer.fromJson<int>(json['useAmount']),
      restAmount: serializer.fromJson<int>(json['restAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodStuffId': serializer.toJson<String>(foodStuffId),
      'localImagePath': serializer.toJson<String>(localImagePath),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'storage': serializer.toJson<String>(storage),
      'validDate': serializer.toJson<DateTime>(validDate),
      'amount': serializer.toJson<int>(amount),
      'useAmount': serializer.toJson<int>(useAmount),
      'restAmount': serializer.toJson<int>(restAmount),
    };
  }

  FoodStuffRecord copyWith(
          {int id,
          String foodStuffId,
          String localImagePath,
          String name,
          String category,
          String storage,
          DateTime validDate,
          int amount,
          int useAmount,
          int restAmount}) =>
      FoodStuffRecord(
        id: id ?? this.id,
        foodStuffId: foodStuffId ?? this.foodStuffId,
        localImagePath: localImagePath ?? this.localImagePath,
        name: name ?? this.name,
        category: category ?? this.category,
        storage: storage ?? this.storage,
        validDate: validDate ?? this.validDate,
        amount: amount ?? this.amount,
        useAmount: useAmount ?? this.useAmount,
        restAmount: restAmount ?? this.restAmount,
      );
  @override
  String toString() {
    return (StringBuffer('FoodStuffRecord(')
          ..write('id: $id, ')
          ..write('foodStuffId: $foodStuffId, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('storage: $storage, ')
          ..write('validDate: $validDate, ')
          ..write('amount: $amount, ')
          ..write('useAmount: $useAmount, ')
          ..write('restAmount: $restAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          foodStuffId.hashCode,
          $mrjc(
              localImagePath.hashCode,
              $mrjc(
                  name.hashCode,
                  $mrjc(
                      category.hashCode,
                      $mrjc(
                          storage.hashCode,
                          $mrjc(
                              validDate.hashCode,
                              $mrjc(
                                  amount.hashCode,
                                  $mrjc(useAmount.hashCode,
                                      restAmount.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is FoodStuffRecord &&
          other.id == this.id &&
          other.foodStuffId == this.foodStuffId &&
          other.localImagePath == this.localImagePath &&
          other.name == this.name &&
          other.category == this.category &&
          other.storage == this.storage &&
          other.validDate == this.validDate &&
          other.amount == this.amount &&
          other.useAmount == this.useAmount &&
          other.restAmount == this.restAmount);
}

class FoodStuffRecordsCompanion extends UpdateCompanion<FoodStuffRecord> {
  final Value<int> id;
  final Value<String> foodStuffId;
  final Value<String> localImagePath;
  final Value<String> name;
  final Value<String> category;
  final Value<String> storage;
  final Value<DateTime> validDate;
  final Value<int> amount;
  final Value<int> useAmount;
  final Value<int> restAmount;
  const FoodStuffRecordsCompanion({
    this.id = const Value.absent(),
    this.foodStuffId = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.storage = const Value.absent(),
    this.validDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.useAmount = const Value.absent(),
    this.restAmount = const Value.absent(),
  });
  FoodStuffRecordsCompanion.insert({
    this.id = const Value.absent(),
    @required String foodStuffId,
    @required String localImagePath,
    @required String name,
    this.category = const Value.absent(),
    this.storage = const Value.absent(),
    this.validDate = const Value.absent(),
    @required int amount,
    this.useAmount = const Value.absent(),
    @required int restAmount,
  })  : foodStuffId = Value(foodStuffId),
        localImagePath = Value(localImagePath),
        name = Value(name),
        amount = Value(amount),
        restAmount = Value(restAmount);
  static Insertable<FoodStuffRecord> custom({
    Expression<int> id,
    Expression<String> foodStuffId,
    Expression<String> localImagePath,
    Expression<String> name,
    Expression<String> category,
    Expression<String> storage,
    Expression<DateTime> validDate,
    Expression<int> amount,
    Expression<int> useAmount,
    Expression<int> restAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodStuffId != null) 'food_stuff_id': foodStuffId,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (storage != null) 'storage': storage,
      if (validDate != null) 'valid_date': validDate,
      if (amount != null) 'amount': amount,
      if (useAmount != null) 'use_amount': useAmount,
      if (restAmount != null) 'rest_amount': restAmount,
    });
  }

  FoodStuffRecordsCompanion copyWith(
      {Value<int> id,
      Value<String> foodStuffId,
      Value<String> localImagePath,
      Value<String> name,
      Value<String> category,
      Value<String> storage,
      Value<DateTime> validDate,
      Value<int> amount,
      Value<int> useAmount,
      Value<int> restAmount}) {
    return FoodStuffRecordsCompanion(
      id: id ?? this.id,
      foodStuffId: foodStuffId ?? this.foodStuffId,
      localImagePath: localImagePath ?? this.localImagePath,
      name: name ?? this.name,
      category: category ?? this.category,
      storage: storage ?? this.storage,
      validDate: validDate ?? this.validDate,
      amount: amount ?? this.amount,
      useAmount: useAmount ?? this.useAmount,
      restAmount: restAmount ?? this.restAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodStuffId.present) {
      map['food_stuff_id'] = Variable<String>(foodStuffId.value);
    }
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (storage.present) {
      map['storage'] = Variable<String>(storage.value);
    }
    if (validDate.present) {
      map['valid_date'] = Variable<DateTime>(validDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (useAmount.present) {
      map['use_amount'] = Variable<int>(useAmount.value);
    }
    if (restAmount.present) {
      map['rest_amount'] = Variable<int>(restAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodStuffRecordsCompanion(')
          ..write('id: $id, ')
          ..write('foodStuffId: $foodStuffId, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('storage: $storage, ')
          ..write('validDate: $validDate, ')
          ..write('amount: $amount, ')
          ..write('useAmount: $useAmount, ')
          ..write('restAmount: $restAmount')
          ..write(')'))
        .toString();
  }
}

class $FoodStuffRecordsTable extends FoodStuffRecords
    with TableInfo<$FoodStuffRecordsTable, FoodStuffRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $FoodStuffRecordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _foodStuffIdMeta =
      const VerificationMeta('foodStuffId');
  GeneratedTextColumn _foodStuffId;
  @override
  GeneratedTextColumn get foodStuffId =>
      _foodStuffId ??= _constructFoodStuffId();
  GeneratedTextColumn _constructFoodStuffId() {
    return GeneratedTextColumn(
      'food_stuff_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _localImagePathMeta =
      const VerificationMeta('localImagePath');
  GeneratedTextColumn _localImagePath;
  @override
  GeneratedTextColumn get localImagePath =>
      _localImagePath ??= _constructLocalImagePath();
  GeneratedTextColumn _constructLocalImagePath() {
    return GeneratedTextColumn(
      'local_image_path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      true,
    );
  }

  final VerificationMeta _storageMeta = const VerificationMeta('storage');
  GeneratedTextColumn _storage;
  @override
  GeneratedTextColumn get storage => _storage ??= _constructStorage();
  GeneratedTextColumn _constructStorage() {
    return GeneratedTextColumn(
      'storage',
      $tableName,
      true,
    );
  }

  final VerificationMeta _validDateMeta = const VerificationMeta('validDate');
  GeneratedDateTimeColumn _validDate;
  @override
  GeneratedDateTimeColumn get validDate => _validDate ??= _constructValidDate();
  GeneratedDateTimeColumn _constructValidDate() {
    return GeneratedDateTimeColumn(
      'valid_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedIntColumn _amount;
  @override
  GeneratedIntColumn get amount => _amount ??= _constructAmount();
  GeneratedIntColumn _constructAmount() {
    return GeneratedIntColumn(
      'amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _useAmountMeta = const VerificationMeta('useAmount');
  GeneratedIntColumn _useAmount;
  @override
  GeneratedIntColumn get useAmount => _useAmount ??= _constructUseAmount();
  GeneratedIntColumn _constructUseAmount() {
    return GeneratedIntColumn('use_amount', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _restAmountMeta = const VerificationMeta('restAmount');
  GeneratedIntColumn _restAmount;
  @override
  GeneratedIntColumn get restAmount => _restAmount ??= _constructRestAmount();
  GeneratedIntColumn _constructRestAmount() {
    return GeneratedIntColumn(
      'rest_amount',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        foodStuffId,
        localImagePath,
        name,
        category,
        storage,
        validDate,
        amount,
        useAmount,
        restAmount
      ];
  @override
  $FoodStuffRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'food_stuff_records';
  @override
  final String actualTableName = 'food_stuff_records';
  @override
  VerificationContext validateIntegrity(Insertable<FoodStuffRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('food_stuff_id')) {
      context.handle(
          _foodStuffIdMeta,
          foodStuffId.isAcceptableOrUnknown(
              data['food_stuff_id'], _foodStuffIdMeta));
    } else if (isInserting) {
      context.missing(_foodStuffIdMeta);
    }
    if (data.containsKey('local_image_path')) {
      context.handle(
          _localImagePathMeta,
          localImagePath.isAcceptableOrUnknown(
              data['local_image_path'], _localImagePathMeta));
    } else if (isInserting) {
      context.missing(_localImagePathMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    }
    if (data.containsKey('storage')) {
      context.handle(_storageMeta,
          storage.isAcceptableOrUnknown(data['storage'], _storageMeta));
    }
    if (data.containsKey('valid_date')) {
      context.handle(_validDateMeta,
          validDate.isAcceptableOrUnknown(data['valid_date'], _validDateMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount'], _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('use_amount')) {
      context.handle(_useAmountMeta,
          useAmount.isAcceptableOrUnknown(data['use_amount'], _useAmountMeta));
    }
    if (data.containsKey('rest_amount')) {
      context.handle(
          _restAmountMeta,
          restAmount.isAcceptableOrUnknown(
              data['rest_amount'], _restAmountMeta));
    } else if (isInserting) {
      context.missing(_restAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodStuffRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FoodStuffRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FoodStuffRecordsTable createAlias(String alias) {
    return $FoodStuffRecordsTable(_db, alias);
  }
}

class AmountToEatRecord extends DataClass
    implements Insertable<AmountToEatRecord> {
  final int id;
  final String foodStuffId;
  final String amountToEatId;
  final String date;
  final String mealType;
  final int piece;
  AmountToEatRecord(
      {this.id,
      @required this.foodStuffId,
      @required this.amountToEatId,
      @required this.date,
      @required this.mealType,
      this.piece});
  factory AmountToEatRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return AmountToEatRecord(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      foodStuffId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}food_stuff_id']),
      amountToEatId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_to_eat_id']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      mealType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}meal_type']),
      piece: intType.mapFromDatabaseResponse(data['${effectivePrefix}piece']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || foodStuffId != null) {
      map['food_stuff_id'] = Variable<String>(foodStuffId);
    }
    if (!nullToAbsent || amountToEatId != null) {
      map['amount_to_eat_id'] = Variable<String>(amountToEatId);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || mealType != null) {
      map['meal_type'] = Variable<String>(mealType);
    }
    if (!nullToAbsent || piece != null) {
      map['piece'] = Variable<int>(piece);
    }
    return map;
  }

  AmountToEatRecordsCompanion toCompanion(bool nullToAbsent) {
    return AmountToEatRecordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      foodStuffId: foodStuffId == null && nullToAbsent
          ? const Value.absent()
          : Value(foodStuffId),
      amountToEatId: amountToEatId == null && nullToAbsent
          ? const Value.absent()
          : Value(amountToEatId),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      mealType: mealType == null && nullToAbsent
          ? const Value.absent()
          : Value(mealType),
      piece:
          piece == null && nullToAbsent ? const Value.absent() : Value(piece),
    );
  }

  factory AmountToEatRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AmountToEatRecord(
      id: serializer.fromJson<int>(json['id']),
      foodStuffId: serializer.fromJson<String>(json['foodStuffId']),
      amountToEatId: serializer.fromJson<String>(json['amountToEatId']),
      date: serializer.fromJson<String>(json['date']),
      mealType: serializer.fromJson<String>(json['mealType']),
      piece: serializer.fromJson<int>(json['piece']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodStuffId': serializer.toJson<String>(foodStuffId),
      'amountToEatId': serializer.toJson<String>(amountToEatId),
      'date': serializer.toJson<String>(date),
      'mealType': serializer.toJson<String>(mealType),
      'piece': serializer.toJson<int>(piece),
    };
  }

  AmountToEatRecord copyWith(
          {int id,
          String foodStuffId,
          String amountToEatId,
          String date,
          String mealType,
          int piece}) =>
      AmountToEatRecord(
        id: id ?? this.id,
        foodStuffId: foodStuffId ?? this.foodStuffId,
        amountToEatId: amountToEatId ?? this.amountToEatId,
        date: date ?? this.date,
        mealType: mealType ?? this.mealType,
        piece: piece ?? this.piece,
      );
  @override
  String toString() {
    return (StringBuffer('AmountToEatRecord(')
          ..write('id: $id, ')
          ..write('foodStuffId: $foodStuffId, ')
          ..write('amountToEatId: $amountToEatId, ')
          ..write('date: $date, ')
          ..write('mealType: $mealType, ')
          ..write('piece: $piece')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          foodStuffId.hashCode,
          $mrjc(
              amountToEatId.hashCode,
              $mrjc(
                  date.hashCode, $mrjc(mealType.hashCode, piece.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AmountToEatRecord &&
          other.id == this.id &&
          other.foodStuffId == this.foodStuffId &&
          other.amountToEatId == this.amountToEatId &&
          other.date == this.date &&
          other.mealType == this.mealType &&
          other.piece == this.piece);
}

class AmountToEatRecordsCompanion extends UpdateCompanion<AmountToEatRecord> {
  final Value<int> id;
  final Value<String> foodStuffId;
  final Value<String> amountToEatId;
  final Value<String> date;
  final Value<String> mealType;
  final Value<int> piece;
  const AmountToEatRecordsCompanion({
    this.id = const Value.absent(),
    this.foodStuffId = const Value.absent(),
    this.amountToEatId = const Value.absent(),
    this.date = const Value.absent(),
    this.mealType = const Value.absent(),
    this.piece = const Value.absent(),
  });
  AmountToEatRecordsCompanion.insert({
    this.id = const Value.absent(),
    @required String foodStuffId,
    @required String amountToEatId,
    @required String date,
    @required String mealType,
    this.piece = const Value.absent(),
  })  : foodStuffId = Value(foodStuffId),
        amountToEatId = Value(amountToEatId),
        date = Value(date),
        mealType = Value(mealType);
  static Insertable<AmountToEatRecord> custom({
    Expression<int> id,
    Expression<String> foodStuffId,
    Expression<String> amountToEatId,
    Expression<String> date,
    Expression<String> mealType,
    Expression<int> piece,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodStuffId != null) 'food_stuff_id': foodStuffId,
      if (amountToEatId != null) 'amount_to_eat_id': amountToEatId,
      if (date != null) 'date': date,
      if (mealType != null) 'meal_type': mealType,
      if (piece != null) 'piece': piece,
    });
  }

  AmountToEatRecordsCompanion copyWith(
      {Value<int> id,
      Value<String> foodStuffId,
      Value<String> amountToEatId,
      Value<String> date,
      Value<String> mealType,
      Value<int> piece}) {
    return AmountToEatRecordsCompanion(
      id: id ?? this.id,
      foodStuffId: foodStuffId ?? this.foodStuffId,
      amountToEatId: amountToEatId ?? this.amountToEatId,
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      piece: piece ?? this.piece,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodStuffId.present) {
      map['food_stuff_id'] = Variable<String>(foodStuffId.value);
    }
    if (amountToEatId.present) {
      map['amount_to_eat_id'] = Variable<String>(amountToEatId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (piece.present) {
      map['piece'] = Variable<int>(piece.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AmountToEatRecordsCompanion(')
          ..write('id: $id, ')
          ..write('foodStuffId: $foodStuffId, ')
          ..write('amountToEatId: $amountToEatId, ')
          ..write('date: $date, ')
          ..write('mealType: $mealType, ')
          ..write('piece: $piece')
          ..write(')'))
        .toString();
  }
}

class $AmountToEatRecordsTable extends AmountToEatRecords
    with TableInfo<$AmountToEatRecordsTable, AmountToEatRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $AmountToEatRecordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _foodStuffIdMeta =
      const VerificationMeta('foodStuffId');
  GeneratedTextColumn _foodStuffId;
  @override
  GeneratedTextColumn get foodStuffId =>
      _foodStuffId ??= _constructFoodStuffId();
  GeneratedTextColumn _constructFoodStuffId() {
    return GeneratedTextColumn(
      'food_stuff_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountToEatIdMeta =
      const VerificationMeta('amountToEatId');
  GeneratedTextColumn _amountToEatId;
  @override
  GeneratedTextColumn get amountToEatId =>
      _amountToEatId ??= _constructAmountToEatId();
  GeneratedTextColumn _constructAmountToEatId() {
    return GeneratedTextColumn(
      'amount_to_eat_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedTextColumn _date;
  @override
  GeneratedTextColumn get date => _date ??= _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mealTypeMeta = const VerificationMeta('mealType');
  GeneratedTextColumn _mealType;
  @override
  GeneratedTextColumn get mealType => _mealType ??= _constructMealType();
  GeneratedTextColumn _constructMealType() {
    return GeneratedTextColumn(
      'meal_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pieceMeta = const VerificationMeta('piece');
  GeneratedIntColumn _piece;
  @override
  GeneratedIntColumn get piece => _piece ??= _constructPiece();
  GeneratedIntColumn _constructPiece() {
    return GeneratedIntColumn(
      'piece',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, foodStuffId, amountToEatId, date, mealType, piece];
  @override
  $AmountToEatRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'amount_to_eat_records';
  @override
  final String actualTableName = 'amount_to_eat_records';
  @override
  VerificationContext validateIntegrity(Insertable<AmountToEatRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('food_stuff_id')) {
      context.handle(
          _foodStuffIdMeta,
          foodStuffId.isAcceptableOrUnknown(
              data['food_stuff_id'], _foodStuffIdMeta));
    } else if (isInserting) {
      context.missing(_foodStuffIdMeta);
    }
    if (data.containsKey('amount_to_eat_id')) {
      context.handle(
          _amountToEatIdMeta,
          amountToEatId.isAcceptableOrUnknown(
              data['amount_to_eat_id'], _amountToEatIdMeta));
    } else if (isInserting) {
      context.missing(_amountToEatIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(_mealTypeMeta,
          mealType.isAcceptableOrUnknown(data['meal_type'], _mealTypeMeta));
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('piece')) {
      context.handle(
          _pieceMeta, piece.isAcceptableOrUnknown(data['piece'], _pieceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  AmountToEatRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AmountToEatRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AmountToEatRecordsTable createAlias(String alias) {
    return $AmountToEatRecordsTable(_db, alias);
  }
}

abstract class _$FoodStuffDB extends GeneratedDatabase {
  _$FoodStuffDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $FoodStuffRecordsTable _foodStuffRecords;
  $FoodStuffRecordsTable get foodStuffRecords =>
      _foodStuffRecords ??= $FoodStuffRecordsTable(this);
  $AmountToEatRecordsTable _amountToEatRecords;
  $AmountToEatRecordsTable get amountToEatRecords =>
      _amountToEatRecords ??= $AmountToEatRecordsTable(this);
  FoodStuffDao _foodStuffDao;
  FoodStuffDao get foodStuffDao =>
      _foodStuffDao ??= FoodStuffDao(this as FoodStuffDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [foodStuffRecords, amountToEatRecords];
}
