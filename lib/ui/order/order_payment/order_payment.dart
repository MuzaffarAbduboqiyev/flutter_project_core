import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/location_model/location_model.dart';
import 'package:delivery_service/model/order_model/payment_model.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';
import 'package:delivery_service/ui/widgets/dialog/snack_bar.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentWidget extends StatefulWidget {
  final OrderState state;

  const OrderPaymentWidget({required this.state, Key? key}) : super(key: key);

  @override
  State<OrderPaymentWidget> createState() => _OrderPaymentWidgetState();
}

class _OrderPaymentWidgetState extends State<OrderPaymentWidget> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => InkWell(
        onTap: () {
          if (state.selectedLocationData.id == exampleLocationData.id) {
            showSnackBar(
                context: context,
                message: translate("payments.locationBar").toCapitalized());
          } else if (state.selectedShippingModel.id ==
              OrderShippingModel.example().id) {
            showSnackBar(
                context: context,
                message: translate("payments.shippingBar").toCapitalized());
          } else {
            context
                .read<OrderBloc>()
                .add(OrderGetPaymentsEvent(context: context));
          }
        },
        child: Container(
          height: 53,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: getContainerDecoration(context, fillColor: buttonColor),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translate("payments.button").toCapitalized(),
                style: getCustomStyle(
                  context: context,
                  color: backgroundColor,
                  weight: FontWeight.w600,
                  textSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
              Text(
                "${moneyFormatter.format(widget.state.selectedShippingModel.price + widget.state.totalPrice)} ${translate("sum")}",
                style: getCustomStyle(
                  context: context,
                  textSize: 13,
                  weight: FontWeight.w500,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showOrderPaymentDialog({
  required BuildContext mainContext,
  required List<PaymentModel> paymentModels,
}) =>
    showModalBottomSheet(
      context: mainContext,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (builderContext) => Container(
        decoration: BoxDecoration(
          color: getCurrentTheme(mainContext).cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  translate("payments.payments").toCapitalized(),
                  style: getCurrentTheme(mainContext).textTheme.displayLarge,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: paymentModels.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    mainContext.read<OrderBloc>().add(
                          OrderSelectedPaymentEvent(
                            paymentModel: paymentModels[index],
                          ),
                        );
                    Navigator.pop(builderContext);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6.0),
                    decoration: getContainerDecoration(builderContext),
                    child: ListTile(
                      onTap: () {
                        mainContext.read<OrderBloc>().add(
                              OrderSelectedPaymentEvent(
                                paymentModel: paymentModels[index],
                              ),
                            );
                        Navigator.pop(mainContext);
                      },
                      title: Row(
                        children: [
                          Text(
                            paymentModels[index].name,
                            style: getCurrentTheme(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          paymentModels[index].description,
                          style: getCurrentTheme(context).textTheme.labelSmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: hintColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
