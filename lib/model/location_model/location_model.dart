import 'package:moor_flutter/moor_flutter.dart';

class Location extends Table {
  RealColumn get lat => real()(); // double

  RealColumn get lng => real()(); // double

  BoolColumn get selectedStatus => boolean()(); // true

  TextColumn get name => text().nullable()(); // String

  @override
  Set<Column>? get primaryKey => {
        lat,
        lng,
      };
}
