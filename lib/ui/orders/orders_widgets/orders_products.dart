import 'package:delivery_service/controller/orders_controller/orders_bloc.dart';
import 'package:delivery_service/controller/orders_controller/orders_state.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersProducts extends StatefulWidget {
  const OrdersProducts({Key? key}) : super(key: key);

  @override
  State<OrdersProducts> createState() => _OrdersProductsState();
}

class _OrdersProductsState extends State<OrdersProducts> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) => ListView.builder(
        itemCount: state.ordersModel.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, indexModel) => ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          collapsedShape: Border(
            bottom: BorderSide(color: hintColor, width: 0.5),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // state.ordersModel[indexModel].vendorName ??
                "Name",
                style: getCurrentTheme(context).textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 6.0),
              Text(
                "${moneyFormatter.format(state.ordersModel[indexModel].total)} ${translate("sum")}",
                style: getCurrentTheme(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          trailing: GestureDetector(
            onTap: () => isCheck ? _deliveredButton() : _processingButton(),
            child: Container(
              height: 30,
              width: 100,
              margin: const EdgeInsets.only(bottom: 14),
              alignment: Alignment.center,
              decoration: getContainerDecoration(
                context,
                borderRadius: 6,
                fillColor: isCheck ? canceledStatusColor : deliveredStatusColor,
              ),
              child: isCheck
                  ? Text(
                      "Processing",
                      style: getCustomStyle(
                        context: context,
                        textSize: 14,
                        weight: FontWeight.w400,
                        color: navSelectedTextColor,
                      ),
                    )
                  : Text(
                      "Delivered",
                      style: getCustomStyle(
                        context: context,
                        textSize: 14,
                        weight: FontWeight.w400,
                        color: navSelectedTextColor,
                      ),
                    ),
            ),
          ),
          initiallyExpanded: false,
          expandedAlignment: Alignment.centerLeft,
          onExpansionChanged: (value) {},
          backgroundColor: backgroundColor,
          iconColor: Colors.white,
          collapsedIconColor: Colors.red,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.symmetric(vertical: 14),
          children: [
            ListView.builder(
              itemCount:
                  state.ordersModel[indexModel].ordersProductsModel.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                leading: Text(
                  "${state.ordersModel[indexModel].ordersProductsModel[index].quantity.toString()}    x",
                  style: getCurrentTheme(context).textTheme.bodyMedium,
                ),
                title: Text(
                  state.ordersModel[indexModel].ordersProductsModel[index].name
                      .toCapitalized(),
                  style: getCurrentTheme(context).textTheme.bodyMedium,
                ),
                trailing: Text(
                  "${moneyFormatter.format(state.ordersModel[indexModel].ordersProductsModel[index].price)} ${translate("sum")}",
                  style: getCurrentTheme(context).textTheme.bodyMedium,
                ),
              ),
            ),
            InkWell(
              onTap: _reorderCheckButton,
              child: Container(
                height: 53,
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: getContainerDecoration(context),
                child: Text(
                  translate("orders.reorder").toCapitalized(),
                  style: getCurrentTheme(context).textTheme.displayMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deliveredButton() {
    print("Delivered Check Button:");
  }

  _processingButton() {
    print("Processing Check Button:");
  }

  _reorderCheckButton() {
    print("Reorder Check Button:");
    pushNewScreen(context, reorderScreen, navbarStatus: false);
  }
}
