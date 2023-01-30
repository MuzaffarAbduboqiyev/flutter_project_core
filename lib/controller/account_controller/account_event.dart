abstract class AccountEvent {}

/// Token
class AccountTokenInfoEvent extends AccountEvent {}

/// listen
class AccountListenEvent extends AccountEvent {
  final bool token;

  AccountListenEvent({required this.token});
}

/// delete token
class AccountDeleteToken extends AccountEvent {
  final bool deleteToken;

  AccountDeleteToken({required this.deleteToken});
}
