import 'package:delivery_service/controller/orders_controller/orders_bloc.dart';
import 'package:delivery_service/controller/orders_controller/orders_state.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersProducts extends StatefulWidget {
  const OrdersProducts({Key? key}) : super(key: key);

  @override
  State<OrdersProducts> createState() => _OrdersProductsState();
}

class _OrdersProductsState extends State<OrdersProducts> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) => ListView.builder(
        itemCount: state.ordersModel.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, indexModel) => ExpandableNotifier(
          child: ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
                hasIcon: false,
              ),
              header: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.ordersModel[indexModel].vendorName.isNotEmpty
                          ? state.ordersModel[indexModel].vendorName
                          : "Name",
                      style: getCurrentTheme(context).textTheme.displayMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "${moneyFormatter.format(state.ordersModel[indexModel].total)} ${translate("sum")}",
                      style: getCurrentTheme(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                trailing: Container(
                  height: 30,
                  width: 100,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  alignment: Alignment.center,
                  decoration: getContainerDecoration(
                    context,
                    borderRadius: 6,
                    fillColor:
                        (state.ordersModel[indexModel].status.toString() ==
                                "delivered")
                            ? deliveredStatusColor
                            : canceledStatusColor,
                  ),
                  child: (state.ordersModel[indexModel].status.toString() ==
                          "delivered")
                      ? Text(
                          translate("orders.delivered").toCapitalized(),
                          style: getCustomStyle(
                            context: context,
                            textSize: 14,
                            weight: FontWeight.w400,
                            color: navSelectedTextColor,
                          ),
                        )
                      : Text(
                          translate("orders.processing").toCapitalized(),
                          style: getCustomStyle(
                            context: context,
                            textSize: 14,
                            weight: FontWeight.w400,
                            color: navSelectedTextColor,
                          ),
                        ),
                ),
              ),
              collapsed: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 15.0),
                      child: DottedLine(
                        dashGradient: const [
                          Colors.grey,
                          Colors.grey,
                        ],
                        dashLength: 10.0,
                        lineThickness: 0.6,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: getContainerDecoration(context,
                            borderColor: hintColor,
                            fillColor: backgroundColor,
                            borderRadius: 10),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              expanded: Container(),
              builder: (_, collapsed, expanded) {
                return Expandable(
                  collapsed: collapsed,
                  expanded: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, left: 15.0),
                              child: DottedLine(
                                dashGradient: const [
                                  Colors.grey,
                                  Colors.grey,
                                ],
                                dashLength: 10.0,
                                lineThickness: 0.6,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 32.0,
                                height: 32.0,
                                decoration: getContainerDecoration(context,
                                    borderColor: hintColor,
                                    fillColor: backgroundColor,
                                    borderRadius: 10),
                                child: Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: errorTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        itemCount: state
                            .ordersModel[indexModel].ordersProductsModel.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ListTile(
                          leading: Text(
                            "${state.ordersModel[indexModel].ordersProductsModel[index].quantity.toString()}    x",
                            style:
                                getCurrentTheme(context).textTheme.bodyMedium,
                          ),
                          title: Text(
                            state.ordersModel[indexModel]
                                .ordersProductsModel[index].name
                                .toCapitalized(),
                            style:
                                getCurrentTheme(context).textTheme.bodyMedium,
                          ),
                          trailing: Text(
                            "${moneyFormatter.format(state.ordersModel[indexModel].ordersProductsModel[index].price)} ${translate("sum")}",
                            style:
                                getCurrentTheme(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _reorderCheckButton,
                        child: Container(
                          height: 53,
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(16),
                          decoration: getContainerDecoration(context),
                          child: Text(
                            translate("orders.reorder").toCapitalized(),
                            style: getCurrentTheme(context)
                                .textTheme
                                .displayMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Divider(
                        color: hintColor,
                        indent: 14.0,
                        endIndent: 14.0,
                        height: 1.0,
                        thickness: 1.0,
                      ),
                    ],
                  ),
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _reorderCheckButton() {
    print("Reorder Check Button:");
    // pushNewScreen(context, reorderScreen, navbarStatus: false);
  }
}
