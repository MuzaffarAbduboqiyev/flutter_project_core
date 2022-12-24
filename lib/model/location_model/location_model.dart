import 'package:moor_flutter/moor_flutter.dart';

class Location extends Table {
  RealColumn get lat => real()();

  RealColumn get lng => real()();

  BoolColumn get selectedStatus => boolean()();

  TextColumn get name => text().nullable()();


}
