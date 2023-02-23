enum OrdersStatus {
  init, // boshlang'ich
  loading, // yuklash
  loaded, // yuklangan
  error, // xato
}

class OrdersState {
  final OrdersStatus ordersStatus;
  final String error;

  OrdersState({
    required this.ordersStatus,
    required this.error,
  });

  factory OrdersState.initial() => OrdersState(
        ordersStatus: OrdersStatus.init,
        error: "",
      );

  OrdersState copyWith({
    OrdersStatus? ordersStatus,
    String? error,
  }) =>
      OrdersState(
        ordersStatus: ordersStatus ?? this.ordersStatus,
        error: error ?? this.error,
      );
}
