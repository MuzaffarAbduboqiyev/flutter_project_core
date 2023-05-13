import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';
import 'package:moor_flutter/moor_flutter.dart';

class ProductCart extends Table {
  IntColumn get restaurantId => integer()();

  IntColumn get productId => integer()();

  TextColumn get name => text()();

  IntColumn get price => integer()();

  IntColumn get count => integer()();

  TextColumn get image => text()();

  BoolColumn get hasStock => boolean()();

  IntColumn get selectedCount => integer()();

  IntColumn get variationId => integer()();

  @override
  Set<Column>? get primaryKey => {productId, variationId};
}

/// Parse to ProductCartData list from dynamic list
List<ProductCartData> parseProductCartDataList(List<dynamic> list) {
  return list.map((e) => parseProductCartData(e)).toList();
}

/// Parse to ProductCartData from dynamic
ProductCartData parseProductCartData(dynamic element) => ProductCartData(
      variationId: parseToInt(response: element, key: "id"),
      price: parseToInt(response: element, key: "price"),
      count: parseToInt(response: element, key: "quantity"),
      productId: parseToInt(response: element["product"], key: "id"),
      restaurantId:
          parseToInt(response: element["product"], key: "restaurant_id"),
      name: parseToString(response: element["product"], key: "name"),
      image: parseToString(response: element["product"], key: "image"),
      hasStock: parseToBool(response: element["product"], key: "in_stock"),
      selectedCount: parseToInt(response: element, key: "quantity"),
    );
