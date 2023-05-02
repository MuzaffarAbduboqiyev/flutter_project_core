import 'package:delivery_service/util/service/network/parser_service.dart';

class OrdersProductsModel {
  final int id;
  final String name;
  final int price;
  final bool priceVaries;
  final int count;
  final bool hasStock;
  final bool available;
  final int quantity;

  OrdersProductsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.priceVaries,
    required this.count,
    required this.hasStock,
    required this.available,
    required this.quantity,
  });

  factory OrdersProductsModel.example() => OrdersProductsModel(
        id: 0,
        name: "",
        price: 0,
        priceVaries: false,
        count: 0,
        hasStock: false,
        available: false,
        quantity: 0,
      );

  factory OrdersProductsModel.fromMap(Map<String, dynamic> response) =>
      OrdersProductsModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        price: parseToInt(response: response, key: "price"),
        priceVaries: parseToBool(response: response, key: "price_varies"),
        count: parseToInt(response: response, key: "stock_count"),
        hasStock: parseToBool(response: response, key: "in_stock"),
        available: parseToBool(response: response, key: "is_available"),
        quantity: parseToInt(response: response, key: "order_quantity"),
      );

  OrdersProductsModel copyWith({
    int? id,
    String? name,
    int? price,
    bool? priceVaries,
    int? count,
    bool? hasStock,
    bool? available,
    int? quantity,
  }) =>
      OrdersProductsModel(
          id: id ?? this.id,
          name: name ?? this.name,
          price: price ?? this.price,
          priceVaries: priceVaries ?? this.priceVaries,
          count: count ?? this.count,
          hasStock: hasStock ?? this.hasStock,
          available: available ?? this.available,
          quantity: quantity ?? this.quantity);
}

List<OrdersProductsModel> parseOrdersProductModel(dynamic response) {
  final List<OrdersProductsModel> products = [];

  if (response is List) {
    for (var element in response) {
      final OrdersProductsModel ordersProductsModel =
          OrdersProductsModel.fromMap(element);
      products.add(ordersProductsModel);
    }
  }

  return products;
}
