import 'package:delivery_service/util/service/network/parser_service.dart';

class OrdersShippingModel {
  final int id;
  final String name;
  final int price;
  final String created_at;
  final String updated_at;

  OrdersShippingModel({
    required this.id,
    required this.name,
    required this.price,
    required this.created_at,
    required this.updated_at,
  });

  factory OrdersShippingModel.example() => OrdersShippingModel(
        id: 0,
        name: "",
        price: 0,
        created_at: "",
        updated_at: "",
      );

  factory OrdersShippingModel.fromMap(Map<String, dynamic> response) =>
      OrdersShippingModel(
        id: parseToInt(response: response, key: "id"),
        price: parseToInt(response: response, key: "price"),
        name: parseToString(response: response, key: "name"),
        created_at: parseToString(response: response, key: "created_at"),
        updated_at: parseToString(response: response, key: "updated_at"),
      );

  OrdersShippingModel copyWith({
    int? id,
    int? price,
    String? name,
    String? created_at,
    String? updated_at,
  }) =>
      OrdersShippingModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
      );
}
