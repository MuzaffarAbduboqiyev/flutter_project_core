import 'package:delivery_service/model/profile_model/profile_model.dart';

enum ProfileStatus {
  init, // boshlang'ich
  loading, // yuklash
  loaded, // yuklangan
  error, // xato
}

class ProfileState {
  final ProfileStatus profileStatus;
  final ProfileModel profileModel;
  final String userName;
  final String userSurname;
  final String phoneNumber;
  final String name;
  final String surname;
  final String error;

  ProfileState({
    required this.profileStatus,
    required this.profileModel,
    required this.userName,
    required this.userSurname,
    required this.phoneNumber,
    required this.name,
    required this.surname,
    required this.error,
  });

  factory ProfileState.initial() => ProfileState(
        profileStatus: ProfileStatus.init,
        profileModel: ProfileModel.example(),
        userName: "",
        userSurname: "",
        phoneNumber: "",
        name: "",
        surname: "",
        error: "",
      );

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    ProfileModel? profileModel,
    String? userName,
    String? userSurname,
    String? phoneNumber,
    String? name,
    String? surname,
    String? error,
  }) =>
      ProfileState(
        profileStatus: profileStatus ?? this.profileStatus,
        profileModel: profileModel ?? this.profileModel,
        userName: userName ?? this.userName,
        userSurname: userSurname ?? this.userSurname,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        error: error ?? this.error,
      );
}
