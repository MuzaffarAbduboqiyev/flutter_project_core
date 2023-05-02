import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/orders_controller/orders_event.dart';
import 'package:delivery_service/controller/orders_controller/orders_repository.dart';
import 'package:delivery_service/controller/orders_controller/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository ordersRepository;
  late StreamSubscription streamSubscription;

  OrdersBloc(super.initialState, {required this.ordersRepository}) {
    /// get product
    on<OrdersProductsGetEvent>(
      _getOrdersProducts,
      transformer: concurrent(),
    );

    /// listen token
    on<OrdersListenTokenEvent>(
      _listenToken,
      transformer: concurrent(),
    );

    /// get token
    on<OrdersGetTokenEvent>(
      _getToken,
      transformer: concurrent(),
    );

    streamSubscription = ordersRepository.listenToken().listen((event) {
      add(OrdersListenTokenEvent(token: event.value));
    });
  }

  FutureOr<void> _getOrdersProducts(
      OrdersProductsGetEvent event, Emitter<OrdersState> emit) async {
    emit(
      state.copyWith(
        ordersStatus: OrdersStatus.loading,
      ),
    );

    final response = await ordersRepository.getOrders();
    print("OrdersBlo ordersBlocc: $response");
    emit(
      state.copyWith(
        ordersStatus:
            (response.status) ? OrdersStatus.loaded : OrdersStatus.error,
        ordersModel: response.data,
        error: response.message,
      ),
    );
  }

  /// listen token
  FutureOr<void> _listenToken(
      OrdersListenTokenEvent event, Emitter<OrdersState> emit) async {
    emit(
      state.copyWith(
        token: event.token,
      ),
    );
  }

  /// get token
  FutureOr<void> _getToken(
      OrdersGetTokenEvent event, Emitter<OrdersState> emit) async {
    final response = await ordersRepository.getToken();

    emit(
      state.copyWith(
        token: response,
      ),
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
