import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/order/order_widgets/order_delivery.dart';
import 'package:delivery_service/ui/order/order_widgets/order_product.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/ui/widgets/order/order_ui.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(
        OrderState.initial(),
        orderRepository: singleton(),
      ),
      child: const OrderPage(),
    );
  }
}

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");
  late ProductCartData productCartData;
  late LocationData locationData;

  _refresh() {
    context.read<OrderBloc>().add(OrderRefreshProductEvent());
  }

  /// clear
  _showClearConfirm(state) {
    return showConfirmDialog(
      context: context,
      title: translate("error.clear"),
      content: "",
      confirm: () => _clearHistory(state),
    );
  }

  _clearHistory(OrderState state) {
    // context.read<OrderBloc>().add(OrderClearProductEvent());
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
                        appBar: AppBar(
                          leading: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_outlined),
                          ),
                          title: Text(
                            "Order",
                            style:
                                getCurrentTheme(context).textTheme.displayLarge,
                          ),
                          // actions: [
                          //   InkWell(
                          //     onTap: () => _showClearConfirm(state),
                          //     child: const Icon(Icons.delete_outline),
                          //   ),
                          //   const SizedBox(width: 8.0),
                          // ],
                          backgroundColor:
                              getCurrentTheme(context).backgroundColor,
                        ),
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
                              if (state.products.isNotEmpty)
                                const OrderDeliver(),
                              if (state.products.isNotEmpty) _payment(state),
                              const SizedBox(height: 16),
                              if (state.products.isNotEmpty) _checkout(state),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )
                    : const OrderListView(),
      ),
    );
  }

  _payment(OrderState state) {
    return SizedBox(
      height: 85,
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
            "${moneyFormatter.format(state.price)} ${translate("sum")}",
            style: getCurrentTheme(context).textTheme.bodyMedium,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  _checkout(OrderState state) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        height: 53,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: getContainerDecoration(context, fillColor: buttonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${translate("order.checkout")}:",
              style: getCustomStyle(
                context: context,
                color: navSelectedTextColor,
                weight: FontWeight.w500,
                textSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "${moneyFormatter.format(state.price)} ${translate("sum")}",
              style: getCustomStyle(
                  context: context,
                  color: navSelectedTextColor,
                  textSize: 12,
                  weight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
