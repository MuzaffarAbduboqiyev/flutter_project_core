import 'package:delivery_service/util/service/network/parser_service.dart';

class ProductModel {
  final int id;
  final int restaurantId;
  final String name;
  final String excerpt;
  final int price;
  final int count;
  final bool hasStock;
  final String image;
  final bool popular;
  final bool available;
  final int selectedCount;

  ProductModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.excerpt,
    required this.price,
    required this.count,
    required this.hasStock,
    required this.image,
    required this.popular,
    required this.available,
    required this.selectedCount,
  });

  factory ProductModel.example() => ProductModel(
        id: 0,
        restaurantId: 0,
        name: "",
        excerpt: "",
        price: 0,
        count: 0,
        hasStock: false,
        image: "",
        popular: false,
        available: false,
        selectedCount: 0,
      );

  factory ProductModel.fromMap(Map<String, dynamic> response) => ProductModel(
        id: parseToInt(response: response, key: "id"),
        restaurantId: parseToInt(response: response, key: "restaurant_id"),
        name: parseToString(response: response, key: "name"),
        excerpt: parseToString(response: response, key: "excerpt"),
        price: parseToPrice(response: response, key: "price"),
        count: parseToInt(response: response, key: "stock_count"),
        hasStock: parseToBool(response: response, key: "in_stock"),
        image: parseToString(response: response, key: "image"),
        popular: parseToBool(response: response, key: "is_popular"),
        available: parseToBool(response: response, key: "is_available"),
        selectedCount: parseToInt(response: response, key: "selected_count"),
      );

  ProductModel copyWith({
    int? id,
    String? name,
    int? restaurantId,
    String? excerpt,
    int? price,
    int? count,
    bool? hasStock,
    String? image,
    bool? popular,
    bool? available,
    int? selectedCount,
  }) =>
      ProductModel(
        id: id ?? this.id,
        restaurantId: restaurantId ?? this.restaurantId,
        name: name ?? this.name,
        excerpt: excerpt ?? this.excerpt,
        price: price ?? this.price,
        count: count ?? this.count,
        hasStock: hasStock ?? this.hasStock,
        image: image ?? this.image,
        popular: popular ?? this.popular,
        available: available ?? this.available,
        selectedCount: selectedCount ?? this.selectedCount,
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
