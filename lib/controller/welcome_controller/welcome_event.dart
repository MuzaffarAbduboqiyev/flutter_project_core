abstract class WelcomeEvent {}

class WelcomeNumberListenEvent extends WelcomeEvent {
  final String phoneNumber;

  WelcomeNumberListenEvent({required this.phoneNumber});
}

/// Resend
class WelcomeCheckButtonEvent extends WelcomeEvent {
  final String phoneNumber;

  WelcomeCheckButtonEvent({required this.phoneNumber});
}
