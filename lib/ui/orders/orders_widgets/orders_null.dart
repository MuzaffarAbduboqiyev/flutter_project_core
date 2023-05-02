import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class OrdersNull extends StatefulWidget {
  const OrdersNull({Key? key}) : super(key: key);

  @override
  State<OrdersNull> createState() => _OrdersNullState();
}

class _OrdersNullState extends State<OrdersNull> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          translate("orders.error").toCapitalized(),
          style: getCurrentTheme(context).textTheme.displayMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: _checkButton,
          child: Container(
            height: 53,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: getContainerDecoration(context),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              translate("orders.nullButton").toCapitalized(),
              style: getCurrentTheme(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  void _checkButton() {
    print("Check Button:");
    pushNewScreen(context, welcomeScreen, navbarStatus: false);
  }
}
