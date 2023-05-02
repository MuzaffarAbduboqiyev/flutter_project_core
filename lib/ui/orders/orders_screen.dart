import 'package:delivery_service/controller/orders_controller/orders_bloc.dart';
import 'package:delivery_service/controller/orders_controller/orders_event.dart';
import 'package:delivery_service/controller/orders_controller/orders_state.dart';
import 'package:delivery_service/ui/orders/orders_widgets/orders_null.dart';
import 'package:delivery_service/ui/orders/orders_widgets/orders_products.dart';
import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/refresh/refresh_header.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(
        OrdersState.initial(),
        ordersRepository: singleton(),
      )..add(OrdersGetTokenEvent()),
      child: const OrdersPage(),
    );
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late RefreshController refreshController;

  _refresh() {
    context.read<OrdersBloc>().add(OrdersProductsGetEvent());
  }

  @override
  void initState() {
    refreshController = RefreshController(initialRefresh: false);
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state.ordersStatus == OrdersStatus.loaded &&
            refreshController.isRefresh) {
          refreshController.refreshCompleted();
        }
      },
      child: Scaffold(
        appBar: simpleAppBar(context, translate("orders.appbar")),
        backgroundColor: getCurrentTheme(context).backgroundColor,
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) => (state.token)
              ? (state.ordersStatus == OrdersStatus.error)
                  ? ConnectionErrorWidget(refreshFunction: _refresh)
                  : SmartRefresher(
                      controller: refreshController,
                      enablePullUp: false,
                      enablePullDown: true,
                      onRefresh: _refresh,
                      header: getRefreshHeader(),
                      physics: const BouncingScrollPhysics(),
                      child: const CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: OrdersProducts(),
                          ),
                        ],
                      ),
                    )
              : const OrdersNull(),
        ),
      ),
    );
  }
}
