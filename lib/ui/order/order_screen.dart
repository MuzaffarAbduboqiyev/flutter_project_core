import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/ui/order/order_ui/order_delivery.dart';
import 'package:delivery_service/ui/order/order_ui/order_product.dart';
import 'package:delivery_service/ui/order/order_ui/order_ui.dart';
import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
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

  _refresh() {
    context.read<OrderBloc>().add(OrderRefreshProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: simpleAppBar(context, "Order"),
        backgroundColor: backgroundColor,
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) => state.orderStatus == OrderStatus.loading
              ? imageLoader()
              : state.orderStatus == OrderStatus.error
                  ? ConnectionErrorWidget(refreshFunction: _refresh)
                  : (state.products.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.products.length,
                                  itemBuilder: (context, index) => OrderProduct(
                                      product: state.products[index]),
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
                        )
                      : const OrderUi(),
        ),
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
            "${translate("total")}:",
            style: getCustomStyle(
              context: context,
              color: textColor,
              textSize: 20,
              weight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            "${state.price}",
            style: getCustomStyle(
              context: context,
              color: textColor,
              textSize: 20,
              weight: FontWeight.w500,
            ),
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
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: getContainerDecoration(context, fillColor: buttonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${translate("checkout").toUpperCase()}:",
              style: getCustomStyle(
                context: context,
                color: navSelectedTextColor,
                textSize: 15,
                weight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "${state.price}",
              style: getCustomStyle(
                context: context,
                color: navSelectedTextColor,
                textSize: 15,
                weight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
