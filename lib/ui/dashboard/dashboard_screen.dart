import 'package:delivery_service/controller/dashboard_controller/dashboard_bloc.dart';
import 'package:delivery_service/controller/dashboard_controller/dashboard_state.dart';
import 'package:delivery_service/ui/account/account_screen.dart';
import 'package:delivery_service/ui/home/home_screen.dart';
import 'package:delivery_service/ui/order/order_screen.dart';
import 'package:delivery_service/ui/search/search_screen.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        DashboardState.initial(),
        dashboardRepository: singleton(),
      ),
      child: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late PersistentTabController _tabController;

  int productCount = 0;
  int currentNavBarIndex = 0;
  List<Widget> _screens = [];

  goBack() {
    _tabController.index = 0;
  }

  initScreens() {
    _screens = [
      HomeScreen(goBack: goBack),
      SearchScreen(goBack: goBack),
      OrderScreen(goBack: goBack, isDashboard: true),
      AccountScreen(goBack: goBack),
    ];
  }

  @override
  initState() {
    super.initState();
    initScreens();
    _tabController = PersistentTabController(initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        currentNavBarIndex = _tabController.index;
        if (currentNavBarIndex == 0) {
          _screens[0] = HomeScreen(goBack: goBack);
        } else if (currentNavBarIndex == 1) {
          _screens[1] = SearchScreen(goBack: goBack);
        } else if (currentNavBarIndex == 2) {
          _screens[2] = OrderScreen(goBack: goBack, isDashboard: true);
        } else if (currentNavBarIndex == 3) {
          _screens[3] = AccountScreen(goBack: goBack);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (productCount == productCount) {
            setState(() {
              productCount = state.productCartData.length;
            });
          } else {
            return;
          }
        },
      child: SafeArea(
          child: Scaffold(
            body: PersistentTabView(
              margin: EdgeInsets.zero,
              context,
              screens: _screens,
              controller: _tabController,
              items: _navBarsItems(),
              navBarHeight: 74.0,
              backgroundColor: getCurrentTheme(context)
                      .bottomNavigationBarTheme
                      .backgroundColor ??
                  navBgColor,
              handleAndroidBackButtonPress: true,
              stateManagement: true,
              hideNavigationBarWhenKeyboardShows: true,
              resizeToAvoidBottomInset: true,
              popActionScreens: PopActionScreensType.all,
              screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style13,
            ),
          ),
        ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _navBarItem(
        icons: CupertinoIcons.home,
        label: translate('nav_bar.home'),
        index: 0,
      ),
      _navBarItem(
        icons: CupertinoIcons.search,
        label: translate('nav_bar.search'),
        index: 1,
      ),
      _navBarItem(
        icons: Icons.shopping_cart_outlined,
        label: translate('nav_bar.basket'),
        index: 2,
        count: productCount,
      ),
      _navBarItem(
        icons: CupertinoIcons.profile_circled,
        label: translate('nav_bar.account'),
        index: 3,
      ),
    ];
  }

  PersistentBottomNavBarItem _navBarItem(
      {IconData? icons, String? label, int count = 0, int index = 0}) {
    return PersistentBottomNavBarItem(
      iconSize: 26.0,
      icon: (count > 0)
          ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 11.0, right: 6.0),
                  child: Icon(icons, size: 26.0),
                ),
                Positioned(
                  top: -1,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: buttonColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "$count",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Icon(icons),
      title: label,
      contentPadding: (count > 0) ? 5 : 5,
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
