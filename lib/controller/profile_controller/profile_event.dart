abstract class ProfileEvent {}

class ListenNameEvent extends ProfileEvent {
  final String name;

  ListenNameEvent({required this.name});
}

class ListenSurnameEvent extends ProfileEvent {
  final String surname;

  ListenSurnameEvent({required this.surname});
}

/// listen userName
class ProfileListenUserNameEvent extends ProfileEvent {
  final String userName;

  ProfileListenUserNameEvent({required this.userName});
}

/// listen userSurname
class ProfileListenUserSurnameEvent extends ProfileEvent {
  final String userSurname;

  ProfileListenUserSurnameEvent({required this.userSurname});
}

/// insert user info
class ProfileSetUserInfoEvent extends ProfileEvent {
  final String userName;
  final String userSurname;
  final String phoneNumber;

  ProfileSetUserInfoEvent({
    required this.userName,
    required this.userSurname,
    required this.phoneNumber,
  });
}

/// get user info
class ProfileGetUserInfoEvent extends ProfileEvent {}
