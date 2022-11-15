import 'package:delivery_service/util/service/network/parser_service.dart';

class ProductModel {
  final int id;
  final String name;
  final String excerpt;
  final num price;
  final int count;
  final bool hasStock;
  final String image;
  final bool popular;
  final bool available;

  ProductModel({
    required this.id,
    required this.name,
    required this.excerpt,
    required this.price,
    required this.count,
    required this.hasStock,
    required this.image,
    required this.popular,
    required this.available,
  });

  factory ProductModel.example() => ProductModel(
    id: 0,
        name: "",
        excerpt: "",
        price: 0,
        count: 0,
        hasStock: false,
        image: "",
        popular: false,
        available: false,
      );

  factory ProductModel.fromMap(Map<String, dynamic> response) => ProductModel(
    id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        excerpt: parseToString(response: response, key: "excerpt"),
        price: (parseToNum(response: response, key: "price") / 100),
        count: parseToInt(response: response, key: "stock_count"),
        hasStock: parseToBool(response: response, key: "in_stock"),
        image: parseToString(response: response, key: "image"),
        popular: parseToBool(response: response, key: "is_popular"),
        available: parseToBool(response: response, key: "is_available"),
      );
}

List<ProductModel> parseProductModel(dynamic response) {
  final List<ProductModel> products = [];

  if (response is List) {
    for (var element in response) {
      final ProductModel productModel = ProductModel.fromMap(element);
      products.add(productModel);
    }
  }

  return products;
}
