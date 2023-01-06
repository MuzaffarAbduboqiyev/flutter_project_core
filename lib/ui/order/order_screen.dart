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

  /// delete
  _showClearConfirm() {
    return showConfirmDialog(
      context: context,
      title: translate("error.clear"),
      content: "",
      confirm: _clearHistory,
    );
  }

  _clearHistory() {
    context.read<OrderBloc>().add(OrderClearProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Order",
            style: getCurrentTheme(context).textTheme.displayLarge,
          ),
          actions: [
            InkWell(
              onTap: _showClearConfirm,
              child: const Icon(Icons.delete_outline),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
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
                                    product: state.products[index],
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
                        )
                      : const OrderListView(),
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
            "${translate("order.total")}:",
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
            "${moneyFormatter.format(state.price)} ${translate("sum")}",
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
              "${translate("order.checkout").toUpperCase()}:",
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
              "${moneyFormatter.format(state.price)} ${translate("sum")}",
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

/*
import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryDialog extends StatefulWidget {
  final BuildContext blocContext;

  const DeliveryDialog({required this.blocContext, Key? key})
      : super(key: key);

  @override
  State<DeliveryDialog> createState() => _DeliveryDialogState();
}

class _DeliveryDialogState extends State<DeliveryDialog> {
  _changeLocationSelectedStatus(LocationData locationData) {
    widget.blocContext
        .read<OrderBloc>()
        .add(OrderLocationEvent(locationData: locationData));
  }

  /// delete
  _showDeleteLocationConfirm() {
    return showConfirmDialog(
      context: context,
      title: translate("location.delete"),
      content: "",
      confirm: _deleteLocation,
    );
  }

  _deleteLocation() {
    widget.blocContext.read<OrderBloc>().add(OrderDeleteLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      bloc: widget.blocContext.read<OrderBloc>(),
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: getCurrentTheme(context).cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    translate("order.address").toCapitalized(),
                    style: getCurrentTheme(context).textTheme.displayLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: ListView.builder(
                  itemCount: state.location.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>
                        _changeLocationSelectedStatus(state.location[index]),
                    onLongPress: _showDeleteLocationConfirm,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: hintColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            state.location[index].selectedStatus
                                ? Icons.check_box
                                : Icons.check_box_outline_blank_outlined,
                            color: getCurrentTheme(context).indicatorColor,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              state.location[index].name ?? "",
                              style:
                                  getCurrentTheme(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => googleMaps(context),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: hintColor),
                      bottom: BorderSide(width: 1, color: hintColor),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              translate("order.addMap").toCapitalized(),
                              style: getCustomStyle(
                                context: context,
                                weight: FontWeight.w600,
                                textSize: 18,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 53,
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  decoration: getContainerDecoration(
                    context,
                    fillColor: buttonColor,
                  ),
                  child: Center(
                    child: Text(
                      translate("order.ready"),
                      style: getCustomStyle(
                        context: context,
                        weight: FontWeight.w500,
                        textSize: 18,
                        color: lightTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void googleMaps(context) async {
    await pushNewScreen(
      context,
      mapScreen,
      navbarStatus: false,
    );
  }
}

 */