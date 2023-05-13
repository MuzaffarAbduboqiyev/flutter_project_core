import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/controller/payment_controller/payment_bloc.dart';
import 'package:delivery_service/controller/payment_controller/payment_event.dart';
import 'package:delivery_service/controller/payment_controller/payment_state.dart';
import 'package:delivery_service/ui/widgets/loading/loader_dialog.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPayment extends StatelessWidget {
  final OrderState orderState;

  const OrderPayment({
    required this.orderState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(
        PaymentState.initial(),
        paymentRepository: singleton(),
      ),
      child: OrderPaymentWidget(
        orderState: orderState,
      ),
    );
  }
}

class OrderPaymentWidget extends StatefulWidget {
  final OrderState orderState;

  const OrderPaymentWidget({
    required this.orderState,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderPaymentWidget> createState() => _OrderPaymentWidgetState();
}

class _OrderPaymentWidgetState extends State<OrderPaymentWidget> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state.paymentStatus == PaymentStatus.loading) {
          showLoadingDialog();
        } else {
          hideLoadingDialog();
          if (state.paymentStatus == PaymentStatus.loaded) {
            showDialog(
              context: context,
              barrierDismissible: true,
              barrierColor: getCurrentTheme(context)
                  .dialogBackgroundColor
                  .withOpacity(0.5),
              builder: (context) => Center(
                child: AlertDialog(
                  backgroundColor: getCurrentTheme(context).backgroundColor,
                  shadowColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  title: Column(children: [
                    Center(
                      child: Text(
                        translate("Payment").toCapitalized(),
                        style: getCurrentTheme(context).textTheme.displayLarge,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 350.0,
                      width: 300.0,
                      child: ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: ListView.builder(
                          itemCount: state.paymentModel.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () =>
                                _paymentButton(state.paymentModel[index]),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: getContainerDecoration(context),
                              child: ListTile(
                                leading:
                                    const Icon(Icons.credit_card, size: 42),
                                title: Text(state.paymentModel[index].name),
                                subtitle:
                                    Text(state.paymentModel[index].description),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          } else if (state.paymentStatus == PaymentStatus.error) {
            showErrorDialog(errorMessage: state.error);
          }
        }
      },
      child: InkWell(
        onTap: () => (widget.orderState.shippingName).isNotEmpty
            ? checkoutButton()
            : null,
        child: Container(
          alignment: Alignment.center,
          height: 53,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: getContainerDecoration(
            context,
            fillColor: (widget.orderState.shippingName).isNotEmpty
                ? buttonColor
                : cardBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${translate("order.checkout")}:",
                style: getCustomStyle(
                  context: context,
                  color: (widget.orderState.shippingName).isNotEmpty
                      ? lightTextColor
                      : textColor,
                  weight: FontWeight.w500,
                  textSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "${moneyFormatter.format(widget.orderState.shippingPrice + widget.orderState.price)} ${translate("sum")}",
                style: getCustomStyle(
                    context: context,
                    color: (widget.orderState.shippingName).isNotEmpty
                        ? lightTextColor
                        : textColor,
                    textSize: 12,
                    weight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkoutButton() {
    context.read<PaymentBloc>().add(PaymentCheckButtonEvent());
  }

  _paymentButton(paymentModel) {
    context.read<PaymentBloc>().add(
          OrdersPaymentRequestEvent(
            locationId: widget.orderState.locationData.id,
            shippingId: widget.orderState.shippingId,
            paymentId: paymentModel.id,
          ),
        );
    Navigator.pop(context);
  }

  locationSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        backgroundColor: Colors.orange,
        closeIconColor: getCurrentTheme(context).iconTheme.color,
        showCloseIcon: true,
        content: Text(
          translate("order.location"),
          style: getCurrentTheme(context).textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          maxLines: 1,
        ),
      ),
    );
  }

  shippingSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        backgroundColor: Colors.orange,
        closeIconColor: getCurrentTheme(context).iconTheme.color,
        showCloseIcon: true,
        content: Text(
          translate("order.shipping"),
          style: getCurrentTheme(context).textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          maxLines: 1,
        ),
      ),
    );
  }
}
