import 'package:delivery_service/model/product_model/product_cart_variation_model.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';

class ProductCartModel {
  final int id;
  final int price;
  final int quantity;
  final String count;
  final List<ProductCartVariationModel> cartVariationModel;

  ProductCartModel({
    required this.id,
    required this.price,
    required this.quantity,
    required this.count,
    required this.cartVariationModel,
  });

  factory ProductCartModel.example() => ProductCartModel(
        id: 0,
        price: 0,
        quantity: 0,
        count: "",
        cartVariationModel: [],
      );

  factory ProductCartModel.fromMap(Map<String, dynamic> response) =>
      ProductCartModel(
        id: parseToInt(response: response, key: "id"),
        price: parseToInt(response: response, key: "price"),
        quantity: parseToInt(response: response, key: "quantity"),
        count: parseToString(response: response, key: "stock_count"),
        cartVariationModel:
            parseCartProductModel(response["product"], "product"),
      );
}
