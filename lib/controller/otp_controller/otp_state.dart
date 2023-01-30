enum OtpStatus {
  init,
  loaded,
  loading,
  loginSubmitted,
  resend,
  error,
}

enum TimerStatus {
  init,
  start,
  restart,
  stop,
}

class OtpState {
  final OtpStatus otpStatus;
  final TimerStatus timerStatus;
  final String phoneNumber;
  final String phoneCode;

  bool get buttonStatus => phoneCode.length >= 4;
  final String error;

  OtpState({
    required this.otpStatus,
    required this.timerStatus,
    required this.phoneNumber,
    required this.phoneCode,
    required this.error,
  });

  factory OtpState.initial() => OtpState(
        otpStatus: OtpStatus.init,
        timerStatus: TimerStatus.init,
        phoneNumber: "",
        phoneCode: "",
        error: "",
      );

  OtpState copyWith({
    OtpStatus? otpStatus,
    TimerStatus? timerStatus,
    String? phoneNumber,
    String? phoneCode,
    String? error,
  }) =>
      OtpState(
        otpStatus: otpStatus ?? this.otpStatus,
        timerStatus: timerStatus ?? this.timerStatus,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneCode: phoneCode ?? this.phoneCode,
        error: error ?? this.error,
      );
}
