import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    if (kDebugMode) {
      print("InitState");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translate("title"),
                style: getCurrentTheme(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  if (context.locale.countryCode == "RU") {
                    context.setLocale(const Locale('en', 'EN'));
                  } else {
                    context.setLocale(const Locale('ru', 'RU'));
                  }
                  context.read<AppBloc>().add(AppChangeThemeEvent());
                },
                child: Text(
                  translate("click_me"),
                  style: getCurrentTheme(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
