import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class OrderPaymentNull extends StatefulWidget {
  const OrderPaymentNull({Key? key}) : super(key: key);

  @override
  State<OrderPaymentNull> createState() => _OrderPaymentNullState();
}

class _OrderPaymentNullState extends State<OrderPaymentNull> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _buttonSignoIn,
      child: Container(
        height: 53,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: getContainerDecoration(
          context,
          fillColor: getCurrentTheme(context).cardColor,
        ),
        child: Text(
          translate("order.login").toUpperCase(),
          style: getCurrentTheme(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  _buttonSignoIn() {
    pushNewScreen(context, welcomeScreen, navbarStatus: false);
  }
}
