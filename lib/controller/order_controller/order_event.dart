import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_variation_model.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderEvent {}

class OrderGetProductEvent extends OrderEvent {}

class OrderListenProductEvent extends OrderEvent {}

class OrderCartProductEvent extends OrderEvent {
  final List<ProductCartData> products;

  OrderCartProductEvent({required this.products});
}

class OrderUpdateProductEvent extends OrderEvent {
  final ProductCartData productsCart;

  OrderUpdateProductEvent({required this.productsCart});
}

class OrderDeleteProductEvent extends OrderEvent {
  final ProductCartData deleteProduct;
  final int productId;
  final int variationId;

  OrderDeleteProductEvent({
    required this.deleteProduct,
    required this.productId,
    required this.variationId,
  });
}

class OrderClearProductEvent extends OrderEvent {
  final int productId;
  final int variationId;

  OrderClearProductEvent({
    required this.productId,
    required this.variationId,
  });
}

/// order listen location
class OrderListenLocationEvent extends OrderEvent {
  final LocationData locationData;

  OrderListenLocationEvent({required this.locationData});
}

/// order shipping check button
class OrderShippingCheckButtonEvent extends OrderEvent {
  final int addressId;

  OrderShippingCheckButtonEvent({required this.addressId});
}

/// order request button
class OrderRequestButtonEvent extends OrderEvent {
  final int shippingId;
  final int shippingPrice;
  final String shippingName;

  OrderRequestButtonEvent({
    required this.shippingId,
    required this.shippingPrice,
    required this.shippingName,
  });
}

/// order listen token
class OrderListenTokenEvent extends OrderEvent {
  final bool token;

  OrderListenTokenEvent({required this.token});
}

/// order get token
class OrderGetTokenEvent extends OrderEvent {}

/// order refresh
class OrderRefreshProductsEvent extends OrderEvent {}
