import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/controller/app_controller/app_repository.dart';
import 'package:delivery_service/controller/app_controller/app_state.dart';

///  Bloc - Appni boshqarish uchun, til va theme larni o'zgartirish uchun foydalanamiz.
/// Til va Themeni o'zgartirish uchun AppBlocni chaqirib Unga mos [AppEvent]ni add qilamiz.
/// Blocda [AppEvent] add qilingandan keyin [AppBloc.on] mosh eventni methodi chaqiriladi.

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

  /// [AppBloc] chaqirilib, unga [AppChangeThemeEvent] add qilinganda,
  /// Bloc ichidagi on<AppChangeThemeEvent> eventTransformer ichidagi [_changeTheme] method chaqiriladi.
  /// Bu method [AppRepository] da ThemeModeni o'zgartiradi(dark bo'lsa light ga,
  /// light bo'lsa dark ga) va uni [HiveDatabase]ga saqlab qo'yadi.

  FutureOr<void> _changeTheme(
      AppChangeThemeEvent event, Emitter<AppState> emit) async {
    final response = await repository.changeThemeMode();
    emit(
      state.copyWith(
        isDarkMode: response,
      ),
    );
  }

  /// [AppBloc] chaqirilib, unga [AppGetThemeEvent] add qilinganda,
  /// Bloc ichidagi on<AppGetThemeEvent> eventTransformer ichidagi [_getTheme] method chaqiriladi.
  /// Bu method [AppRepository] da [HiveDatabase] ga saqlab qo'yilgan
  /// ThemeMode ni qaytaradi(dark yoki light, true qaytsa => dark, false qaytsa => light).

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
