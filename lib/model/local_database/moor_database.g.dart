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

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchTable search = $SearchTable(this);
  late final $FavoriteTable favorite = $FavoriteTable(this);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [search, favorite];
}
