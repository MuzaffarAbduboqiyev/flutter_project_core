import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class OrderEvent {}

class OrderGetProductEvent extends OrderEvent {}

class OrderListenProductEvent extends OrderEvent {}

class OrderRefreshProductEvent extends OrderEvent {}

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
