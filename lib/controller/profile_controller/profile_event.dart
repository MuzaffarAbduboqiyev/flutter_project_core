import 'package:delivery_service/controller/product_controller/product_event.dart';
import 'package:delivery_service/model/profile_model/profile_model.dart';

abstract class ProfileEvent {}

class ProfileInitialEvent extends ProductEvent {
  final ProfileModel? profileModel;

  ProfileInitialEvent({required this.profileModel});
}

class ProfileGetUserEvent extends ProductEvent{

}