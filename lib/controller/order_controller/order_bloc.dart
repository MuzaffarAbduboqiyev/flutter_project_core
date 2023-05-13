import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/location_controller/location_repository.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_repository.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/location_model/location_model.dart';
import 'package:delivery_service/model/order_model/payment_model.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';
import 'package:delivery_service/ui/order/order_payment/order_payment.dart';
import 'package:delivery_service/ui/order/order_shipping/order_shipping.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final LocationRepository locationRepository;
  late StreamSubscription locationListener;

  OrderBloc(
    super.initialState, {
    required this.orderRepository,
    required this.locationRepository,
  }) {
    on<OrderCartProductEvent>(
      _orderListenCartProduct,
      transformer: concurrent(),
    );

    on<OrderUpdateProductEvent>(
      _updateCartProduct,
      transformer: concurrent(),
    );

    /// delete product
    on<OrderDeleteProductEvent>(
      _deleteCartProduct,
      transformer: concurrent(),
    );

    /// get token
    on<OrderGetTokenEvent>(
      _getToken,
      transformer: concurrent(),
    );

    /// refresh product
    on<OrderRefreshProductsEvent>(
      _refreshProducts,
      transformer: concurrent(),
    );

    /// listen location
    on<OrderListenLocationEvent>(
      _listenLocation,
      transformer: concurrent(),
    );

    on<OrderGetShippingEvent>(
      _orderGetShippingEvent,
      transformer: concurrent(),
    );

    on<OrderSelectedShippingEvent>(
      _orderSelectedShippingEvent,
      transformer: concurrent(),
    );

    /// order get payments
    on<OrderGetPaymentsEvent>(
      _orderGetPaymentsEvent,
      transformer: concurrent(),
    );
    on<OrderSelectedPaymentEvent>(
      _orderSelectedPaymentEvent,
      transformer: concurrent(),
    );

    locationListener = orderRepository.listenCartProducts().listen((event) {
      event.sort((a, b) => a.price.compareTo(b.price));
      add(OrderCartProductEvent(products: event));
    });

    locationListener = locationRepository.listenLocation().listen((location) {
      final selectedLocation = location.firstWhere(
        (element) => element.selectedStatus,
        orElse: () => exampleLocationData,
      );

      add(OrderListenLocationEvent(locationData: selectedLocation));
    });
  }

  /// listen location
  FutureOr<void> _listenLocation(
      OrderListenLocationEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        selectedLocationData: event.locationData,
        shippingModels: (state.shippingModels.isNotEmpty &&
                state.shippingModels.first.locationId != event.locationData.id)
            ? []
            : state.shippingModels,
        selectedShippingModel:
            (state.selectedShippingModel.locationId != event.locationData.id)
                ? OrderShippingModel.example()
                : state.selectedShippingModel,
        paymentModels: (state.paymentModels.isNotEmpty &&
                state.paymentModels.first.locationId != event.locationData.id)
            ? []
            : state.paymentModels,
        selectedPaymentModel:
            (state.selectedPaymentModel.locationId != event.locationData.id)
                ? PaymentModel.example()
                : state.selectedPaymentModel,
      ),
    );
  }

  /// get token
  FutureOr<void> _getToken(
      OrderGetTokenEvent event, Emitter<OrderState> emit) async {
    final hasToken = await orderRepository.getTokenInfo();
    emit(
      state.copyWith(
        hasToken: hasToken,
      ),
    );
  }

  /// refresh product
  FutureOr<void> _refreshProducts(
      OrderRefreshProductsEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        orderStatus: OrderStatus.refreshing,
      ),
    );
    final response = await orderRepository.refreshProducts();

    emit(
      state.copyWith(
        orderStatus: (response.status) ? OrderStatus.loaded : OrderStatus.error,
        error: response.message,
      ),
    );
  }

  FutureOr<void> _orderSelectedShippingEvent(
      OrderSelectedShippingEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        selectedShippingModel: event.shippingModel,
        paymentModels: (state.paymentModels.isNotEmpty &&
                state.paymentModels.first.shippingId != event.shippingModel.id)
            ? []
            : state.paymentModels,
        selectedPaymentModel:
            (state.selectedPaymentModel.shippingId != event.shippingModel.id)
                ? PaymentModel.example()
                : state.selectedPaymentModel,
      ),
    );
  }

  /// order shipping
  FutureOr<void> _orderGetShippingEvent(
      OrderGetShippingEvent event, Emitter<OrderState> emit) async {
    if (state.shippingModels.isEmpty) {
      emit(
        state.copyWith(
          orderStatus: OrderStatus.loading,
        ),
      );

      final response = await orderRepository.getOrderShipping(
        addressId: state.selectedLocationData.id,
      );

      emit(
        state.copyWith(
          orderStatus:
              (response.status) ? OrderStatus.loaded : OrderStatus.error,
          shippingModels: response.data,
          error: response.message,
        ),
      );

      if (response.status) {
        showOrderShippingDialog(
          mainContext: event.context,
          shippingModels: response.data ?? [],
        );
      }
    } else {
      showOrderShippingDialog(
        mainContext: event.context,
        shippingModels: state.shippingModels,
      );
    }
  }

  FutureOr<void> _orderListenCartProduct(
      OrderCartProductEvent event, Emitter<OrderState> emit) {
    int price = 0;

    for (var element in event.products) {
      price += (element.price * element.selectedCount);
    }

    emit(
      state.copyWith(
        orderProducts: event.products,
        totalPrice: price,
      ),
    );
  }

  /// order get payments
  FutureOr<void> _orderGetPaymentsEvent(
      OrderGetPaymentsEvent event, Emitter<OrderState> emit) async {
    if (state.paymentModels.isEmpty) {
      emit(
        state.copyWith(
          orderStatus: OrderStatus.loading,
        ),
      );

      final response = await orderRepository.fetchPaymentModels(
        shippingId: state.selectedShippingModel.id,
        locationId: state.selectedLocationData.id,
      );

      emit(
        state.copyWith(
          orderStatus:
              (response.status) ? OrderStatus.loaded : OrderStatus.error,
          paymentModels: response.data,
          error: response.message,
        ),
      );

      if (response.status) {
        showOrderPaymentDialog(
          mainContext: event.context,
          paymentModels: response.data ?? [],
        );
      }
    } else {
      showOrderPaymentDialog(
        mainContext: event.context,
        paymentModels: state.paymentModels,
      );
    }
  }

  /// order selected payment
  FutureOr<void> _orderSelectedPaymentEvent(
      OrderSelectedPaymentEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        selectedPaymentModel: event.paymentModel,
      ),
    );

  }

  /// update cart product
  FutureOr<void> _updateCartProduct(
      OrderUpdateProductEvent event, Emitter<OrderState> emit) async {
    await orderRepository.updateCart(cartData: event.productsCart);
  }

  /// delete cart product
  FutureOr<void> _deleteCartProduct(
      OrderDeleteProductEvent event, Emitter<OrderState> emit) async {
    await orderRepository.deleteCart(
      deleteCartData: event.deleteProduct,
      variationId: event.variationId,
      productId: event.productId,
    );
  }

  @override
  Future<void> close() {
    locationListener.cancel();
    return super.close();
  }
}
