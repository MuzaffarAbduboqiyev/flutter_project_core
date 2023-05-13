import 'package:delivery_service/util/service/network/parser_service.dart';

class OrderShippingModel {
  final int id;
  final String name;
  final int price;
  final int locationId;

  OrderShippingModel({
    required this.id,
    required this.name,
    required this.price,
    required this.locationId,
  });

  factory OrderShippingModel.example() => OrderShippingModel(
        id: 0,
        name: "",
        price: 0,
        locationId: 0,
      );

  factory OrderShippingModel.fromMap(
          {required Map<String, dynamic> response, required int locationId}) =>
      OrderShippingModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        price: parseToInt(response: response, key: "price"),
        locationId: locationId,
      );

  OrderShippingModel copWith({
    int? id,
    String? name,
    int? price,
    int? locationId,
  }) =>
      OrderShippingModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        locationId: locationId ?? this.locationId,
      );
}

List<OrderShippingModel> parseShippingModel(response, int locationId) {
  final List<OrderShippingModel> orderShippingModel = [];

  if (response is List) {
    for (var element in response) {
      final OrderShippingModel orderModel =
          OrderShippingModel.fromMap(response: element, locationId: locationId);
      orderShippingModel.add(orderModel);
    }
  }

  return orderShippingModel;
}
