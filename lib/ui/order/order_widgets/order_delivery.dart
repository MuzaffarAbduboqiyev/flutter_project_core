import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderDeliver extends StatefulWidget {
  const OrderDeliver({Key? key}) : super(key: key);

  @override
  State<OrderDeliver> createState() => _OrderDeliverState();
}

class _OrderDeliverState extends State<OrderDeliver> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getClipRReact(
            borderRadius: 8,
            child: const ImageLoading(
              imageUrl:
                  "https://w7.pngwing.com/pngs/534/248/png-transparent-pizza-delivery-food-business-service-pizza-retail-hand-payment.png",
              imageWidth: 70,
              imageHeight: 70,
              imageFitType: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            translate("delivery").toCapitalized(),
            style: getCustomStyle(
                context: context, color: textColor, textSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Text(
              "0.00 ${translate("sum")}",
              style: getCustomStyle(
                context: context,
                color: textColor,
                textSize: 15,
                weight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}