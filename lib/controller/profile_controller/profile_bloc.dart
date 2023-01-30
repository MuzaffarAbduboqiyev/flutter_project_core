import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/product_controller/product_event.dart';
import 'package:delivery_service/controller/profile_controller/profile_event.dart';
import 'package:delivery_service/controller/profile_controller/profile_repository.dart';
import 'package:delivery_service/controller/profile_controller/profile_state.dart';

class ProfileBloc extends Bloc<ProductEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(
    super.initialState, {
    required this.profileRepository,
  }) {
    on<ProfileInitialEvent>(
      _initialProfile,
      transformer: concurrent(),
    );
    on<ProfileGetUserEvent>(
      _getUser,
      transformer: concurrent(),
    );

  }

  FutureOr<void> _initialProfile(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(
      state.copyWith(
        profileModel: event.profileModel,
      ),
    );


  }

  FutureOr<void> _getUser(
      ProfileGetUserEvent event, Emitter<ProfileState> emit)async {
    emit(
      state.copyWith(
        profileStatus: ProfileStatus.loading
      ),
    );
    final response = await profileRepository.getAllUserData();
    emit(
      state.copyWith(
        profileStatus:
        (response.status) ? ProfileStatus.loaded : ProfileStatus.error,
        error: response.message,
      ),
    );
  }
}
