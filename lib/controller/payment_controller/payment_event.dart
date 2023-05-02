abstract class PaymentEvent {}

/// payment check button
class PaymentCheckButtonEvent extends PaymentEvent {}

/// payment request
class OrdersPaymentRequestEvent extends PaymentEvent {
  final int locationId;
  final int shippingId;
  final int paymentId;

  OrdersPaymentRequestEvent({
    required this.locationId,
    required this.shippingId,
    required this.paymentId,
  });
}
