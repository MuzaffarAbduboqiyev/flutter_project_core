import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/otp_controller/otp_event.dart';
import 'package:delivery_service/controller/otp_controller/otp_repository.dart';
import 'package:delivery_service/controller/otp_controller/otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository otpRepository;

  OtpBloc(
    super.initialState, {
    required this.otpRepository,
  }) {
    /// Otp Code
    on<OtpListenCodeEvent>(
      _listenCode,
      transformer: concurrent(),
    );
    on<OtpCheckButtonEvent>(
      _checkButton,
      transformer: concurrent(),
    );

    /// Resend
    on<OtpResendEvent>(
      _resendOtp,
      transformer: concurrent(),
    );
  }

  /// Otp Code
  FutureOr<void> _listenCode(
      OtpListenCodeEvent event, Emitter<OtpState> emit) async {
    emit(
      state.copyWith(
        otpStatus: OtpStatus.init,
        phoneCode: event.phoneCode,
      ),
    );
  }

  FutureOr<void> _checkButton(
      OtpCheckButtonEvent event, Emitter<OtpState> emit) async {
    emit(
      state.copyWith(
        otpStatus: OtpStatus.loading,
        phoneNumber: event.phoneNumber,
        phoneCode: event.phoneCode,
      ),
    );
    final response = await otpRepository.getPhoneCode(
      phoneNumber: state.phoneNumber,
      phoneCode: state.phoneCode,
    );
    emit(
      state.copyWith(
        otpStatus: (response.status) ? OtpStatus.loaded : OtpStatus.error,
        error: response.message,
      ),
    );
  }

  /// Otp Resend
  FutureOr<void> _resendOtp(
      OtpResendEvent event, Emitter<OtpState> emit) async {
    final response = await otpRepository.getPhoneNumberResend(
      phoneNumber: event.phoneNumber,
    );

    if (response.status == true) {
      emit(
        state.copyWith(
          otpStatus: OtpStatus.resend,
          timerStatus: TimerStatus.restart,
        ),
      );
    } else {
      emit(
        state.copyWith(
          otpStatus: OtpStatus.error,
          error: response.message,
          timerStatus: TimerStatus.init,
        ),
      );
    }
  }
}
