import 'package:delivery_service/ui/account/account_screen.dart';
import 'package:delivery_service/ui/home/home_screen.dart';
import 'package:delivery_service/ui/order/order_screen.dart';
import 'package:delivery_service/ui/search/search_screen.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PersistentTabController _tabController;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const OrderScreen(),
    const AccountScreen(),
  ];

  @override
  initState() {
    _tabController = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PersistentTabView(
          context,
          screens: _screens,
          controller: _tabController,
          items: _navBarsItems(),
          backgroundColor: getCurrentTheme(context)
                  .bottomNavigationBarTheme
                  .backgroundColor ??
              navBgColor,
          handleAndroidBackButtonPress: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          popActionScreens: PopActionScreensType.all,
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style12,
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _navBarItem(
        icon: CupertinoIcons.home,
        label: translate('nav_bar.home'),
      ),
      _navBarItem(
        icon: CupertinoIcons.search,
        label: translate('nav_bar.search'),
      ),
      _navBarItem(
        icon: Icons.shopping_bag,
        label: translate('nav_bar.order'),
      ),
      _navBarItem(
        icon: CupertinoIcons.profile_circled,
        label: translate('nav_bar.account'),
      ),
    ];
  }

  PersistentBottomNavBarItem _navBarItem({
    IconData? icon,
    String? label,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(
        icon,
      ),
      title: label,
      contentPadding: 5,
      textStyle:
          getCurrentTheme(context).bottomNavigationBarTheme.selectedLabelStyle,
      activeColorPrimary: getCurrentTheme(context)
              .bottomNavigationBarTheme
              .selectedIconTheme
              ?.color ??
          navBgColor,
      activeColorSecondary: getCurrentTheme(context)
              .bottomNavigationBarTheme
              .selectedIconTheme
              ?.color ??
          navBgColor,
      inactiveColorPrimary: getCurrentTheme(context)
              .bottomNavigationBarTheme
              .unselectedIconTheme
              ?.color ??
          navBgColor,
      inactiveColorSecondary: getCurrentTheme(context)
              .bottomNavigationBarTheme
              .unselectedIconTheme
              ?.color ??
          navBgColor,
    );
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
