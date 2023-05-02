import 'package:delivery_service/util/service/network/parser_service.dart';

class OrderShippingModel {
  final int id;
  final String name;
  final int price;

  OrderShippingModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory OrderShippingModel.example() => OrderShippingModel(
        id: 0,
        name: "",
        price: 0,
      );

  factory OrderShippingModel.fromMap(Map<String, dynamic> response) =>
      OrderShippingModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        price: parseToInt(response: response, key: "price"),
      );

  OrderShippingModel copWith({
    int? id,
    String? name,
    int? price,
  }) =>
      OrderShippingModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
      );
}

List<OrderShippingModel> parseShippingModel(response) {
  final List<OrderShippingModel> orderShippingModel = [];

  if (response is List) {
    for (var element in response) {
      final OrderShippingModel orderModel = OrderShippingModel.fromMap(element);
      orderShippingModel.add(orderModel);
    }
  }

  return orderShippingModel;
}
