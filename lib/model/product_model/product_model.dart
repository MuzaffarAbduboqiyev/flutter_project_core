import 'package:delivery_service/model/restaurant_model/vendor_model.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';

class ProductModel {
  final int id;
  final String name;
  final String image;
  final bool available;
  final VendorModel vendor;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.available,
    required this.vendor,
  });

  factory ProductModel.example() => ProductModel(
        id: 0,
        name: "",
        image: "",
        available: false,
        vendor: VendorModel.example(),
      );

  factory ProductModel.fromMap(Map<String, dynamic> response) => ProductModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        image: parseToString(response: response, key: "image"),
        available: parseToBool(response: response, key: "is_available"),
        vendor: VendorModel.fromMap(response["vendor"]),
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
