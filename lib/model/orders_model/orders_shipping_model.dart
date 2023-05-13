import 'package:delivery_service/util/service/network/parser_service.dart';

class OrdersShippingModel {
  final int id;
  final String name;
  final int price;
  final String createdAt;
  final String updatedAt;

  OrdersShippingModel({
    required this.id,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrdersShippingModel.example() => OrdersShippingModel(
        id: 0,
        name: "",
        price: 0,
        createdAt: "",
        updatedAt: "",
      );

  factory OrdersShippingModel.fromMap(Map<String, dynamic> response) =>
      OrdersShippingModel(
        id: parseToInt(response: response, key: "id"),
        price: parseToInt(response: response, key: "price"),
        name: parseToString(response: response, key: "name"),
        createdAt: parseToString(response: response, key: "created_at"),
        updatedAt: parseToString(response: response, key: "updated_at"),
      );

  OrdersShippingModel copyWith({
    int? id,
    int? price,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      OrdersShippingModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
