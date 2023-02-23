import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/orders_controller/orders_event.dart';
import 'package:delivery_service/controller/orders_controller/orders_repository.dart';
import 'package:delivery_service/controller/orders_controller/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository ordersRepository;

  OrdersBloc(
    super.initialState, {
    required this.ordersRepository,
  }) {
    on<OrdersInitialEvent>(
      _listen,
      transformer: concurrent(),
    );

    on<OrdersDeleteEvent>(
      _delete,
      transformer: concurrent(),
    );
  }

  FutureOr<void> _listen(
      OrdersInitialEvent event, Emitter<OrdersState> emit) async {}

  FutureOr<void> _delete(
      OrdersDeleteEvent event, Emitter<OrdersState> emit) async {}
}
