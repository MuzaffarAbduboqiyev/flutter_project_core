import 'package:delivery_service/util/service/network/parser_service.dart';

class PaymentModel {
  final int id;
  final String name;
  final String description;

  PaymentModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory PaymentModel.example() => PaymentModel(
        id: 0,
        name: "",
        description: "",
      );

  factory PaymentModel.fromMap(Map<String, dynamic> response) => PaymentModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        description: parseToString(response: response, key: "description"),
      );

  PaymentModel copyWith({
    int? id,
    String? name,
    String? description,
  }) =>
      PaymentModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );
}

List<PaymentModel> parsePaymentModel(response) {
  final List<PaymentModel> paymentModel = [];

  if (response is List) {
    for (var element in response) {
      final PaymentModel productModel = PaymentModel.fromMap(element);
      paymentModel.add(productModel);
    }
  }

  return paymentModel;
}
