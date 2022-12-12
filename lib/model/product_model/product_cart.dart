import 'package:moor_flutter/moor_flutter.dart';

class ProductCart extends Table {
  IntColumn get productId => integer()();

  TextColumn get name => text()();

  IntColumn get price => integer()();

  IntColumn get count => integer()();

  TextColumn get image => text()();

  BoolColumn get hasStock => boolean()();

  IntColumn get selectedCount => integer()();

  IntColumn get variationId => integer()();

  @override
  Set<Column>? get primaryKey => {
        productId,
        variationId,
      };
}
