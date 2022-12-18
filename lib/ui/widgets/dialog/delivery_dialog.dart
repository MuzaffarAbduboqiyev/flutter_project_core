import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class DeliveryDialog extends StatelessWidget {
  const DeliveryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: getCurrentTheme(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(height: 8.0),
          Text(
            translate("order.tracking"),
            style: getCurrentTheme(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.schedule, size: 32),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate("order.time"),
                    style: getCurrentTheme(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translate("${0} min - ${0} min"),
                    style: getCustomStyle(context: context, color: textColor),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 32),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate("order.address"),
                    style: getCurrentTheme(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translate("Atlantic St, Stamford"),
                    style: getCustomStyle(context: context, color: textColor),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 53,
              width: double.infinity,
              decoration: getContainerDecoration(
                context,
                fillColor: buttonColor,
              ),
              child: const Center(child: Text("button")),
            ),
          )
        ],
      ),
    );
  }
}
