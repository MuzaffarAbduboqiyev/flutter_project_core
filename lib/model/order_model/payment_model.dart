import 'package:delivery_service/util/service/network/parser_service.dart';

class PaymentModel {
  final int id;
  final String name;
  final String description;
  final int locationId;
  final int shippingId;

  PaymentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.locationId,
    required this.shippingId,
  });

  factory PaymentModel.example() => PaymentModel(
        id: 0,
        name: "",
        description: "",
        locationId: 0,
        shippingId: 0,
      );

  factory PaymentModel.fromMap({
    required Map<String, dynamic> response,
    required int locationId,
    required int shippingId,
  }) =>
      PaymentModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        description: parseToString(response: response, key: "description"),
        locationId: locationId,
        shippingId: shippingId,
      );

  PaymentModel copyWith({
    int? id,
    String? name,
    String? description,
    int? locationId,
    int? shippingId,
  }) =>
      PaymentModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        locationId: locationId ?? this.locationId,
        shippingId: shippingId ?? this.shippingId,
      );
}

List<PaymentModel> parsePaymentModel(response, int locationId, int shippingId) {
  final List<PaymentModel> paymentModel = [];

  if (response is List) {
    for (var element in response) {
      final PaymentModel productModel = PaymentModel.fromMap(
        response: element,
        locationId: locationId,
        shippingId: shippingId,
      );
      paymentModel.add(productModel);
    }
  }

  return paymentModel;
}
