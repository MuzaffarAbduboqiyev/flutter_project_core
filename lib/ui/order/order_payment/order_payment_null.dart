import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentNull extends StatefulWidget {
  const OrderPaymentNull({Key? key}) : super(key: key);

  @override
  State<OrderPaymentNull> createState() => _OrderPaymentNullState();
}

class _OrderPaymentNullState extends State<OrderPaymentNull> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _buttonSignIn,
      child: Container(
        height: 53,
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
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

  _buttonSignIn() async {
    await pushNewScreen(context, welcomeScreen, navbarStatus: false);
    _refreshPage();
  }

  _refreshPage() {
    BlocProvider.of<OrderBloc>(context).add(OrderGetTokenEvent());
  }
}
