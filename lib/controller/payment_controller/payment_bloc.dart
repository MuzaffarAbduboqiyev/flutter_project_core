import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/payment_controller/payment_event.dart';
import 'package:delivery_service/controller/payment_controller/payment_repository.dart';
import 'package:delivery_service/controller/payment_controller/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc(super.initialState, {required this.paymentRepository}) {
    on<PaymentCheckButtonEvent>(
      _paymentCheck,
      transformer: concurrent(),
    );
    on<OrdersPaymentRequestEvent>(
      _paymentRequest,
      transformer: concurrent(),
    );
  }

  FutureOr<void> _paymentCheck(
      PaymentCheckButtonEvent event, Emitter<PaymentState> emit) async {
    emit(
      state.copyWith(
        paymentStatus: PaymentStatus.loading,
      ),
    );

    final response = await paymentRepository.getPaymentCheck();

    emit(
      state.copyWith(
        paymentStatus:
            (response.status) ? PaymentStatus.loaded : PaymentStatus.error,
        paymentModel: response.data,
        error: response.message,
      ),
    );
  }

  FutureOr<void> _paymentRequest(
      OrdersPaymentRequestEvent event, Emitter<PaymentState> emit) async {
    emit(
      state.copyWith(
        paymentStatus: PaymentStatus.loading,
      ),
    );

    final response = await paymentRepository.getOrdersRequest(
      locationId: event.locationId,
      shippingId: event.shippingId,
      paymentId: event.paymentId,
    );
    emit(
      state.copyWith(
        paymentStatus:
            (response.status) ? PaymentStatus.success : PaymentStatus.error,
        error: response.message,
      ),
    );
  }
}
