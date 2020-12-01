// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_info_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ProductRecord extends DataClass implements Insertable<ProductRecord> {
  final String productId;
  final String name;
  final String description;
  ProductRecord(
      {@required this.productId,
      @required this.name,
      @required this.description});
  factory ProductRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ProductRecord(
      productId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  ProductRecordsCompanion toCompanion(bool nullToAbsent) {
    return ProductRecordsCompanion(
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory ProductRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductRecord(
      productId: serializer.fromJson<String>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  ProductRecord copyWith({String productId, String name, String description}) =>
      ProductRecord(
        productId: productId ?? this.productId,
        name: name ?? this.name,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('ProductRecord(')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(productId.hashCode, $mrjc(name.hashCode, description.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductRecord &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.description == this.description);
}

class ProductRecordsCompanion extends UpdateCompanion<ProductRecord> {
  final Value<String> productId;
  final Value<String> name;
  final Value<String> description;
  const ProductRecordsCompanion({
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  ProductRecordsCompanion.insert({
    @required String productId,
    @required String name,
    @required String description,
  })  : productId = Value(productId),
        name = Value(name),
        description = Value(description);
  static Insertable<ProductRecord> custom({
    Expression<String> productId,
    Expression<String> name,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  ProductRecordsCompanion copyWith(
      {Value<String> productId,
      Value<String> name,
      Value<String> description}) {
    return ProductRecordsCompanion(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductRecordsCompanion(')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $ProductRecordsTable extends ProductRecords
    with TableInfo<$ProductRecordsTable, ProductRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductRecordsTable(this._db, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedTextColumn _productId;
  @override
  GeneratedTextColumn get productId => _productId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn(
      'product_id',
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

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [productId, name, description];
  @override
  $ProductRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_records';
  @override
  final String actualTableName = 'product_records';
  @override
  VerificationContext validateIntegrity(Insertable<ProductRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  ProductRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductRecordsTable createAlias(String alias) {
    return $ProductRecordsTable(_db, alias);
  }
}

class ProductRecordImage extends DataClass
    implements Insertable<ProductRecordImage> {
  final String productId;
  final String imageId;
  final String small;
  final String medium;
  ProductRecordImage(
      {@required this.productId,
      @required this.imageId,
      @required this.small,
      @required this.medium});
  factory ProductRecordImage.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ProductRecordImage(
      productId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      imageId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_id']),
      small:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}small']),
      medium:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}medium']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<String>(imageId);
    }
    if (!nullToAbsent || small != null) {
      map['small'] = Variable<String>(small);
    }
    if (!nullToAbsent || medium != null) {
      map['medium'] = Variable<String>(medium);
    }
    return map;
  }

  ProductRecordImagesCompanion toCompanion(bool nullToAbsent) {
    return ProductRecordImagesCompanion(
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      small:
          small == null && nullToAbsent ? const Value.absent() : Value(small),
      medium:
          medium == null && nullToAbsent ? const Value.absent() : Value(medium),
    );
  }

  factory ProductRecordImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductRecordImage(
      productId: serializer.fromJson<String>(json['productId']),
      imageId: serializer.fromJson<String>(json['imageId']),
      small: serializer.fromJson<String>(json['small']),
      medium: serializer.fromJson<String>(json['medium']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'imageId': serializer.toJson<String>(imageId),
      'small': serializer.toJson<String>(small),
      'medium': serializer.toJson<String>(medium),
    };
  }

  ProductRecordImage copyWith(
          {String productId, String imageId, String small, String medium}) =>
      ProductRecordImage(
        productId: productId ?? this.productId,
        imageId: imageId ?? this.imageId,
        small: small ?? this.small,
        medium: medium ?? this.medium,
      );
  @override
  String toString() {
    return (StringBuffer('ProductRecordImage(')
          ..write('productId: $productId, ')
          ..write('imageId: $imageId, ')
          ..write('small: $small, ')
          ..write('medium: $medium')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(productId.hashCode,
      $mrjc(imageId.hashCode, $mrjc(small.hashCode, medium.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductRecordImage &&
          other.productId == this.productId &&
          other.imageId == this.imageId &&
          other.small == this.small &&
          other.medium == this.medium);
}

class ProductRecordImagesCompanion extends UpdateCompanion<ProductRecordImage> {
  final Value<String> productId;
  final Value<String> imageId;
  final Value<String> small;
  final Value<String> medium;
  const ProductRecordImagesCompanion({
    this.productId = const Value.absent(),
    this.imageId = const Value.absent(),
    this.small = const Value.absent(),
    this.medium = const Value.absent(),
  });
  ProductRecordImagesCompanion.insert({
    @required String productId,
    @required String imageId,
    @required String small,
    @required String medium,
  })  : productId = Value(productId),
        imageId = Value(imageId),
        small = Value(small),
        medium = Value(medium);
  static Insertable<ProductRecordImage> custom({
    Expression<String> productId,
    Expression<String> imageId,
    Expression<String> small,
    Expression<String> medium,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (imageId != null) 'image_id': imageId,
      if (small != null) 'small': small,
      if (medium != null) 'medium': medium,
    });
  }

  ProductRecordImagesCompanion copyWith(
      {Value<String> productId,
      Value<String> imageId,
      Value<String> small,
      Value<String> medium}) {
    return ProductRecordImagesCompanion(
      productId: productId ?? this.productId,
      imageId: imageId ?? this.imageId,
      small: small ?? this.small,
      medium: medium ?? this.medium,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String>(imageId.value);
    }
    if (small.present) {
      map['small'] = Variable<String>(small.value);
    }
    if (medium.present) {
      map['medium'] = Variable<String>(medium.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductRecordImagesCompanion(')
          ..write('productId: $productId, ')
          ..write('imageId: $imageId, ')
          ..write('small: $small, ')
          ..write('medium: $medium')
          ..write(')'))
        .toString();
  }
}

class $ProductRecordImagesTable extends ProductRecordImages
    with TableInfo<$ProductRecordImagesTable, ProductRecordImage> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductRecordImagesTable(this._db, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedTextColumn _productId;
  @override
  GeneratedTextColumn get productId => _productId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn(
      'product_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageIdMeta = const VerificationMeta('imageId');
  GeneratedTextColumn _imageId;
  @override
  GeneratedTextColumn get imageId => _imageId ??= _constructImageId();
  GeneratedTextColumn _constructImageId() {
    return GeneratedTextColumn(
      'image_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _smallMeta = const VerificationMeta('small');
  GeneratedTextColumn _small;
  @override
  GeneratedTextColumn get small => _small ??= _constructSmall();
  GeneratedTextColumn _constructSmall() {
    return GeneratedTextColumn(
      'small',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mediumMeta = const VerificationMeta('medium');
  GeneratedTextColumn _medium;
  @override
  GeneratedTextColumn get medium => _medium ??= _constructMedium();
  GeneratedTextColumn _constructMedium() {
    return GeneratedTextColumn(
      'medium',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [productId, imageId, small, medium];
  @override
  $ProductRecordImagesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_record_images';
  @override
  final String actualTableName = 'product_record_images';
  @override
  VerificationContext validateIntegrity(Insertable<ProductRecordImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id'], _imageIdMeta));
    } else if (isInserting) {
      context.missing(_imageIdMeta);
    }
    if (data.containsKey('small')) {
      context.handle(
          _smallMeta, small.isAcceptableOrUnknown(data['small'], _smallMeta));
    } else if (isInserting) {
      context.missing(_smallMeta);
    }
    if (data.containsKey('medium')) {
      context.handle(_mediumMeta,
          medium.isAcceptableOrUnknown(data['medium'], _mediumMeta));
    } else if (isInserting) {
      context.missing(_mediumMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {imageId};
  @override
  ProductRecordImage map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductRecordImage.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductRecordImagesTable createAlias(String alias) {
    return $ProductRecordImagesTable(_db, alias);
  }
}

class ProductWithImage extends DataClass
    implements Insertable<ProductWithImage> {
  final int idProductWithImage;
  final String product;
  final String image;
  ProductWithImage(
      {@required this.idProductWithImage,
      @required this.product,
      @required this.image});
  factory ProductWithImage.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return ProductWithImage(
      idProductWithImage: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}id_product_with_image']),
      product:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}product']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || idProductWithImage != null) {
      map['id_product_with_image'] = Variable<int>(idProductWithImage);
    }
    if (!nullToAbsent || product != null) {
      map['product'] = Variable<String>(product);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  ProductWithImagesCompanion toCompanion(bool nullToAbsent) {
    return ProductWithImagesCompanion(
      idProductWithImage: idProductWithImage == null && nullToAbsent
          ? const Value.absent()
          : Value(idProductWithImage),
      product: product == null && nullToAbsent
          ? const Value.absent()
          : Value(product),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory ProductWithImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductWithImage(
      idProductWithImage: serializer.fromJson<int>(json['idProductWithImage']),
      product: serializer.fromJson<String>(json['product']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idProductWithImage': serializer.toJson<int>(idProductWithImage),
      'product': serializer.toJson<String>(product),
      'image': serializer.toJson<String>(image),
    };
  }

  ProductWithImage copyWith(
          {int idProductWithImage, String product, String image}) =>
      ProductWithImage(
        idProductWithImage: idProductWithImage ?? this.idProductWithImage,
        product: product ?? this.product,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('ProductWithImage(')
          ..write('idProductWithImage: $idProductWithImage, ')
          ..write('product: $product, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      idProductWithImage.hashCode, $mrjc(product.hashCode, image.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductWithImage &&
          other.idProductWithImage == this.idProductWithImage &&
          other.product == this.product &&
          other.image == this.image);
}

class ProductWithImagesCompanion extends UpdateCompanion<ProductWithImage> {
  final Value<int> idProductWithImage;
  final Value<String> product;
  final Value<String> image;
  const ProductWithImagesCompanion({
    this.idProductWithImage = const Value.absent(),
    this.product = const Value.absent(),
    this.image = const Value.absent(),
  });
  ProductWithImagesCompanion.insert({
    this.idProductWithImage = const Value.absent(),
    @required String product,
    @required String image,
  })  : product = Value(product),
        image = Value(image);
  static Insertable<ProductWithImage> custom({
    Expression<int> idProductWithImage,
    Expression<String> product,
    Expression<String> image,
  }) {
    return RawValuesInsertable({
      if (idProductWithImage != null)
        'id_product_with_image': idProductWithImage,
      if (product != null) 'product': product,
      if (image != null) 'image': image,
    });
  }

  ProductWithImagesCompanion copyWith(
      {Value<int> idProductWithImage,
      Value<String> product,
      Value<String> image}) {
    return ProductWithImagesCompanion(
      idProductWithImage: idProductWithImage ?? this.idProductWithImage,
      product: product ?? this.product,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idProductWithImage.present) {
      map['id_product_with_image'] = Variable<int>(idProductWithImage.value);
    }
    if (product.present) {
      map['product'] = Variable<String>(product.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductWithImagesCompanion(')
          ..write('idProductWithImage: $idProductWithImage, ')
          ..write('product: $product, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $ProductWithImagesTable extends ProductWithImages
    with TableInfo<$ProductWithImagesTable, ProductWithImage> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductWithImagesTable(this._db, [this._alias]);
  final VerificationMeta _idProductWithImageMeta =
      const VerificationMeta('idProductWithImage');
  GeneratedIntColumn _idProductWithImage;
  @override
  GeneratedIntColumn get idProductWithImage =>
      _idProductWithImage ??= _constructIdProductWithImage();
  GeneratedIntColumn _constructIdProductWithImage() {
    return GeneratedIntColumn('id_product_with_image', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _productMeta = const VerificationMeta('product');
  GeneratedTextColumn _product;
  @override
  GeneratedTextColumn get product => _product ??= _constructProduct();
  GeneratedTextColumn _constructProduct() {
    return GeneratedTextColumn(
      'product',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [idProductWithImage, product, image];
  @override
  $ProductWithImagesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_with_images';
  @override
  final String actualTableName = 'product_with_images';
  @override
  VerificationContext validateIntegrity(Insertable<ProductWithImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_product_with_image')) {
      context.handle(
          _idProductWithImageMeta,
          idProductWithImage.isAcceptableOrUnknown(
              data['id_product_with_image'], _idProductWithImageMeta));
    }
    if (data.containsKey('product')) {
      context.handle(_productMeta,
          product.isAcceptableOrUnknown(data['product'], _productMeta));
    } else if (isInserting) {
      context.missing(_productMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idProductWithImage};
  @override
  ProductWithImage map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductWithImage.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductWithImagesTable createAlias(String alias) {
    return $ProductWithImagesTable(_db, alias);
  }
}

abstract class _$MyProductInfoDB extends GeneratedDatabase {
  _$MyProductInfoDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ProductRecordsTable _productRecords;
  $ProductRecordsTable get productRecords =>
      _productRecords ??= $ProductRecordsTable(this);
  $ProductRecordImagesTable _productRecordImages;
  $ProductRecordImagesTable get productRecordImages =>
      _productRecordImages ??= $ProductRecordImagesTable(this);
  $ProductWithImagesTable _productWithImages;
  $ProductWithImagesTable get productWithImages =>
      _productWithImages ??= $ProductWithImagesTable(this);
  ProductInfoDao _productInfoDao;
  ProductInfoDao get productInfoDao =>
      _productInfoDao ??= ProductInfoDao(this as MyProductInfoDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [productRecords, productRecordImages, productWithImages];
}
