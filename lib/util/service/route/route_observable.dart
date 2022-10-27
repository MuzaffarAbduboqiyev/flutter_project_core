import 'package:delivery_service/ui/home/home_screen.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:flutter/material.dart';

class ScreenObserver{
  final RouteObserver<PageRoute> routeObserver;

  ScreenObserver() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> onGenerateRoure(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return _buildRoute(settings, const HomeScreen());


      default:
        return _errorRoute();
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => screen,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}