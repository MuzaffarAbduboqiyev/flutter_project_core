import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/location_controller/location_repository.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_repository.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final LocationRepository locationRepository;
  late StreamSubscription streamSubscription;

  OrderBloc(
    super.initialState, {
    required this.orderRepository,
    required this.locationRepository,
  }) {
    on<OrderGetProductEvent>(
      _orderGetProduct,
      transformer: concurrent(),
    );

    on<OrderCartProductEvent>(
      _orderListenCartProduct,
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

    /// clear product
    on<OrderClearProductEvent>(
      _clearProduct,
      transformer: concurrent(),
    );

    /// listen location
    on<OrderListenLocationEvent>(
      _listenLocation,
      transformer: concurrent(),
    );

    on<OrderShippingCheckButtonEvent>(
      _orderShippingEvent,
      transformer: concurrent(),
    );
    on<OrderRequestButtonEvent>(
      _orderShippingRequestEvent,
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

    streamSubscription = orderRepository.listenCartProducts().listen((event) {
      event.sort((a, b) => a.price.compareTo(b.price));
      add(OrderCartProductEvent(products: event));
    });
    streamSubscription = locationRepository.listenLocation().listen((location) {
      final selectedLocation = location.firstWhere(
        (element) => element.selectedStatus,
        orElse: () => LocationData(
          id: 0,
          lat: "",
          lng: "",
          address: "",
          comment: "",
          updated: "",
          created: "",
          defaults: false,
          selectedStatus: false,
        ),
      );

      add(OrderListenLocationEvent(locationData: selectedLocation));
    });
  }

  /// listen location
  FutureOr<void> _listenLocation(
      OrderListenLocationEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        locationData: event.locationData,
      ),
    );
  }

  /// get token
  FutureOr<void> _getToken(
      OrderGetTokenEvent event, Emitter<OrderState> emit) async {
    final response = await orderRepository.getTokenInfo();
    emit(
      state.copyWith(
        token: response,
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

  FutureOr<void> _orderShippingRequestEvent(
      OrderRequestButtonEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        shippingStatus: ShippingStatus.init,
        shippingId: event.shippingId,
        shippingPrice: event.shippingPrice,
        shippingName: event.shippingName,
      ),
    );
  }

  /// order shipping
  FutureOr<void> _orderShippingEvent(
      OrderShippingCheckButtonEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        shippingStatus: ShippingStatus.loading,
      ),
    );

    final response =
        await orderRepository.getOrderShipping(addressId: event.addressId);

    emit(
      state.copyWith(
        shippingStatus:
            (response.status) ? ShippingStatus.loaded : ShippingStatus.error,
        orderModel: response.data,
        error: response.message,
      ),
    );
  }

  FutureOr<void> _orderGetProduct(
      OrderGetProductEvent event, Emitter<OrderState> emit) {
    emit(
      state.copyWith(products: state.products),
    );
  }

  FutureOr<void> _orderListenCartProduct(
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
    await orderRepository.updateCart(cartData: event.productsCart);
  }

  FutureOr<void> _deleteCartProduct(
      OrderDeleteProductEvent event, Emitter<OrderState> emit) async {
    await orderRepository.deleteCart(
      deleteCartData: event.deleteProduct,
      variationId: event.variationId,
      productId: event.productId,
    );
  }

  FutureOr<void> _clearProduct(
      OrderClearProductEvent event, Emitter<OrderState> emit) async {
    await orderRepository.clearOrderHistory(
      productId: event.productId,
      variationId: event.variationId,
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
