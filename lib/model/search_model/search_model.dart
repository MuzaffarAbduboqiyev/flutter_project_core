import 'package:moor_flutter/moor_flutter.dart';

class Search extends Table {
  TextColumn get searchName => text()();

  @override
  Set<Column>? get primaryKey => {searchName};
}
