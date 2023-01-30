abstract class WelcomeEvent {}



class WelcomeNumberListenEvent extends WelcomeEvent {
  final String phoneNumber;

  WelcomeNumberListenEvent({required this.phoneNumber});
}

class WelcomeCheckButtonEvent extends WelcomeEvent {
  final String phoneNumber;

  WelcomeCheckButtonEvent({required this.phoneNumber});
}
