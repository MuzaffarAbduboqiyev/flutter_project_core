import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';

enum OrderStatus {
  init,
  loading,
  loaded,
  error,
  refreshing,
}

enum ShippingStatus {
  init,
  loading,
  loaded,
  error,
}

class OrderState {
  final OrderStatus orderStatus;
  final ShippingStatus shippingStatus;
  final List<ProductCartData> products;
  final List<OrderShippingModel> orderModel;
  final LocationData locationData;
  final int price;
  final int shippingId;
  final int shippingPrice;
  final String shippingName;
  final bool token;
  final String error;

  OrderState({
    required this.orderStatus,
    required this.shippingStatus,
    required this.products,
    required this.locationData,
    required this.orderModel,
    required this.price,
    required this.shippingId,
    required this.shippingPrice,
    required this.shippingName,
    required this.token,
    required this.error,
  });

  factory OrderState.initial() => OrderState(
        orderStatus: OrderStatus.init,
        shippingStatus: ShippingStatus.init,
        products: [],
        orderModel: [],
        locationData: LocationData(
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
        price: 0,
        shippingId: 0,
        shippingPrice: 0,
        shippingName: "",
        token: false,
        error: "",
      );

  OrderState copyWith({
    OrderStatus? orderStatus,
    ShippingStatus? shippingStatus,
    LocationData? locationData,
    List<ProductCartData>? products,
    List<OrderShippingModel>? orderModel,
    int? price,
    int? shippingId,
    int? shippingPrice,
    String? shippingName,
    bool? token,
    String? error,
  }) =>
      OrderState(
        orderStatus: orderStatus ?? this.orderStatus,
        shippingStatus: shippingStatus ?? this.shippingStatus,
        products: products ?? this.products,
        locationData: locationData ?? this.locationData,
        orderModel: orderModel ?? this.orderModel,
        price: price ?? this.price,
        shippingId: shippingId ?? this.shippingId,
        shippingPrice: shippingPrice ?? this.shippingPrice,
        shippingName: shippingName ?? this.shippingName,
        token: token ?? this.token,
        error: error ?? this.error,
      );
}
