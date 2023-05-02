import 'package:delivery_service/model/orders_model/orders_model.dart';

enum OrdersStatus {
  init,
  loading,
  loaded,
  error,
}

class OrdersState {
  final OrdersStatus ordersStatus;
  final List<OrdersModel> ordersModel;
  final bool token;
  final String error;

  OrdersState({
    required this.ordersStatus,
    required this.ordersModel,
    required this.token,
    required this.error,
  });

  factory OrdersState.initial() => OrdersState(
        ordersStatus: OrdersStatus.init,
        ordersModel: [],
        token: false,
        error: "",
      );

  OrdersState copyWith({
    OrdersStatus? ordersStatus,
    List<OrdersModel>? ordersModel,
    bool? token,
    String? error,
  }) =>
      OrdersState(
        ordersStatus: ordersStatus ?? this.ordersStatus,
        ordersModel: ordersModel ?? this.ordersModel,
        token: token ?? this.token,
        error: error ?? this.error,
      );
}
