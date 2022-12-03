import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';

class ProductVariationModel {
  final int id;
  final String name;
  final int price;
  final bool priceDiffer;
  final int count;
  final bool hasStock;
  final bool available;
  final int selectedCount;

  ProductVariationModel({
    required this.id,
    required this.name,
    required this.price,
    required this.priceDiffer,
    required this.count,
    required this.hasStock,
    required this.available,
    required this.selectedCount,
  });

  factory ProductVariationModel.example() => ProductVariationModel(
    id: 0,
    name: "",
    price: 0,
    priceDiffer: false,
    count: 0,
    hasStock: false,
    available: false,
    selectedCount: 0,
  );

  factory ProductVariationModel.fromMap(Map<String, dynamic> response) =>
      ProductVariationModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        price: parseToPrice(response: response, key: "price"),
        priceDiffer: parseToBool(response: response, key: "price_varies"),
        count: parseToInt(response: response, key: "stock_count"),
        hasStock: parseToBool(response: response, key: "in_stock"),
        available: parseToBool(response: response, key: "is_available"),
        selectedCount: parseToInt(response: response, key: "selected_count"),
      );

  ProductVariationModel copyWith({
    int? id,
    String? name,
    int? price,
    bool? priceDiffer,
    int? count,
    bool? hasStock,
    bool? available,
    int? selectedCount,
  }) =>
      ProductVariationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        priceDiffer: priceDiffer ?? this.priceDiffer,
        count: count ?? this.count,
        hasStock: hasStock ?? this.hasStock,
        available: available ?? this.available,
        selectedCount: selectedCount ?? this.selectedCount,
      );

  ProductCartData parseToCartModel(int productId) => ProductCartData(
        productId: productId,
        name: name,
        price: int.parse("$price"),
        count: count,
        hasStock: hasStock,
        selectedCount: selectedCount,
        variationId: id,
      );
}

List<ProductVariationModel> parseToProductVariation(dynamic response,
    String key,
) {
  final List<ProductVariationModel> items = [];
  if (response.containsKey(key) &&
      response[key] != null &&
      response[key] is List) {
    for (var element in response[key]) {
      final item = ProductVariationModel.fromMap(element);
      items.add(item);
    }
  }

  return items;
}
