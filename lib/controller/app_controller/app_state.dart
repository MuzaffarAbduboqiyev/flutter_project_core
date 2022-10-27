import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';

/// [AppState] state(holat) => [AppBloc] amallarni [AppEvent] qabul qiladi va javob sifatida [AppState] emit(qaytaradi) qiladi.
/// Biz [AppState] ichida appni ohirgi statelarini saqlab turadi va qaytaradi
/// UI [AppState] dagi o'zgarishlarni eshitib turadi

class AppState {
  final bool isDarkMode;

  AppState({
    required this.isDarkMode,
  });

  /// copyWith amali kerakli field(maydon)larni o'zgartirish uchun ishlatiladi
  /// bu yerda o'zgatishi kerak bo'lgan fieldlarga qiymat beriladi,
  /// qiymat berilmagan fieldlar eski qiymatini oladi yoki saqlab qoladi va Yangi [AppState] qaytaradi.
  AppState copyWith({
    bool? isDarkMode,
  }) =>
      AppState(isDarkMode: isDarkMode ?? this.isDarkMode);

  factory AppState.initial() => AppState(
        isDarkMode: true,
      );
}
