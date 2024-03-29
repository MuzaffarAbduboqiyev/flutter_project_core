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
  final int restaurantId;
  final int productId;
  final String name;
  final int price;
  final int count;
  final String image;
  final bool hasStock;
  final int selectedCount;
  final int variationId;
  ProductCartData(
      {required this.restaurantId,
      required this.productId,
      required this.name,
      required this.price,
      required this.count,
      required this.image,
      required this.hasStock,
      required this.selectedCount,
      required this.variationId});
  factory ProductCartData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductCartData(
      restaurantId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}restaurant_id'])!,
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      price: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      count: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}count'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
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
    map['restaurant_id'] = Variable<int>(restaurantId);
    map['product_id'] = Variable<int>(productId);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<int>(price);
    map['count'] = Variable<int>(count);
    map['image'] = Variable<String>(image);
    map['has_stock'] = Variable<bool>(hasStock);
    map['selected_count'] = Variable<int>(selectedCount);
    map['variation_id'] = Variable<int>(variationId);
    return map;
  }

  ProductCartCompanion toCompanion(bool nullToAbsent) {
    return ProductCartCompanion(
      restaurantId: Value(restaurantId),
      productId: Value(productId),
      name: Value(name),
      price: Value(price),
      count: Value(count),
      image: Value(image),
      hasStock: Value(hasStock),
      selectedCount: Value(selectedCount),
      variationId: Value(variationId),
    );
  }

  factory ProductCartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductCartData(
      restaurantId: serializer.fromJson<int>(json['restaurantId']),
      productId: serializer.fromJson<int>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<int>(json['price']),
      count: serializer.fromJson<int>(json['count']),
      image: serializer.fromJson<String>(json['image']),
      hasStock: serializer.fromJson<bool>(json['hasStock']),
      selectedCount: serializer.fromJson<int>(json['selectedCount']),
      variationId: serializer.fromJson<int>(json['variationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'restaurantId': serializer.toJson<int>(restaurantId),
      'productId': serializer.toJson<int>(productId),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<int>(price),
      'count': serializer.toJson<int>(count),
      'image': serializer.toJson<String>(image),
      'hasStock': serializer.toJson<bool>(hasStock),
      'selectedCount': serializer.toJson<int>(selectedCount),
      'variationId': serializer.toJson<int>(variationId),
    };
  }

  ProductCartData copyWith(
          {int? restaurantId,
          int? productId,
          String? name,
          int? price,
          int? count,
          String? image,
          bool? hasStock,
          int? selectedCount,
          int? variationId}) =>
      ProductCartData(
        restaurantId: restaurantId ?? this.restaurantId,
        productId: productId ?? this.productId,
        name: name ?? this.name,
        price: price ?? this.price,
        count: count ?? this.count,
        image: image ?? this.image,
        hasStock: hasStock ?? this.hasStock,
        selectedCount: selectedCount ?? this.selectedCount,
        variationId: variationId ?? this.variationId,
      );
  @override
  String toString() {
    return (StringBuffer('ProductCartData(')
          ..write('restaurantId: $restaurantId, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('count: $count, ')
          ..write('image: $image, ')
          ..write('hasStock: $hasStock, ')
          ..write('selectedCount: $selectedCount, ')
          ..write('variationId: $variationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(restaurantId, productId, name, price, count,
      image, hasStock, selectedCount, variationId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCartData &&
          other.restaurantId == this.restaurantId &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.price == this.price &&
          other.count == this.count &&
          other.image == this.image &&
          other.hasStock == this.hasStock &&
          other.selectedCount == this.selectedCount &&
          other.variationId == this.variationId);
}

class ProductCartCompanion extends UpdateCompanion<ProductCartData> {
  final Value<int> restaurantId;
  final Value<int> productId;
  final Value<String> name;
  final Value<int> price;
  final Value<int> count;
  final Value<String> image;
  final Value<bool> hasStock;
  final Value<int> selectedCount;
  final Value<int> variationId;
  const ProductCartCompanion({
    this.restaurantId = const Value.absent(),
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.count = const Value.absent(),
    this.image = const Value.absent(),
    this.hasStock = const Value.absent(),
    this.selectedCount = const Value.absent(),
    this.variationId = const Value.absent(),
  });
  ProductCartCompanion.insert({
    required int restaurantId,
    required int productId,
    required String name,
    required int price,
    required int count,
    required String image,
    required bool hasStock,
    required int selectedCount,
    required int variationId,
  })  : restaurantId = Value(restaurantId),
        productId = Value(productId),
        name = Value(name),
        price = Value(price),
        count = Value(count),
        image = Value(image),
        hasStock = Value(hasStock),
        selectedCount = Value(selectedCount),
        variationId = Value(variationId);
  static Insertable<ProductCartData> custom({
    Expression<int>? restaurantId,
    Expression<int>? productId,
    Expression<String>? name,
    Expression<int>? price,
    Expression<int>? count,
    Expression<String>? image,
    Expression<bool>? hasStock,
    Expression<int>? selectedCount,
    Expression<int>? variationId,
  }) {
    return RawValuesInsertable({
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (count != null) 'count': count,
      if (image != null) 'image': image,
      if (hasStock != null) 'has_stock': hasStock,
      if (selectedCount != null) 'selected_count': selectedCount,
      if (variationId != null) 'variation_id': variationId,
    });
  }

  ProductCartCompanion copyWith(
      {Value<int>? restaurantId,
      Value<int>? productId,
      Value<String>? name,
      Value<int>? price,
      Value<int>? count,
      Value<String>? image,
      Value<bool>? hasStock,
      Value<int>? selectedCount,
      Value<int>? variationId}) {
    return ProductCartCompanion(
      restaurantId: restaurantId ?? this.restaurantId,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      count: count ?? this.count,
      image: image ?? this.image,
      hasStock: hasStock ?? this.hasStock,
      selectedCount: selectedCount ?? this.selectedCount,
      variationId: variationId ?? this.variationId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<int>(restaurantId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
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
          ..write('restaurantId: $restaurantId, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('count: $count, ')
          ..write('image: $image, ')
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
  final VerificationMeta _restaurantIdMeta =
      const VerificationMeta('restaurantId');
  @override
  late final GeneratedColumn<int?> restaurantId = GeneratedColumn<int?>(
      'restaurant_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
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
  late final GeneratedColumn<int?> price = GeneratedColumn<int?>(
      'price', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int?> count = GeneratedColumn<int?>(
      'count', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String?> image = GeneratedColumn<String?>(
      'image', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns => [
        restaurantId,
        productId,
        name,
        price,
        count,
        image,
        hasStock,
        selectedCount,
        variationId
      ];
  @override
  String get aliasedName => _alias ?? 'product_cart';
  @override
  String get actualTableName => 'product_cart';
  @override
  VerificationContext validateIntegrity(Insertable<ProductCartData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('restaurant_id')) {
      context.handle(
          _restaurantIdMeta,
          restaurantId.isAcceptableOrUnknown(
              data['restaurant_id']!, _restaurantIdMeta));
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
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
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
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

class LocationData extends DataClass implements Insertable<LocationData> {
  final int id;
  final String lat;
  final String lng;
  final bool defaults;
  final String address;
  final String comment;
  final String created;
  final String updated;
  final bool selectedStatus;
  LocationData(
      {required this.id,
      required this.lat,
      required this.lng,
      required this.defaults,
      required this.address,
      required this.comment,
      required this.created,
      required this.updated,
      required this.selectedStatus});
  factory LocationData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocationData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      lat: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat'])!,
      lng: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lng'])!,
      defaults: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}defaults'])!,
      address: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}address'])!,
      comment: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}comment'])!,
      created: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
      updated: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated'])!,
      selectedStatus: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}selected_status'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lat'] = Variable<String>(lat);
    map['lng'] = Variable<String>(lng);
    map['defaults'] = Variable<bool>(defaults);
    map['address'] = Variable<String>(address);
    map['comment'] = Variable<String>(comment);
    map['created'] = Variable<String>(created);
    map['updated'] = Variable<String>(updated);
    map['selected_status'] = Variable<bool>(selectedStatus);
    return map;
  }

  LocationCompanion toCompanion(bool nullToAbsent) {
    return LocationCompanion(
      id: Value(id),
      lat: Value(lat),
      lng: Value(lng),
      defaults: Value(defaults),
      address: Value(address),
      comment: Value(comment),
      created: Value(created),
      updated: Value(updated),
      selectedStatus: Value(selectedStatus),
    );
  }

  factory LocationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocationData(
      id: serializer.fromJson<int>(json['id']),
      lat: serializer.fromJson<String>(json['lat']),
      lng: serializer.fromJson<String>(json['lng']),
      defaults: serializer.fromJson<bool>(json['defaults']),
      address: serializer.fromJson<String>(json['address']),
      comment: serializer.fromJson<String>(json['comment']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
      selectedStatus: serializer.fromJson<bool>(json['selectedStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lat': serializer.toJson<String>(lat),
      'lng': serializer.toJson<String>(lng),
      'defaults': serializer.toJson<bool>(defaults),
      'address': serializer.toJson<String>(address),
      'comment': serializer.toJson<String>(comment),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
      'selectedStatus': serializer.toJson<bool>(selectedStatus),
    };
  }

  LocationData copyWith(
          {int? id,
          String? lat,
          String? lng,
          bool? defaults,
          String? address,
          String? comment,
          String? created,
          String? updated,
          bool? selectedStatus}) =>
      LocationData(
        id: id ?? this.id,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        defaults: defaults ?? this.defaults,
        address: address ?? this.address,
        comment: comment ?? this.comment,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        selectedStatus: selectedStatus ?? this.selectedStatus,
      );
  @override
  String toString() {
    return (StringBuffer('LocationData(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('defaults: $defaults, ')
          ..write('address: $address, ')
          ..write('comment: $comment, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('selectedStatus: $selectedStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lat, lng, defaults, address, comment,
      created, updated, selectedStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationData &&
          other.id == this.id &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.defaults == this.defaults &&
          other.address == this.address &&
          other.comment == this.comment &&
          other.created == this.created &&
          other.updated == this.updated &&
          other.selectedStatus == this.selectedStatus);
}

class LocationCompanion extends UpdateCompanion<LocationData> {
  final Value<int> id;
  final Value<String> lat;
  final Value<String> lng;
  final Value<bool> defaults;
  final Value<String> address;
  final Value<String> comment;
  final Value<String> created;
  final Value<String> updated;
  final Value<bool> selectedStatus;
  const LocationCompanion({
    this.id = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.defaults = const Value.absent(),
    this.address = const Value.absent(),
    this.comment = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.selectedStatus = const Value.absent(),
  });
  LocationCompanion.insert({
    required int id,
    required String lat,
    required String lng,
    required bool defaults,
    required String address,
    required String comment,
    required String created,
    required String updated,
    required bool selectedStatus,
  })  : id = Value(id),
        lat = Value(lat),
        lng = Value(lng),
        defaults = Value(defaults),
        address = Value(address),
        comment = Value(comment),
        created = Value(created),
        updated = Value(updated),
        selectedStatus = Value(selectedStatus);
  static Insertable<LocationData> custom({
    Expression<int>? id,
    Expression<String>? lat,
    Expression<String>? lng,
    Expression<bool>? defaults,
    Expression<String>? address,
    Expression<String>? comment,
    Expression<String>? created,
    Expression<String>? updated,
    Expression<bool>? selectedStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (defaults != null) 'defaults': defaults,
      if (address != null) 'address': address,
      if (comment != null) 'comment': comment,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
      if (selectedStatus != null) 'selected_status': selectedStatus,
    });
  }

  LocationCompanion copyWith(
      {Value<int>? id,
      Value<String>? lat,
      Value<String>? lng,
      Value<bool>? defaults,
      Value<String>? address,
      Value<String>? comment,
      Value<String>? created,
      Value<String>? updated,
      Value<bool>? selectedStatus}) {
    return LocationCompanion(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      defaults: defaults ?? this.defaults,
      address: address ?? this.address,
      comment: comment ?? this.comment,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lat.present) {
      map['lat'] = Variable<String>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<String>(lng.value);
    }
    if (defaults.present) {
      map['defaults'] = Variable<bool>(defaults.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    if (selectedStatus.present) {
      map['selected_status'] = Variable<bool>(selectedStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationCompanion(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('defaults: $defaults, ')
          ..write('address: $address, ')
          ..write('comment: $comment, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('selectedStatus: $selectedStatus')
          ..write(')'))
        .toString();
  }
}

class $LocationTable extends Location
    with TableInfo<$LocationTable, LocationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<String?> lat = GeneratedColumn<String?>(
      'lat', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<String?> lng = GeneratedColumn<String?>(
      'lng', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _defaultsMeta = const VerificationMeta('defaults');
  @override
  late final GeneratedColumn<bool?> defaults = GeneratedColumn<bool?>(
      'defaults', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (defaults IN (0, 1))');
  final VerificationMeta _addressMeta = const VerificationMeta('address');
  @override
  late final GeneratedColumn<String?> address = GeneratedColumn<String?>(
      'address', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _commentMeta = const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String?> comment = GeneratedColumn<String?>(
      'comment', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<String?> created = GeneratedColumn<String?>(
      'created', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String?> updated = GeneratedColumn<String?>(
      'updated', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _selectedStatusMeta =
      const VerificationMeta('selectedStatus');
  @override
  late final GeneratedColumn<bool?> selectedStatus = GeneratedColumn<bool?>(
      'selected_status', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (selected_status IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lat,
        lng,
        defaults,
        address,
        comment,
        created,
        updated,
        selectedStatus
      ];
  @override
  String get aliasedName => _alias ?? 'location';
  @override
  String get actualTableName => 'location';
  @override
  VerificationContext validateIntegrity(Insertable<LocationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('defaults')) {
      context.handle(_defaultsMeta,
          defaults.isAcceptableOrUnknown(data['defaults']!, _defaultsMeta));
    } else if (isInserting) {
      context.missing(_defaultsMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    } else if (isInserting) {
      context.missing(_commentMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    } else if (isInserting) {
      context.missing(_updatedMeta);
    }
    if (data.containsKey('selected_status')) {
      context.handle(
          _selectedStatusMeta,
          selectedStatus.isAcceptableOrUnknown(
              data['selected_status']!, _selectedStatusMeta));
    } else if (isInserting) {
      context.missing(_selectedStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, lat, lng};
  @override
  LocationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocationData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocationTable createAlias(String alias) {
    return $LocationTable(attachedDatabase, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchTable search = $SearchTable(this);
  late final $FavoriteTable favorite = $FavoriteTable(this);
  late final $ProductCartTable productCart = $ProductCartTable(this);
  late final $LocationTable location = $LocationTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [search, favorite, productCart, location];
}
