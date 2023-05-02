import 'package:moor_flutter/moor_flutter.dart';

class Location extends Table {
  IntColumn get id => integer()();

  TextColumn get lat => text()();

  TextColumn get lng => text()();

  BoolColumn get defaults => boolean()();

  TextColumn get address => text()();

  TextColumn get comment => text()();

  TextColumn get created => text()();

  TextColumn get updated => text()();

  BoolColumn get selectedStatus => boolean()();

  @override
  Set<Column>? get primaryKey => {id, lat, lng};
}
