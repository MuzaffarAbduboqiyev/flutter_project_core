import 'package:delivery_service/ui/account/account_screen.dart';
import 'package:delivery_service/ui/dashboard/dashboard_screen.dart';
import 'package:delivery_service/ui/delivery_location/map_screen.dart';
import 'package:delivery_service/ui/favorites/favorites_screen.dart';
import 'package:delivery_service/ui/home/home_screen.dart';
import 'package:delivery_service/ui/location/location_screen.dart';
import 'package:delivery_service/ui/order/order_screen.dart';
import 'package:delivery_service/ui/payments/payments_screen.dart';
import 'package:delivery_service/ui/profile/profile_screen.dart';
import 'package:delivery_service/ui/restaurant/restaurant_screen.dart';
import 'package:delivery_service/ui/verification_otp/otp_verification_screen.dart';
import 'package:delivery_service/ui/welcome_number/welcome_screen.dart';
import 'package:delivery_service/ui/widgets/splash/splash_screen.dart';
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

  static createSplashScreen() => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );

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
          restaurantId: arguments?["restaurant_id"],
          productId: arguments?["product_id"],
          categoryId: arguments?["category_id"],
        ),
        withNavBar: navbarStatus,
      );
      return true;
    case orderScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const OrderScreen(),
        withNavBar: navbarStatus,
      );
      return true;

    case mapScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const MapScreen(),
        withNavBar: navbarStatus,
      );
      return true;
    case welcomeScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const WelcomeScreen(),
        withNavBar: navbarStatus,
      );
      return true;

    case otpVerificationScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: OtpVerificationScreen(
          phoneNumber: arguments?["phone_number"],
        ),
        withNavBar: navbarStatus,
      );
      return true;

    case accountScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const AccountScreen(),
        withNavBar: navbarStatus,
      );
      return true;
    case profileScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const ProfileScreen(),
        withNavBar: navbarStatus,
      );
      return true;
    case favoritesScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const FavoriteScreen(),
        withNavBar: navbarStatus,
      );
      return true;
    case locationScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const LocationScreen(),
        withNavBar: navbarStatus,
      );
      return true;
    case paymentsScreen:
      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const PaymentsScreen(),
        withNavBar: navbarStatus,
      );
      return true;

    default:
      return true;
  }
}
