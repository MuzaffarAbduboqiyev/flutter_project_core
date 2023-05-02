import 'package:delivery_service/model/orders_model/address_model.dart';
import 'package:delivery_service/model/orders_model/orders_product_model.dart';
import 'package:delivery_service/model/orders_model/orders_shipping_model.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';

class OrdersModel {
  final int id;
  final String status;
  final int subtotal;
  final int total;
  final String vendorName;
  final List<OrdersProductsModel> ordersProductsModel;
  final AddressModel addressModel;
  final OrdersShippingModel ordersShippingModel;

  OrdersModel({
    required this.id,
    required this.status,
    required this.subtotal,
    required this.total,
    required this.vendorName,
    required this.ordersProductsModel,
    required this.addressModel,
    required this.ordersShippingModel,
  });

  factory OrdersModel.example() => OrdersModel(
        id: 0,
        status: "",
        subtotal: 0,
        total: 0,
        vendorName: "",
        ordersProductsModel: [],
        addressModel: AddressModel.example(),
        ordersShippingModel: OrdersShippingModel.example(),
      );

  factory OrdersModel.fromMap(Map<String, dynamic> response) => OrdersModel(
        id: parseToInt(response: response, key: "id"),
        status: parseToString(response: response, key: "status"),
        subtotal: parseToInt(response: response, key: "subtotal"),
        total: parseToInt(response: response, key: "total"),
        vendorName: parseToString(response: response, key: "vendor_name"),
        ordersProductsModel: parseOrdersProductModel(response["products"]),
        addressModel: AddressModel.fromMap(response["address"]),
        ordersShippingModel:
            OrdersShippingModel.fromMap(response["shipping_method"]),
      );
}

List<OrdersModel> parseOrdersModel(response) {
  final List<OrdersModel> ordersModel = [];

  if (response is List) {
    for (var element in response) {
      final OrdersModel productModel = OrdersModel.fromMap(element);
      ordersModel.add(productModel);
    }
  }

  return ordersModel;
}
