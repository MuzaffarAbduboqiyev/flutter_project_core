import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/ui/dashboard/dashboard_screen.dart';
import 'package:delivery_service/ui/home/home_screen.dart';
import 'package:delivery_service/ui/order/order_screen.dart';
import 'package:delivery_service/ui/restaurant/restaurant_screen.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ScreenObserver {
  final RouteObserver<PageRoute> routeObserver;

  ScreenObserver() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> onGenerateRoure(RouteSettings settings) {
    switch (settings.name) {
      case dashboardScreen:
        return _buildRoute(settings, const DashboardScreen());

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

Future<bool> pushNewScreen(
  BuildContext context,
  String pathName, {
  bool navbarStatus = false,
  Map? arguments,
}) async {
  switch (pathName) {
    case restaurantScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: RestaurantScreen(
          restaurantModel: arguments?["restaurant_model"] as RestaurantModel,
          restaurantId: arguments?["restaurant_id"],
          categories: arguments?["restaurant_categories"],
          products: arguments?["restaurant_products"],
        ),
        withNavBar: navbarStatus,
      );
      return true;
    case orderScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen:const OrderScreen(),
        withNavBar: navbarStatus,
      );return true;


    default:
      return true;
  }
}
