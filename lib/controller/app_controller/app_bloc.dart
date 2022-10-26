import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/controller/app_controller/app_repository.dart';
import 'package:delivery_service/controller/app_controller/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository repository;

  AppBloc(super.initialState, {required this.repository}) {
    on<AppChangeThemeEvent>(
      _changeTheme,
      transformer: sequential(),
    );

    on<AppGetThemeEvent>(
      _getTheme,
      transformer: sequential(),
    );
  }

  FutureOr<void> _changeTheme(
      AppChangeThemeEvent event, Emitter<AppState> emit) async {
    final response = await repository.changeThemeMode();

    emit(
      state.copyWith(
        isDarkMode: response,
      ),
    );
  }

  FutureOr<void> _getTheme(
      AppGetThemeEvent event, Emitter<AppState> emit) async {
    final response = await repository.getDarkThemeState();

    emit(
      state.copyWith(
        isDarkMode: response,
      ),
    );
  }
}
