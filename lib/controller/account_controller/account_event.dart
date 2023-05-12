abstract class AccountEvent {}



/// Token
class AccountTokenInfoEvent extends AccountEvent {}

/// listen token
class AccountListenTokenEvent extends AccountEvent {
  final bool token;

  AccountListenTokenEvent({required this.token});
}

/// delete token
class AccountDeleteToken extends AccountEvent {
  final bool deleteToken;
  final String deleteName;
  final String deleteSurname;

  AccountDeleteToken({
    required this.deleteToken,
    required this.deleteName,
    required this.deleteSurname,
  });
}

/// user get info
class AccountGetUserInfoEvent extends AccountEvent {}

/// listen name
class AccountListenNameEvent extends AccountEvent {
  final String name;

  AccountListenNameEvent({required this.name});
}

/// listen surname
class AccountListenSurnameEvent extends AccountEvent {
  final String surname;

  AccountListenSurnameEvent({required this.surname});
}
