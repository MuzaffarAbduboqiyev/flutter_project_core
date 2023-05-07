import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/ui/order/order_products/delivery_dialog.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDeliver extends StatefulWidget {
  const OrderDeliver({Key? key}) : super(key: key);

  @override
  State<OrderDeliver> createState() => _OrderDeliverState();
}

class _OrderDeliverState extends State<OrderDeliver> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => InkWell(
        onTap: () => dialogProduct(state),
        child: Container(
          height: 85,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: hintColor),
              bottom: BorderSide(width: 0.5, color: hintColor),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_on_sharp, size: 28),
            title: (state.locationData.selectedStatus)
                ? Text(
                    state.locationData.address ?? "",
                    style: getCurrentTheme(context).textTheme.displayMedium,
                    maxLines: 2,
                  )
                : Text(
                    translate("location.locations"),
                    style: getCurrentTheme(context).textTheme.bodyMedium,
                  ),
            trailing: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  dialogProduct(state) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      context: context,
      builder: (builderContext) => const DeliveryDialogScreen(),
    );
  }
}
