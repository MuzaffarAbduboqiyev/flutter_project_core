// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SearchData extends DataClass implements Insertable<SearchData> {
  final String searchName;
  SearchData({required this.searchName});
  factory SearchData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SearchData(
      searchName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}search_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['search_name'] = Variable<String>(searchName);
    return map;
  }

  SearchCompanion toCompanion(bool nullToAbsent) {
    return SearchCompanion(
      searchName: Value(searchName),
    );
  }

  factory SearchData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SearchData(
      searchName: serializer.fromJson<String>(json['searchName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'searchName': serializer.toJson<String>(searchName),
    };
  }

  SearchData copyWith({String? searchName}) => SearchData(
        searchName: searchName ?? this.searchName,
      );
  @override
  String toString() {
    return (StringBuffer('SearchData(')
          ..write('searchName: $searchName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => searchName.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchData && other.searchName == this.searchName);
}

class SearchCompanion extends UpdateCompanion<SearchData> {
  final Value<String> searchName;
  const SearchCompanion({
    this.searchName = const Value.absent(),
  });
  SearchCompanion.insert({
    required String searchName,
  }) : searchName = Value(searchName);
  static Insertable<SearchData> custom({
    Expression<String>? searchName,
  }) {
    return RawValuesInsertable({
      if (searchName != null) 'search_name': searchName,
    });
  }

  SearchCompanion copyWith({Value<String>? searchName}) {
    return SearchCompanion(
      searchName: searchName ?? this.searchName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (searchName.present) {
      map['search_name'] = Variable<String>(searchName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchCompanion(')
          ..write('searchName: $searchName')
          ..write(')'))
        .toString();
  }
}

class $SearchTable extends Search with TableInfo<$SearchTable, SearchData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _searchNameMeta = const VerificationMeta('searchName');
  @override
  late final GeneratedColumn<String?> searchName = GeneratedColumn<String?>(
      'search_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [searchName];
  @override
  String get aliasedName => _alias ?? 'search';
  @override
  String get actualTableName => 'search';
  @override
  VerificationContext validateIntegrity(Insertable<SearchData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('search_name')) {
      context.handle(
          _searchNameMeta,
          searchName.isAcceptableOrUnknown(
              data['search_name']!, _searchNameMeta));
    } else if (isInserting) {
      context.missing(_searchNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {searchName};
  @override
  SearchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SearchData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SearchTable createAlias(String alias) {
    return $SearchTable(attachedDatabase, alias);
  }
}

class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final int id;
  final String name;
  final String image;
  final double rating;
  final String affordability;
  final int deliveryTime;
  final bool available;
  FavoriteData(
      {required this.id,
      required this.name,
      required this.image,
      required this.rating,
      required this.affordability,
      required this.deliveryTime,
      required this.available});
  factory FavoriteData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      rating: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}rating'])!,
      affordability: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}affordability'])!,
      deliveryTime: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivery_time'])!,
      available: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}available'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image'] = Variable<String>(image);
    map['rating'] = Variable<double>(rating);
    map['affordability'] = Variable<String>(affordability);
    map['delivery_time'] = Variable<int>(deliveryTime);
    map['available'] = Variable<bool>(available);
    return map;
  }

  FavoriteCompanion toCompanion(bool nullToAbsent) {
    return FavoriteCompanion(
      id: Value(id),
      name: Value(name),
      image: Value(image),
      rating: Value(rating),
      affordability: Value(affordability),
      deliveryTime: Value(deliveryTime),
      available: Value(available),
    );
  }

  factory FavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FavoriteData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      rating: serializer.fromJson<double>(json['rating']),
      affordability: serializer.fromJson<String>(json['affordability']),
      deliveryTime: serializer.fromJson<int>(json['deliveryTime']),
      available: serializer.fromJson<bool>(json['available']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'rating': serializer.toJson<double>(rating),
      'affordability': serializer.toJson<String>(affordability),
      'deliveryTime': serializer.toJson<int>(deliveryTime),
      'available': serializer.toJson<bool>(available),
    };
  }

  FavoriteData copyWith(
          {int? id,
          String? name,
          String? image,
          double? rating,
          String? affordability,
          int? deliveryTime,
          bool? available}) =>
      FavoriteData(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        affordability: affordability ?? this.affordability,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        available: available ?? this.available,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('rating: $rating, ')
          ..write('affordability: $affordability, ')
          ..write('deliveryTime: $deliveryTime, ')
          ..write('available: $available')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, image, rating, affordability, deliveryTime, available);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteData &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image &&
          other.rating == this.rating &&
          other.affordability == this.affordability &&
          other.deliveryTime == this.deliveryTime &&
          other.available == this.available);
}

class FavoriteCompanion extends UpdateCompanion<FavoriteData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> image;
  final Value<double> rating;
  final Value<String> affordability;
  final Value<int> deliveryTime;
  final Value<bool> available;
  const FavoriteCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.rating = const Value.absent(),
    this.affordability = const Value.absent(),
    this.deliveryTime = const Value.absent(),
    this.available = const Value.absent(),
  });
  FavoriteCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String image,
    required double rating,
    required String affordability,
    required int deliveryTime,
    required bool available,
  })  : name = Value(name),
        image = Value(image),
        rating = Value(rating),
        affordability = Value(affordability),
        deliveryTime = Value(deliveryTime),
        available = Value(available);
  static Insertable<FavoriteData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? image,
    Expression<double>? rating,
    Expression<String>? affordability,
    Expression<int>? deliveryTime,
    Expression<bool>? available,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (rating != null) 'rating': rating,
      if (affordability != null) 'affordability': affordability,
      if (deliveryTime != null) 'delivery_time': deliveryTime,
      if (available != null) 'available': available,
    });
  }

  FavoriteCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? image,
      Value<double>? rating,
      Value<String>? affordability,
      Value<int>? deliveryTime,
      Value<bool>? available}) {
    return FavoriteCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      affordability: affordability ?? this.affordability,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      available: available ?? this.available,
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
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (affordability.present) {
      map['affordability'] = Variable<String>(affordability.value);
    }
    if (deliveryTime.present) {
      map['delivery_time'] = Variable<int>(deliveryTime.value);
    }
    if (available.present) {
      map['available'] = Variable<bool>(available.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('rating: $rating, ')
          ..write('affordability: $affordability, ')
          ..write('deliveryTime: $deliveryTime, ')
          ..write('available: $available')
          ..write(')'))
        .toString();
  }
}

class $FavoriteTable extends Favorite
    with TableInfo<$FavoriteTable, FavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String?> image = GeneratedColumn<String?>(
      'image', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double?> rating = GeneratedColumn<double?>(
      'rating', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _affordabilityMeta =
      const VerificationMeta('affordability');
  @override
  late final GeneratedColumn<String?> affordability = GeneratedColumn<String?>(
      'affordability', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _deliveryTimeMeta =
      const VerificationMeta('deliveryTime');
  @override
  late final GeneratedColumn<int?> deliveryTime = GeneratedColumn<int?>(
      'delivery_time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _availableMeta = const VerificationMeta('available');
  @override
  late final GeneratedColumn<bool?> available = GeneratedColumn<bool?>(
      'available', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (available IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, image, rating, affordability, deliveryTime, available];
  @override
  String get aliasedName => _alias ?? 'favorite';
  @override
  String get actualTableName => 'favorite';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteData> instance,
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
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('affordability')) {
      context.handle(
          _affordabilityMeta,
          affordability.isAcceptableOrUnknown(
              data['affordability']!, _affordabilityMeta));
    } else if (isInserting) {
      context.missing(_affordabilityMeta);
    }
    if (data.containsKey('delivery_time')) {
      context.handle(
          _deliveryTimeMeta,
          deliveryTime.isAcceptableOrUnknown(
              data['delivery_time']!, _deliveryTimeMeta));
    } else if (isInserting) {
      context.missing(_deliveryTimeMeta);
    }
    if (data.containsKey('available')) {
      context.handle(_availableMeta,
          available.isAcceptableOrUnknown(data['available']!, _availableMeta));
    } else if (isInserting) {
      context.missing(_availableMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoriteData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoriteTable createAlias(String alias) {
    return $FavoriteTable(attachedDatabase, alias);
  }
}

class ProductCartData extends DataClass implements Insertable<ProductCartData> {
  final int productId;
  final String name;
  final BigInt price;
  final int count;
  final bool hasStock;
  final int selectedCount;
  final int variationId;
  ProductCartData(
      {required this.productId,
      required this.name,
      required this.price,
      required this.count,
      required this.hasStock,
      required this.selectedCount,
      required this.variationId});
  factory ProductCartData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductCartData(
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      price: const BigIntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      count: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}count'])!,
      hasStock: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}has_stock'])!,
      selectedCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}selected_count'])!,
      variationId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}variation_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<int>(productId);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<BigInt>(price);
    map['count'] = Variable<int>(count);
    map['has_stock'] = Variable<bool>(hasStock);
    map['selected_count'] = Variable<int>(selectedCount);
    map['variation_id'] = Variable<int>(variationId);
    return map;
  }

  ProductCartCompanion toCompanion(bool nullToAbsent) {
    return ProductCartCompanion(
      productId: Value(productId),
      name: Value(name),
      price: Value(price),
      count: Value(count),
      hasStock: Value(hasStock),
      selectedCount: Value(selectedCount),
      variationId: Value(variationId),
    );
  }

  factory ProductCartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductCartData(
      productId: serializer.fromJson<int>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<BigInt>(json['price']),
      count: serializer.fromJson<int>(json['count']),
      hasStock: serializer.fromJson<bool>(json['hasStock']),
      selectedCount: serializer.fromJson<int>(json['selectedCount']),
      variationId: serializer.fromJson<int>(json['variationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<BigInt>(price),
      'count': serializer.toJson<int>(count),
      'hasStock': serializer.toJson<bool>(hasStock),
      'selectedCount': serializer.toJson<int>(selectedCount),
      'variationId': serializer.toJson<int>(variationId),
    };
  }

  ProductCartData copyWith(
          {int? productId,
          String? name,
          BigInt? price,
          int? count,
          bool? hasStock,
          int? selectedCount,
          int? variationId}) =>
      ProductCartData(
        productId: productId ?? this.productId,
        name: name ?? this.name,
        price: price ?? this.price,
        count: count ?? this.count,
        hasStock: hasStock ?? this.hasStock,
        selectedCount: selectedCount ?? this.selectedCount,
        variationId: variationId ?? this.variationId,
      );
  @override
  String toString() {
    return (StringBuffer('ProductCartData(')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('count: $count, ')
          ..write('hasStock: $hasStock, ')
          ..write('selectedCount: $selectedCount, ')
          ..write('variationId: $variationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      productId, name, price, count, hasStock, selectedCount, variationId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCartData &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.price == this.price &&
          other.count == this.count &&
          other.hasStock == this.hasStock &&
          other.selectedCount == this.selectedCount &&
          other.variationId == this.variationId);
}

class ProductCartCompanion extends UpdateCompanion<ProductCartData> {
  final Value<int> productId;
  final Value<String> name;
  final Value<BigInt> price;
  final Value<int> count;
  final Value<bool> hasStock;
  final Value<int> selectedCount;
  final Value<int> variationId;
  const ProductCartCompanion({
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.count = const Value.absent(),
    this.hasStock = const Value.absent(),
    this.selectedCount = const Value.absent(),
    this.variationId = const Value.absent(),
  });
  ProductCartCompanion.insert({
    required int productId,
    required String name,
    required BigInt price,
    required int count,
    required bool hasStock,
    required int selectedCount,
    required int variationId,
  })  : productId = Value(productId),
        name = Value(name),
        price = Value(price),
        count = Value(count),
        hasStock = Value(hasStock),
        selectedCount = Value(selectedCount),
        variationId = Value(variationId);
  static Insertable<ProductCartData> custom({
    Expression<int>? productId,
    Expression<String>? name,
    Expression<BigInt>? price,
    Expression<int>? count,
    Expression<bool>? hasStock,
    Expression<int>? selectedCount,
    Expression<int>? variationId,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (count != null) 'count': count,
      if (hasStock != null) 'has_stock': hasStock,
      if (selectedCount != null) 'selected_count': selectedCount,
      if (variationId != null) 'variation_id': variationId,
    });
  }

  ProductCartCompanion copyWith(
      {Value<int>? productId,
      Value<String>? name,
      Value<BigInt>? price,
      Value<int>? count,
      Value<bool>? hasStock,
      Value<int>? selectedCount,
      Value<int>? variationId}) {
    return ProductCartCompanion(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      count: count ?? this.count,
      hasStock: hasStock ?? this.hasStock,
      selectedCount: selectedCount ?? this.selectedCount,
      variationId: variationId ?? this.variationId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<BigInt>(price.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (hasStock.present) {
      map['has_stock'] = Variable<bool>(hasStock.value);
    }
    if (selectedCount.present) {
      map['selected_count'] = Variable<int>(selectedCount.value);
    }
    if (variationId.present) {
      map['variation_id'] = Variable<int>(variationId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCartCompanion(')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('count: $count, ')
          ..write('hasStock: $hasStock, ')
          ..write('selectedCount: $selectedCount, ')
          ..write('variationId: $variationId')
          ..write(')'))
        .toString();
  }
}

class $ProductCartTable extends ProductCart
    with TableInfo<$ProductCartTable, ProductCartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductCartTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'product_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<BigInt?> price = GeneratedColumn<BigInt?>(
      'price', aliasedName, false,
      type: const BigIntType(), requiredDuringInsert: true);
  final VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int?> count = GeneratedColumn<int?>(
      'count', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _hasStockMeta = const VerificationMeta('hasStock');
  @override
  late final GeneratedColumn<bool?> hasStock = GeneratedColumn<bool?>(
      'has_stock', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (has_stock IN (0, 1))');
  final VerificationMeta _selectedCountMeta =
      const VerificationMeta('selectedCount');
  @override
  late final GeneratedColumn<int?> selectedCount = GeneratedColumn<int?>(
      'selected_count', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _variationIdMeta =
      const VerificationMeta('variationId');
  @override
  late final GeneratedColumn<int?> variationId = GeneratedColumn<int?>(
      'variation_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [productId, name, price, count, hasStock, selectedCount, variationId];
  @override
  String get aliasedName => _alias ?? 'product_cart';
  @override
  String get actualTableName => 'product_cart';
  @override
  VerificationContext validateIntegrity(Insertable<ProductCartData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('has_stock')) {
      context.handle(_hasStockMeta,
          hasStock.isAcceptableOrUnknown(data['has_stock']!, _hasStockMeta));
    } else if (isInserting) {
      context.missing(_hasStockMeta);
    }
    if (data.containsKey('selected_count')) {
      context.handle(
          _selectedCountMeta,
          selectedCount.isAcceptableOrUnknown(
              data['selected_count']!, _selectedCountMeta));
    } else if (isInserting) {
      context.missing(_selectedCountMeta);
    }
    if (data.containsKey('variation_id')) {
      context.handle(
          _variationIdMeta,
          variationId.isAcceptableOrUnknown(
              data['variation_id']!, _variationIdMeta));
    } else if (isInserting) {
      context.missing(_variationIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId, variationId};
  @override
  ProductCartData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductCartData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductCartTable createAlias(String alias) {
    return $ProductCartTable(attachedDatabase, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchTable search = $SearchTable(this);
  late final $FavoriteTable favorite = $FavoriteTable(this);
  late final $ProductCartTable productCart = $ProductCartTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [search, favorite, productCart];
}
