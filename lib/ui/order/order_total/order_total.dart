import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderTotal extends StatefulWidget {
  final OrderState state;

  const OrderTotal({required this.state, Key? key}) : super(key: key);

  @override
  State<OrderTotal> createState() => _OrderTotalState();
}

class _OrderTotalState extends State<OrderTotal> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "${translate("order.total")}:",
              style: getCurrentTheme(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "${moneyFormatter.format(widget.state.shippingPrice + widget.state.price)} ${translate("sum")}",
              style: getCurrentTheme(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              maxLines: 1,
            ),
          ]),
    );
  }
}
