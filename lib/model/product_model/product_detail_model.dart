import 'package:delivery_service/model/product_model/product_variation_model.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';

class ProductDetailModel {
  final int id;
  final String name;
  final String excerpt;
  final int price;
  final int count;
  final bool hasStock;
  final String image;
  final bool popular;
  final bool available;
  final String description;
  final int selectedCount;
  final List<ProductVariationModel> variations;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.excerpt,
    required this.price,
    required this.count,
    required this.hasStock,
    required this.image,
    required this.popular,
    required this.available,
    required this.description,
    required this.selectedCount,
    required this.variations,
  });

  factory ProductDetailModel.example() => ProductDetailModel(
        id: 0,
        name: "",
        excerpt: "",
        price: 0,
        count: 0,
        hasStock: false,
        image: "",
        popular: false,
        available: false,
        description: "",
        selectedCount: 0,
        variations: <ProductVariationModel>[],
      );

  factory ProductDetailModel.fromMap(Map<String, dynamic> response) =>
      ProductDetailModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        excerpt: parseToString(response: response, key: "excerpt"),
        price: parseToPrice(response: response, key: "price"),
        count: parseToInt(response: response, key: "stock_count"),
        hasStock: parseToBool(response: response, key: "in_stock"),
        image: parseToString(response: response, key: "image"),
        popular: parseToBool(response: response, key: "is_popular"),
        available: parseToBool(response: response, key: "is_available"),
        description: parseToString(response: response, key: "description"),
        selectedCount: parseToInt(response: response, key: "selected_count"),
        variations: parseToProductVariation(response, "variations"),
      );
}
