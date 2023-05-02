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
  final String userEmail;
  final String userPhone;
  final String error;

  ProfileState({
    required this.profileStatus,
    required this.profileModel,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.error,
  });

  factory ProfileState.initial() => ProfileState(
        profileStatus: ProfileStatus.init,
        profileModel: ProfileModel.example(),
        userName: "",
        userEmail: "",
        userPhone: "",
        error: "",
      );

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    ProfileModel? profileModel,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? error,
  }) =>
      ProfileState(
        profileStatus: profileStatus ?? this.profileStatus,
        profileModel: profileModel ?? this.profileModel,
        userName: userName ?? this.userName,
        userEmail: userEmail ?? this.userEmail,
        userPhone: userPhone ?? this.userPhone,
        error: error ?? this.error,
      );
}
