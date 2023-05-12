import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/profile_controller/profile_event.dart';
import 'package:delivery_service/controller/profile_controller/profile_repository.dart';
import 'package:delivery_service/controller/profile_controller/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  late StreamSubscription streamSubscription;

  ProfileBloc(
    super.initialState, {
    required this.profileRepository,
  }) {
    /// listen userName
    on<ListenNameEvent>(
      _nameListen,
      transformer: concurrent(),
    );

    /// listen userName
    on<ListenSurnameEvent>(
      _surnameListen,
      transformer: concurrent(),
    );

    /// listen userName
    on<ProfileListenUserNameEvent>(
      _listenUserName,
      transformer: concurrent(),
    );

    /// listen userSurname
    on<ProfileListenUserSurnameEvent>(
      _listenUserSurname,
      transformer: concurrent(),
    );

    /// insert user info = malumotlarni kiritish
    on<ProfileSetUserInfoEvent>(
      _insertUsersInfo,
      transformer: concurrent(),
    );

    /// get user info
    on<ProfileGetUserInfoEvent>(
      _getUsersInfo,
      transformer: concurrent(),
    );

    streamSubscription = profileRepository.listenUserName().listen((userName) {
      add(ProfileListenUserNameEvent(userName: userName.value.toString()));
    });
    streamSubscription =
        profileRepository.listenUserSurname().listen((userSurname) {
      add(ProfileListenUserSurnameEvent(
          userSurname: userSurname.value.toString()));
    });
  }

  /// listen userName
  FutureOr<void> _listenUserName(
      ProfileListenUserNameEvent event, Emitter<ProfileState> emit) async {
    emit(
      state.copyWith(
        userName: event.userName,
      ),
    );
  }

  /// listen userSurname
  FutureOr<void> _listenUserSurname(
      ProfileListenUserSurnameEvent event, Emitter<ProfileState> emit) async {
    emit(
      state.copyWith(
        userSurname: event.userSurname,
      ),
    );
  }

  /// insert user info = malumotlarni kiritish
  FutureOr<void> _insertUsersInfo(
      ProfileSetUserInfoEvent event, Emitter<ProfileState> emit) async {
    final userName =
        await profileRepository.setUserName(userName: event.userName);
    final userSurname =
        await profileRepository.setUserSurname(userSurname: event.userSurname);
    emit(
      state.copyWith(
        userName: userName,
        userSurname: userSurname,
      ),
    );
  }

  /// get user info malumotlarni olish
  FutureOr<void> _getUsersInfo(
      ProfileGetUserInfoEvent event, Emitter<ProfileState> emit) async {
    final userName = await profileRepository.getUserName();
    final userSurname = await profileRepository.getUserSurname();
    final phoneNumber = await profileRepository.getPhoneNumber();
    emit(
      state.copyWith(
        userName: userName,
        userSurname: userSurname,
        phoneNumber: phoneNumber,
      ),
    );
  }

  FutureOr<void> _nameListen(
      ListenNameEvent event, Emitter<ProfileState> emit) async {
    emit(
      state.copyWith(
        name: event.name,
      ),
    );
  }

  FutureOr<void> _surnameListen(
      ListenSurnameEvent event, Emitter<ProfileState> emit) async {
    emit(
      state.copyWith(
        surname: event.surname,
      ),
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
