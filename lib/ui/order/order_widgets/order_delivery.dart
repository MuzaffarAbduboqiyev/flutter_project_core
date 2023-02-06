import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/order/order_widgets/delivery_dialog.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        onTap: () => dialogProduct(state.location),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 70.0,
            height: 90.0,
            decoration: getContainerDecoration(
              context,
              borderRadius: 8,
              fillColor: lightButtonDisableColor.withOpacity(0.1),
              borderColor: lightButtonDisableColor.withOpacity(0.1),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/img/databka.svg",
                width: 48.0,
                height: 48.0,
              ),
            ),
          ),
          title: Text(
            translate("order.delivery").toCapitalized(),
            style: getCurrentTheme(context).textTheme.displayMedium,
          ),
          subtitle: Text(
            "${moneyFormatter.format(0)} ${translate("sum")}",
            style: getCurrentTheme(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 28,
          ),
        ),
      ),
    );
  }

  dialogProduct(List<LocationData> location) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      context: context,
      builder: (builderContext) => const DeliveryDialogScreen(),
    );
  }
}
