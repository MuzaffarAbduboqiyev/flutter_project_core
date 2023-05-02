import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/ui/order/order_widgets/delivery_dialog.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDeliver extends StatefulWidget {
  const OrderDeliver({Key? key}) : super(key: key);

  @override
  State<OrderDeliver> createState() => _OrderDeliverState();
}

class _OrderDeliverState extends State<OrderDeliver> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => InkWell(
        onTap: () => dialogProduct(state),
        child: Container(
          height: 85,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: hintColor),
              bottom: BorderSide(width: 0.5, color: hintColor),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_on_sharp, size: 28),
            title: (state.locationData.selectedStatus)
                ? Text(
                    state.locationData.address ?? "",
                    style: getCurrentTheme(context).textTheme.displayMedium,
                    maxLines: 2,
                  )
                : Text(
                    translate("location.locations"),
                    style: getCurrentTheme(context).textTheme.bodyMedium,
                  ),
            trailing: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  dialogProduct(state) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      context: context,
      builder: (builderContext) => const DeliveryDialogScreen(),
    );
  }
}
/*
/*
import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/order/order_checkout_payment/order_checkout_payment.dart';
import 'package:delivery_service/ui/order/order_widgets/order_delivery.dart';
import 'package:delivery_service/ui/order/order_widgets/order_product.dart';
import 'package:delivery_service/ui/order/order_shipping/order_shipping.dart';
import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/ui/widgets/order/order_ui.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class OrderScreen extends StatelessWidget {
  final Function goBack;

  const OrderScreen({Key? key, required this.goBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(
        OrderState.initial(),
        orderRepository: singleton(),
        locationRepository: singleton(),
      )..add(OrderGetTokenEvent()),
      child: OrderPage(goBack: goBack),
    );
  }
}

class OrderPage extends StatefulWidget {
  final Function goBack;

  const OrderPage({Key? key, required this.goBack}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late RefreshController _refreshController;
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");
  late ProductCartData productCartData;
  late LocationData locationData;

  _refresh() {
    context.read<OrderBloc>().add(OrderRefreshProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) => state.orderStatus == OrderStatus.loading
            ? imageLoader()
            : state.orderStatus == OrderStatus.error
                ? ConnectionErrorWidget(refreshFunction: _refresh)
                : (state.products.isNotEmpty)
                    ? Scaffold(
                        appBar: simpleAppBar(context, translate("Order")),
                        backgroundColor:
                            getCurrentTheme(context).backgroundColor,
                        body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: CustomScrollBehavior(),
                                  child: ListView.builder(
                                    itemCount: state.products.length,
                                    itemBuilder: (context, index) =>
                                        OrderProduct(
                                            product: state.products[index]),
                                  ),
                                ),
                              ),
                              (state.token)
                                  ? const OrderDeliver()
                                  : Container(),
                              (state.token)
                                  ? OrderShipping(
                                      orderBloc: context.read<OrderBloc>(),
                                      orderContext: context,
                                    )
                                  : Container(),
                              if (state.products.isNotEmpty)
                                _paymentTotal(state),
                              const SizedBox(height: 16),
                              (state.token)
                                  ? OrderPayment(orderState: state)
                                  : Container(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )
                    : OrderListView(goBack: widget.goBack),
      ),
    );
  }

  _paymentTotal(state) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: hintColor),
          bottom: BorderSide(width: 0.5, color: hintColor),
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${translate("order.total")}:",
              style: getCurrentTheme(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "${moneyFormatter.format(state.shippingPrice + state.price)} ${translate("sum")}",
              style: getCurrentTheme(context).textTheme.bodyMedium,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ]),
    );
  }
}
/*
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
    OrderScreen(goBack: () =>),
    const AccountScreen(),
  ];

  goBack(int value) {
    _tabController.index = value;
  }

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
          onItemSelected: goBack,
          items: _navBarsItems(),
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

 */

 */

 */
