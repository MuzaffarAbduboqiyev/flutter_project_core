import 'package:delivery_service/util/extensions/string_extension.dart';

import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';

import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class OrderListView extends StatefulWidget {
  final Function goBack;
  final bool isDashboard;

  const OrderListView({
    Key? key,
    required this.goBack,
    required this.isDashboard,
  }) : super(key: key);

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/Icon.png",
                width: 111.0,
                height: 124.0,
              ),
              const SizedBox(height: 16.0),
              Text(
                "${translate("no_orders_yet").toCapitalized()}!",
                style: getCurrentTheme(context).textTheme.displayLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8.0),
              Text(
                translate("discover").toCapitalized(),
                style: getCustomStyle(
                  context: context,
                  textSize: 14,
                  color: hintColor,
                  weight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 32),
              InkWell(
                onTap: () {
                  if (widget.isDashboard) {
                    widget.goBack.call();
                  } else {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                },
                child: Container(
                  height: 53,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: getContainerDecoration(
                    context,
                    fillColor: getCurrentTheme(context).cardColor,
                  ),
                  child: Text(
                    translate("order.restaurant").toUpperCase(),
                    style: getCurrentTheme(context).textTheme.bodyMedium,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
