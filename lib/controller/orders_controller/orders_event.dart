abstract class OrdersEvent {}

/// orders product get
class OrdersProductsGetEvent extends OrdersEvent {}

/// orders listen token
class OrdersListenTokenEvent extends OrdersEvent {
  final bool token;

  OrdersListenTokenEvent({required this.token});
}
/// orders get token
class OrdersGetTokenEvent extends OrdersEvent{}