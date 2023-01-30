import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/model/local_database/hive_database.dart';

/// [AppEvent] Event(Hodisa) => [AppBloc] qabul qiladigan class, hodisa yoki bajariladigan amal
/// [AppBloc] faqat bitta event class qabul qilganligi uchun va bizda bir nechta event(amallar,hodisalar) kerak bo'lganligi uchun
/// [AppEvent] abstract class qilib olamiz va bizga kerak bo'ladigan eventlarni shu classdan extend qilib olamiz.
/// [AppEvent]dan extend qilingan classlarni [AppBloc] [AppEvent] ni bolasi deb qabul qiladi
abstract class AppEvent {}

/// Application ThemeMode ni o'zgartirish uchun
/// [AppBloc] ga [AppChangeThemeEvent] add qilamiz
/// Bu [AppBloc] ichidagi on<AppChangeThemeEvent> eventTransformer ga murojat
/// qiladi va uni [_changeTheme] methodini chaqiriladi.
class AppChangeThemeEvent extends AppEvent {}

/// Applicationni [HiveDatabase] ga saqlangan ThemeMode ni olish uchun
/// [AppBloc] ga [AppGetThemeEvent] add qilamiz
/// Bu [AppBloc] ichidagi on<AppGetThemeEvent> eventTransformer ga murojat qiladi
/// va uni [_getTheme] methodini chaqiriladi.
class AppGetThemeEvent extends AppEvent {}
