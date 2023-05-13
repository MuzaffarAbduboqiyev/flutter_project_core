import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/order_model/payment_model.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';
import 'package:flutter/material.dart';

abstract class OrderEvent {}

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

/// order get token
class OrderGetTokenEvent extends OrderEvent {}

/// order refresh
class OrderRefreshProductsEvent extends OrderEvent {}

/// order listen location
class OrderListenLocationEvent extends OrderEvent {
  final LocationData locationData;

  OrderListenLocationEvent({required this.locationData});
}

/// order shipping check button
class OrderGetShippingEvent extends OrderEvent {
  final BuildContext context;

  OrderGetShippingEvent({
    required this.context,
  });
}

/// order request button
class OrderSelectedShippingEvent extends OrderEvent {
  final OrderShippingModel shippingModel;

  OrderSelectedShippingEvent({
    required this.shippingModel,
  });
}

/// order get payments event
class OrderGetPaymentsEvent extends OrderEvent {
  final BuildContext context;

  OrderGetPaymentsEvent({
    required this.context,
  });
}

/// order selected payment event
class OrderSelectedPaymentEvent extends OrderEvent {
  final PaymentModel paymentModel;

  OrderSelectedPaymentEvent({
    required this.paymentModel,
  });
}
