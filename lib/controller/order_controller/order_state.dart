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
  final int price;
  final String error;

  OrderState({
    required this.orderStatus,
    required this.products,
    required this.price,
    required this.error,
  });

  factory OrderState.initial() => OrderState(
        orderStatus: OrderStatus.init,
        products: [],
        price: 0,
        error: "",
      );

  OrderState copyWith({
    OrderStatus? orderStatus,
    List<ProductCartData>? products,
    int? price,
    String? error,
  }) =>
      OrderState(
        orderStatus: orderStatus ?? this.orderStatus,
        products: products ?? this.products,
        price: price ?? this.price,
        error: error ?? this.error,
      );
}
