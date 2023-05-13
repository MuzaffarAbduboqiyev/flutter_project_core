import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/order_model/payment_model.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';

import '../../model/location_model/location_model.dart';

enum OrderStatus {
  init,
  loading,
  loaded,
  error,
  refreshing,
}

class OrderState {
  final OrderStatus orderStatus;
  final List<ProductCartData> orderProducts;
  final LocationData selectedLocationData;
  final List<OrderShippingModel> shippingModels;
  final OrderShippingModel selectedShippingModel;
  final List<PaymentModel> paymentModels;
  final PaymentModel selectedPaymentModel;
  final int totalPrice;
  final bool hasToken;
  final String error;

  OrderState({
    required this.orderStatus,
    required this.orderProducts,
    required this.selectedLocationData,
    required this.shippingModels,
    required this.selectedShippingModel,
    required this.paymentModels,
    required this.selectedPaymentModel,
    required this.totalPrice,
    required this.hasToken,
    required this.error,
  });

  factory OrderState.initial() => OrderState(
        orderStatus: OrderStatus.init,
        orderProducts: [],
        shippingModels: [],
        selectedLocationData: exampleLocationData,
        totalPrice: 0,
        selectedShippingModel: OrderShippingModel.example(),
        paymentModels: [],
        selectedPaymentModel: PaymentModel.example(),
        hasToken: false,
        error: "",
      );

  OrderState copyWith({
    OrderStatus? orderStatus,
    List<ProductCartData>? orderProducts,
    List<OrderShippingModel>? shippingModels,
    LocationData? selectedLocationData,
    int? totalPrice,
    OrderShippingModel? selectedShippingModel,
    List<PaymentModel>? paymentModels,
    PaymentModel? selectedPaymentModel,
    bool? hasToken,
    String? error,
  }) =>
      OrderState(
        orderStatus: orderStatus ?? this.orderStatus,
        orderProducts: orderProducts ?? this.orderProducts,
        shippingModels: shippingModels ?? this.shippingModels,
        selectedLocationData: selectedLocationData ?? this.selectedLocationData,
        totalPrice: totalPrice ?? this.totalPrice,
        selectedShippingModel:
            selectedShippingModel ?? this.selectedShippingModel,
        paymentModels: paymentModels ?? this.paymentModels,
        selectedPaymentModel: selectedPaymentModel ?? this.selectedPaymentModel,
        hasToken: hasToken ?? this.hasToken,
        error: error ?? this.error,
      );
}
