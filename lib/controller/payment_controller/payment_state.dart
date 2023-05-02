import 'package:delivery_service/model/order_model/payment_model.dart';

enum PaymentStatus {
  init,
  loading,
  loaded,
  success,
  error,
}

class PaymentState {
  final PaymentStatus paymentStatus;
  final List<PaymentModel> paymentModel;
  final String error;

  PaymentState({
    required this.paymentStatus,
    required this.paymentModel,
    required this.error,
  });

  factory PaymentState.initial() => PaymentState(
        paymentStatus: PaymentStatus.init,
        paymentModel: [],
        error: "",
      );

  PaymentState copyWith({
    PaymentStatus? paymentStatus,
    List<PaymentModel>? paymentModel,
    String? error,
  }) =>
      PaymentState(
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentModel: paymentModel ?? this.paymentModel,
        error: error ?? this.error,
      );
}
