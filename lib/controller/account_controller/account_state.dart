enum AccountStatus {
  init,
  loading,
  loaded,
  error,
}

class AccountState {
  final AccountStatus accountStatus;
  final bool token;
  final String error;

  AccountState({
    required this.accountStatus,
    required this.token,
    required this.error,
  });

  factory AccountState.initial() => AccountState(
        accountStatus: AccountStatus.init,
        token: false,
        error: "",
      );

  AccountState copyWith({
    AccountStatus? accountStatus,
    bool? token,
    String? error,
  }) =>
      AccountState(
        accountStatus: accountStatus ?? this.accountStatus,
        token: token ?? this.token,
        error: error ?? this.error,
      );
}
