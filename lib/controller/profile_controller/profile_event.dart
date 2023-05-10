import 'package:delivery_service/controller/product_controller/product_event.dart';
import 'package:delivery_service/model/profile_model/profile_model.dart';

abstract class ProfileEvent {}

/// profile initial
class ProfileInitialEvent extends ProfileEvent {
  final ProfileModel? profileModel;

  ProfileInitialEvent({required this.profileModel});
}

/// profile get
class ProfileGetUserEvent extends ProfileEvent {}

/// user name
class ProfileUserNameEvent extends ProfileEvent {
  final String userName;

  ProfileUserNameEvent({required this.userName});
}

/// set userName
class ProfileSetUserNameEvent extends ProfileEvent {
  final String userName;
  final String userSurname;

  ProfileSetUserNameEvent({
    required this.userName,
    required this.userSurname,
  });
}

/// user get info
class ProfileUserGetInfoEvent extends ProfileEvent {
  final String name;
  final String surName;

  ProfileUserGetInfoEvent({required this.name, required this.surName});
}
