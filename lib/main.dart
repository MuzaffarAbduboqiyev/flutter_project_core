import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/controller/app_controller/app_state.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart'
    as singleton_service;
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/theme/app_theme.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
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

void main() {
  // Application ishga tushgan vaqtda Singletonlikni init(ishga tushuramiz) qilamiz
  singleton_service.init();

  // Blocdagi o'zgarishlarni eshitib turish uchun, biz yaratgan
  // AppBlocObserver init qilamiz
  Bloc.observer = AppBlocObserver();

  // nimaga buni qo'shilishini bilmayman
  WidgetsFlutterBinding.ensureInitialized();

  // Applicationga run beramiz
  runApp(
    BlocProvider(
      create: (context) => AppBloc(
        AppState.initial(),
        repository: singleton(),
      )..add(AppGetThemeEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) => MaterialApp(
        title: 'Food delivery',
        themeMode: (state.isDarkMode) ? ThemeMode.dark : ThemeMode.light,
        theme: (state.isDarkMode) ? MyTheme.dark() : MyTheme.light(),
        darkTheme: MyTheme.dark(),
        home: const MyHomePage(title: 'Delivery home'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              context.read<AppBloc>().add(AppChangeThemeEvent());
            },
            child: Text(
              "Click me",
              style: getCurrentTheme(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
