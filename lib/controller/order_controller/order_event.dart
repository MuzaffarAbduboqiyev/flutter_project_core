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

  OrderDeleteProductEvent({required this.deleteProduct});
}

class OrderClearProductEvent extends OrderEvent {}

/// delete location
class OrderDeleteLocationEvent extends OrderEvent {}

/// listen location
class OrderListenLocationEvent extends OrderEvent {
  final List<LocationData> locations;

  OrderListenLocationEvent({required this.locations});
}

class OrderLocationEvent extends OrderEvent {
  final LocationData locationData;

  OrderLocationEvent({required this.locationData});
}
