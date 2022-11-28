import 'package:moor_flutter/moor_flutter.dart';

class ProductCart extends Table {
  IntColumn get productId => integer()();

  TextColumn get name => text()();

  Int64Column get price => int64()();

  IntColumn get count => integer()();

  BoolColumn get hasStock => boolean()();

  IntColumn get selectedCount => integer()();

  IntColumn get variationId => integer()();

  @override
  Set<Column>? get primaryKey => {
        productId,
        variationId,
      };
}
