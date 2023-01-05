import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_repository.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  late StreamSubscription listenerLocation;
  late StreamSubscription listenerOrderProducts;

  OrderBloc(
    super.initialState, {
    required this.orderRepository,
  }) {
    on<OrderGetProductEvent>(
      _orderGetProduct,
      transformer: concurrent(),
    );

    on<OrderListenProductEvent>(
      _orderListenProduct,
      transformer: concurrent(),
    );

    on<OrderListenLocationEvent>(
      _orderListenLocation,
      transformer: concurrent(),
    );

    on<OrderCartProductEvent>(
      _orderCartProduct,
      transformer: concurrent(),
    );

    on<OrderUpdateProductEvent>(
      _updateCartProduct,
      transformer: concurrent(),
    );

    on<OrderDeleteProductEvent>(
      _deleteCartProduct,
      transformer: concurrent(),
    );
    on<OrderClearProductEvent>(
      _clearProduct,
      transformer: concurrent(),
    );

    on<OrderLocationEvent>(
      _changeLocationSelectedStatus,
      transformer: concurrent(),
    );

    listenerOrderProducts =
        orderRepository.listenCartProducts().listen((event) {
      event.sort((a, b) => a.price.compareTo(b.price));
      add(OrderCartProductEvent(products: event));
    });

    listenerLocation = orderRepository.listenLocations().listen((location) {
      final l = location;
      l.sort((a,b) => a.lat.compareTo(b.lat));
      add(OrderListenLocationEvent(locations: l));
    });
  }

  FutureOr<void> _orderGetProduct(
      OrderGetProductEvent event, Emitter<OrderState> emit) {}

  FutureOr<void> _orderListenProduct(
      OrderListenProductEvent event, Emitter<OrderState> emit) {}

  FutureOr<void> _orderListenLocation(
      OrderListenLocationEvent event, Emitter<OrderState> emit) {
    emit(
      state.copyWith(
        location: event.locations,
      ),
    );
  }

  FutureOr<void> _orderCartProduct(
      OrderCartProductEvent event, Emitter<OrderState> emit) {
    int price = 0;

    for (var element in event.products) {
      price += (element.price * element.selectedCount);
    }

    emit(
      state.copyWith(
        products: event.products,
        price: price,
      ),
    );
  }

  FutureOr<void> _updateCartProduct(
      OrderUpdateProductEvent event, Emitter<OrderState> emit) async {
    final response =
        await orderRepository.updateCart(cartData: event.productsCart);
  }

  FutureOr<void> _deleteCartProduct(
      OrderDeleteProductEvent event, Emitter<OrderState> emit) async {
    final response =
        await orderRepository.deleteCart(deleteCartData: event.deleteProduct);
  }

  FutureOr<void> _clearProduct(
      OrderClearProductEvent event, Emitter<OrderState> emit) async {
    await orderRepository.clearOrderHistory();
  }

  FutureOr<void> _changeLocationSelectedStatus(
      OrderLocationEvent event, Emitter<OrderState> emit) async {
    await orderRepository.changeSelectedLocation(
      locationData: event.locationData,
    );
  }
}
