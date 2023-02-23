import 'package:delivery_service/util/service/network/parser_service.dart';

class ProductCartVariationModel {
  final int id;
  final String name;
  final String excerpt;
  final int price;
  final int count;
  final bool hasStock;
  final String image;
  final bool popular;
  final bool available;

  ProductCartVariationModel({
    required this.id,
    required this.name,
    required this.excerpt,
    required this.price,
    required this.count,
    required this.image,
    required this.hasStock,
    required this.available,
    required this.popular,
  });

  factory ProductCartVariationModel.example() => ProductCartVariationModel(
        id: 0,
        name: "",
        excerpt: "",
        price: 0,
        count: 0,
        image: "",
        hasStock: false,
        available: false,
        popular: false,
      );

  factory ProductCartVariationModel.fromMap(Map<String, dynamic> response) =>
      ProductCartVariationModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        excerpt: parseToString(response: response, key: "excerpt"),
        price: parseToPrice(response: response, key: "price"),
        count: parseToInt(response: response, key: "stock_count"),
        hasStock: parseToBool(response: response, key: "in_stock"),
        image: parseToString(response: response, key: "image"),
        popular: parseToBool(response: response, key: "is_popular"),
        available: parseToBool(response: response, key: "is_available"),
      );

  ProductCartVariationModel copyWith({
    int? id,
    String? name,
    int? price,
    String? excerpt,
    String? image,
    int? count,
    bool? hasStock,
    bool? popular,
    bool? available,
  }) =>
      ProductCartVariationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        count: count ?? this.count,
        excerpt: excerpt ?? this.excerpt,
        image: image ?? this.image,
        hasStock: hasStock ?? this.hasStock,
        available: available ?? this.available,
        popular: popular ?? this.popular,
      );
}

List<ProductCartVariationModel> parseCartProductModel(
  dynamic response,
  String key,
) {
  final List<ProductCartVariationModel> products = [];

  if (response is List) {
    for (var element in response) {
      final ProductCartVariationModel productModel =
          ProductCartVariationModel.fromMap(element);
      products.add(productModel);
    }
  }

  return products;
}
