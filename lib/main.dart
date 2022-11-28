import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/controller/app_controller/app_state.dart';
import 'package:delivery_service/util/service/asset_loader/json_asset_loader.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart'
    as singleton_service;
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc holatini kuzatib turish uchun interface
class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print(transition);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print(error);
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print(event);
    }
  }
}

void main() async{
  // Application ishga tushgan vaqtda Singletonlikni init(ishga tushuramiz) qilamiz
  singleton_service.init();

  // Blocdagi o'zgarishlarni eshitib turish uchun, biz yaratgan
  // AppBlocObserver init qilamiz
  Bloc.observer = AppBlocObserver();

  // nimaga buni qo'shilishini bilmayman
  WidgetsFlutterBinding.ensureInitialized();

  /// [EasyLocalization] initialized(ishga tushirish) qiladi
  await EasyLocalization.ensureInitialized();

  // Applicationga run beramiz
  runApp(
    /// [EasyLocalization] applicationda Multi Language lini ta;minlab beruvchi pluggin
    EasyLocalization(
      /// [path] languagelar qayerda saqlanganligini ko'rsatiladi
      path: 'assets/lang',

      /// [startLocale] application qaysi til bilan ishga tushishini ko'rsatiladi
      startLocale: const Locale.fromSubtags(languageCode: 'en'),

      /// [supportedLocales] Multi Language => application ishlay oladigan tillar ro'yhati
      supportedLocales: const [
        Locale('en', 'EN'),
        Locale('ru', 'RU'),
        Locale('uz', 'UZ'),
      ],

      /// [fallbackLocale] ga berilgan til => Agar [startLocale]ga berilgan til [supportedLocales] list ichidan topilmasa
      /// qaysi tilni o'qish kerakligini aytib qo'yiladi
      fallbackLocale: const Locale.fromSubtags(languageCode: 'uz'),

      /// Agar [startLocale]ga berilgan til file ichida [key] topilmasa,
      /// [fallbackLocale] ga berilgan til filedan qidirish funcsiyasini yoqib qo'yadi
      useFallbackTranslations: true,

      /// Asset papkadagi file larni o'qib berish uchun kerak
      /// Bizga json filelarni o'qishda foydalanamiz
      assetLoader: JsonAssetLoader(),

      /// Application yopilganda Berilgan tilni saqlab qoladi
      saveLocale: true,
      /// [BlocProvider] bloc ni create(yaratish) qilish uchun ishlatiladigan widget
      child: BlocProvider(
        create: (context) => AppBloc(
          AppState.initial(),
          repository: singleton(),
        )..add(AppGetThemeEvent()),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ScreenObserver screenObserver;

  @override
  void initState() {
    screenObserver = ScreenObserver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// [BlocBuilder] berilgan blocni statedagi o'zgarishlarni eshitib turuvchi
    /// va state o'zgargan paytda child ini rebuild qilivchi widget.
    /// state o'zgargan paytda builder qaytargan widget[MaterialApp]ni qayta rebuild qiladi
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) => MaterialApp(
        title: 'Food delivery',

        /// Agar [AppState] dagi [isDarkMode] field biz [HiveDatabase] ga saqlab qo'ygan
        /// ThemeMode dark bo'lsa true yoki false qaytaradi va uni [AppState.isDarkMode] fieldga o'zlashtirib qo'yadi
        /// Agar true bo'lsa biz yaratib olgan Dark Theme Mode beriladi aks Light Theme Mode beriladi.
        themeMode: (state.isDarkMode) ? ThemeMode.dark : ThemeMode.light,

        /// Agar [AppState] dagi [isDarkMode] field biz [HiveDatabase] ga saqlab qo'ygan
        /// ThemeMode dark bo'lsa true yoki false qaytaradi va uni [AppState.isDarkMode] fieldga o'zlashtirib qo'yadi
        /// Agar true bo'lsa biz yaratib olgan Dark Theme beriladi aks Light Theme beriladi.
        theme: (state.isDarkMode) ? MyTheme.dark() : MyTheme.light(),
        onGenerateRoute: screenObserver.onGenerateRoure,
        navigatorObservers: [screenObserver.routeObserver],

        /// [EasyLocalization] dagi [startLocale] ga berilgan tilni oladi
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,

        /// [EasyLocalization] dagi [supportedLocales] ga berilgan tillarnini oladi
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
