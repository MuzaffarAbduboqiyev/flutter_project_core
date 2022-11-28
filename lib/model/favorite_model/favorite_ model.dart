
import 'package:moor_flutter/moor_flutter.dart';

class Favorite extends Table {

  IntColumn get id => integer()();

  TextColumn get name => text()();

  TextColumn get image => text()();

  RealColumn get rating => real()();

  TextColumn get affordability => text()();

  IntColumn get deliveryTime => integer()();

  BoolColumn get available => boolean()();

  @override
  Set<Column>? get primaryKey => {id};
}
