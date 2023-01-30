abstract class OtpEvent {}

/// otp code
class OtpListenCodeEvent extends OtpEvent {
  final String phoneCode;

  OtpListenCodeEvent({required this.phoneCode});
}

class OtpCheckButtonEvent extends OtpEvent {
  final String phoneNumber;
  final String phoneCode;

  OtpCheckButtonEvent({
    required this.phoneNumber,
    required this.phoneCode,
  });
}

/// Resend
class OtpResendEvent extends OtpEvent {
  final String phoneNumber;

  OtpResendEvent({required this.phoneNumber});
}
