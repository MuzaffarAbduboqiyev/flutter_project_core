enum WelcomeStatus {
  init,
  loading,
  loaded,
  cartChanged,
  closed,
  error,
}

class WelcomeState {
  final WelcomeStatus welcomeStatus;
  final String phoneNumber;
  bool get buttonStatus => phoneNumber.length >= 9;
  final String error;

  WelcomeState({
    required this.welcomeStatus,
    required this.phoneNumber,
    required this.error,
  });

  factory WelcomeState.initial() => WelcomeState(
        welcomeStatus: WelcomeStatus.init,
        phoneNumber: "",
        error: "",
      );

  WelcomeState copyWith({
    WelcomeStatus? welcomeStatus,
    String? phoneNumber,
    String? error,
  }) =>
      WelcomeState(
        welcomeStatus: welcomeStatus ?? this.welcomeStatus,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        error: error ?? this.error,
      );
}
