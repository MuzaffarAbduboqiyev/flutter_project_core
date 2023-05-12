enum AccountStatus {
  init,
  loading,
  loaded,
  error,
}

class AccountState {
  final AccountStatus accountStatus;
  final bool token;
  final String userName;
  final String userSurname;
  final String error;

  AccountState({
    required this.accountStatus,
    required this.token,
    required this.userName,
    required this.userSurname,
    required this.error,
  });

  factory AccountState.initial() => AccountState(
        accountStatus: AccountStatus.init,
        token: false,
        userName: "",
        userSurname: "",
        error: "",
      );

  AccountState copyWith({
    AccountStatus? accountStatus,
    bool? token,
    String? userName,
    String? userSurname,
    String? error,
  }) =>
      AccountState(
        accountStatus: accountStatus ?? this.accountStatus,
        token: token ?? this.token,
        userName: userName ?? this.userName,
        userSurname: userSurname?? this.userSurname,
        error: error ?? this.error,
      );
}
