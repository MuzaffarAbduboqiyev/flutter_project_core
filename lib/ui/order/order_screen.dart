import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/ui/order/order_payment/order_checkout_payment.dart';
import 'package:delivery_service/ui/order/order_payment/order_payment_null.dart';
import 'package:delivery_service/ui/order/order_products/order_location.dart';
import 'package:delivery_service/ui/order/order_shipping/order_shipping.dart';
import 'package:delivery_service/ui/order/order_total/order_total.dart';
import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/order/order_ui.dart';
import 'package:delivery_service/ui/widgets/refresh/refresh_header.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'order_products/order_product.dart';

class OrderScreen extends StatelessWidget {
  final Function goBack;
  final bool isDashboard;

  const OrderScreen({
    Key? key,
    required this.goBack,
    required this.isDashboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(
        OrderState.initial(),
        orderRepository: singleton(),
        locationRepository: singleton(),
      )..add(OrderGetTokenEvent()),
      child: OrderPage(
        goBack: goBack,
        isDashboard: isDashboard,
      ),
    );
  }
}

class OrderPage extends StatefulWidget {
  final Function goBack;
  final bool isDashboard;

  const OrderPage({
    Key? key,
    required this.goBack,
    required this.isDashboard,
  }) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late RefreshController refreshController = RefreshController();
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  _refresh() {
    context.read<OrderBloc>().add(OrderRefreshProductsEvent());
  }

  _getToken() {
    context.read<OrderBloc>().add(OrderGetTokenEvent());
  }

  @override
  void didUpdateWidget(covariant OrderPage oldWidget) {
    _getToken();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _getToken();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state.orderStatus != OrderStatus.loading &&
            refreshController.isRefresh) {
          refreshController.refreshCompleted();
        }
      },
      child: Scaffold(
        appBar: simpleAppBar(context, translate("order.basket")),
        backgroundColor: getCurrentTheme(context).backgroundColor,
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) => (state.products.isNotEmpty)
              ? (state.orderStatus == OrderStatus.error)
                  ? ConnectionErrorWidget(refreshFunction: _refresh)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: SmartRefresher(
                              controller: refreshController,
                              enablePullUp: false,
                              enablePullDown: true,
                              onRefresh: _refresh,
                              header: getRefreshHeader(),
                              physics: const BouncingScrollPhysics(),
                              child: CustomScrollView(
                                shrinkWrap: true,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: SingleChildScrollView(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: state.products.length,
                                        itemBuilder: (context, index) =>
                                            OrderProduct(
                                                product: state.products[index]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          (state.token) ? const OrderLocation() : Container(),
                          (state.token)
                              ? OrderShipping(
                                  orderBloc: context.read<OrderBloc>(),
                                  orderContext: context)
                              : Container(),
                          if (state.products.isNotEmpty)
                            OrderTotal(state: state),
                          const SizedBox(height: 12.0),
                          (state.token)
                              ? OrderPayment(orderState: state)
                              : const OrderPaymentNull(),
                          const SizedBox(height: 12.0),
                        ],
                      ),
                    )
              : OrderListView(
                  goBack: widget.goBack,
                  isDashboard: widget.isDashboard,
                ),
        ),
      ),
    );
  }

  @override
  dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
