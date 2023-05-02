import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/ui/widgets/loading/loader_dialog.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderShipping extends StatefulWidget {
  final OrderBloc orderBloc;
  final BuildContext orderContext;

  const OrderShipping({
    Key? key,
    required this.orderBloc,
    required this.orderContext,
  }) : super(key: key);

  @override
  State<OrderShipping> createState() => _OrderShippingState();
}

class _OrderShippingState extends State<OrderShipping> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      bloc: widget.orderBloc,
      listener: (context, state) {
        if (state.shippingStatus == ShippingStatus.loading) {
          showLoadingDialog();
        } else {
          hideLoadingDialog();
          if (state.shippingStatus == ShippingStatus.loaded) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: false,
              backgroundColor: Colors.transparent,
              builder: (builderContext) => Container(
                decoration: BoxDecoration(
                  color: getCurrentTheme(context).cardColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child: Center(
                        child: Text(
                          translate("shipping.shipping").toCapitalized(),
                          style:
                              getCurrentTheme(context).textTheme.displayLarge,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: ListView.builder(
                          itemCount: widget.orderBloc.state.orderModel.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => _buttonCart(
                                widget.orderBloc.state.orderModel[index]),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              decoration: getContainerDecoration(context),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      widget.orderBloc.state.orderModel[index]
                                              .name ??
                                          "",
                                      style: getCurrentTheme(context)
                                          .textTheme
                                          .bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  "${moneyFormatter.format(widget.orderBloc.state.orderModel[index].price)} ${translate("sum")}",
                                  style: getCurrentTheme(context)
                                      .textTheme
                                      .labelSmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state.shippingStatus == ShippingStatus.error) {
            showErrorDialog(errorMessage: state.error);
          }
        }
      },
      child: InkWell(
        onTap: _shippingDialog,
        child: Container(
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
                widget.orderBloc.state.shippingName.isNotEmpty
                    ? widget.orderBloc.state.shippingName
                    : "${translate("Shipping")}:",
                style: getCurrentTheme(context).textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "${moneyFormatter.format(widget.orderBloc.state.shippingPrice)} ${translate("sum")}",
                style: getCurrentTheme(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _shippingDialog() {
    context.read<OrderBloc>().add(OrderShippingCheckButtonEvent(
        addressId: widget.orderBloc.state.locationData.id));
  }

  _buttonCart(orderModel) {
    context.read<OrderBloc>().add(OrderRequestButtonEvent(
          shippingId: orderModel.id,
          shippingPrice: orderModel.price,
          shippingName: orderModel.name,
        ));
    Navigator.pop(widget.orderContext);
  }
}
