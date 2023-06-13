import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/location_model/location_model.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';
import 'package:delivery_service/ui/widgets/dialog/snack_bar.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderShippingWidget extends StatefulWidget {
  const OrderShippingWidget({Key? key}) : super(key: key);

  @override
  State<OrderShippingWidget> createState() => _OrderShippingWidgetState();
}

class _OrderShippingWidgetState extends State<OrderShippingWidget> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => InkWell(
        onTap: () {
          if (state.selectedLocationData.id == exampleLocationData.id) {
            showSnackBar(
                context: context,
                message: translate("shipping.locationBar").toCapitalized());
          } else {
            context
                .read<OrderBloc>()
                .add(OrderGetShippingEvent(context: context));
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: hintColor, width: 0.4),
          )),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
          child: (state.selectedShippingModel.id !=
                  OrderShippingModel.example().id)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        state.selectedShippingModel.name,
                        style: getCurrentTheme(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      "${moneyFormatter.format(state.selectedShippingModel.price)} ${translate("sum")}",
                      style: getCurrentTheme(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      translate("shipping.button").toCapitalized(),
                      style: getCurrentTheme(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: hintColor,
                      size: 28,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

showOrderShippingDialog({
  required BuildContext mainContext,
  required List<OrderShippingModel> shippingModels,
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Center(
                child: Text(
                  translate("shipping.shipping").toCapitalized(),
                  style: getCurrentTheme(mainContext).textTheme.displayLarge,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
            ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shippingModels.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    mainContext.read<OrderBloc>().add(
                          OrderSelectedShippingEvent(
                            shippingModel: shippingModels[index],
                          ),
                        );
                    Navigator.pop(builderContext);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: getContainerDecoration(builderContext),
                    child: ListTile(
                      title: Text(
                        shippingModels[index].name,
                        style: getCurrentTheme(context).textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          "${(shippingModels[index].price)} ${translate("sum")}",
                          style: getCurrentTheme(context).textTheme.labelSmall,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
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
