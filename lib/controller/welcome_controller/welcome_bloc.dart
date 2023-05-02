import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/welcome_controller/welcome_event.dart';
import 'package:delivery_service/controller/welcome_controller/welcome_repository.dart';
import 'package:delivery_service/controller/welcome_controller/welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final WelcomeRepository welcomeRepository;
  WelcomeBloc(
    super.initialState, {
    required this.welcomeRepository,
  }) {
    on<WelcomeNumberListenEvent>(
      _listenNumber,
      transformer: concurrent(),
    );
    on<WelcomeCheckButtonEvent>(
      _getNumberWelcome,
      transformer: concurrent(),
    );
  }

  FutureOr<void> _listenNumber(
      WelcomeNumberListenEvent event, Emitter<WelcomeState> emit) async {
    emit(
      state.copyWith(
        welcomeStatus: WelcomeStatus.init,
        phoneNumber: event.phoneNumber,
      ),
    );
  }

  FutureOr<void> _getNumberWelcome(
      WelcomeCheckButtonEvent event, Emitter<WelcomeState> emit) async {
    emit(
      state.copyWith(
        welcomeStatus: WelcomeStatus.loading,
        phoneNumber: event.phoneNumber,
      ),
    );

    final response = await welcomeRepository.getPhoneNumber(
      phoneNumber: state.phoneNumber,
    );

    emit(
      state.copyWith(
        welcomeStatus:
            (response.status) ? WelcomeStatus.loaded : WelcomeStatus.error,
        error: response.message,
      ),
    );
  }
}
