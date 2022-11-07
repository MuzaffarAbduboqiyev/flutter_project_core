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

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchTable search = $SearchTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [search];
}
