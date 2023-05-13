import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/location_model/location_model.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';
import 'package:delivery_service/ui/widgets/dialog/snack_bar.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderShippingWidget extends StatelessWidget {
  const OrderShippingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                if (state.selectedLocationData.id == exampleLocationData.id) {
                  showSnackBar(
                      context: context,
                      message: "Please, select location first");
                } else {
                  context
                      .read<OrderBloc>()
                      .add(OrderGetShippingEvent(context: context));
                }
              },
              child: (state.selectedShippingModel.id !=
                      OrderShippingModel.example().id)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(state.selectedShippingModel.name),
                        ),
                        Text(
                          "${state.selectedShippingModel.price}",
                        ),
                      ],
                    )
                  : Text(
                      translate("shipping.shipping").toCapitalized(),
                      style: getCurrentTheme(context).textTheme.displayLarge,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
            ),
          ),
          Divider(
            color: getCurrentTheme(context).dividerColor,
            thickness: 1,
          ),
        ],
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView.builder(
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: getContainerDecoration(builderContext),
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              shippingModels[index].name,
                              style:
                                  getCurrentTheme(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        subtitle: Text(
                          "${shippingModels[index].price} ${translate("sum")}",
                          style: getCurrentTheme(context).textTheme.labelSmall,
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
