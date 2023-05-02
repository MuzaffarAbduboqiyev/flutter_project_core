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

/// user email
class ProfileUserEmailEvent extends ProfileEvent {
  final String userEmail;

  ProfileUserEmailEvent({required this.userEmail});
}

/// user phone
class ProfileUserPhoneEvent extends ProfileEvent {
  final String userPhone;

  ProfileUserPhoneEvent({required this.userPhone});
}
