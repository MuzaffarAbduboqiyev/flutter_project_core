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
  final String error;

  ProfileState({
    required this.profileStatus,
    required this.profileModel,
    required this.error,
  });

  factory ProfileState.initial() => ProfileState(
        profileStatus: ProfileStatus.init,
        profileModel: ProfileModel.example(),
        error: "",
      );

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    ProfileModel? profileModel,
    String? error,
  }) =>
      ProfileState(
        profileStatus: profileStatus ?? this.profileStatus,
        profileModel: profileModel ?? this.profileModel,
        error: error ?? this.error,
      );
}
