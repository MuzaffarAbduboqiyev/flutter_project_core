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
  final String error;

  ProfileState({
    required this.profileStatus,
    required this.profileModel,
    required this.userName,
    required this.userSurname,
    required this.error,
  });

  factory ProfileState.initial() => ProfileState(
        profileStatus: ProfileStatus.init,
        profileModel: ProfileModel.example(),
        userName: "",
        userSurname: "",
        error: "",
      );

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    ProfileModel? profileModel,
    String? userName,
    String? userSurname,
    String? error,
  }) =>
      ProfileState(
        profileStatus: profileStatus ?? this.profileStatus,
        profileModel: profileModel ?? this.profileModel,
        userName: userName ?? this.userName,
        userSurname: userSurname ?? this.userSurname,
        error: error ?? this.error,
      );
}
