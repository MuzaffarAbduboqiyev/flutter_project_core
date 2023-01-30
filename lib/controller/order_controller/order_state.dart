import 'package:delivery_service/model/local_database/moor_database.dart';

enum OrderStatus {
  init,
  loading,
  loaded,
  cartChanged,
  error,
}

class OrderState {
  final OrderStatus orderStatus;
  final List<ProductCartData> products;
  final List<LocationData> location;
  final int price;
  final String error;

  OrderState({
    required this.orderStatus,
    required this.products,
    required this.location,
    required this.price,
    required this.error,
  });

  factory OrderState.initial() => OrderState(
        orderStatus: OrderStatus.init,
        products: [],
        location: [],
        price: 0,
        error: "",
      );

  OrderState copyWith({
    OrderStatus? orderStatus,
    List<ProductCartData>? products,
    List<LocationData>? location,
    int? price,
    String? error,
  }) =>
      OrderState(
        orderStatus: orderStatus ?? this.orderStatus,
        products: products ?? this.products,
        location: location ?? this.location,
        price: price ?? this.price,
        error: error ?? this.error,
      );
}
