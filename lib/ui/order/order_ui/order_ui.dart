import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class OrderUi extends StatelessWidget {
  const OrderUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
            maxLines: 1,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
