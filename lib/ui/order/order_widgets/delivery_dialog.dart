import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryDialogScreen extends StatelessWidget {
  const DeliveryDialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(
        OrderState.initial(),
        orderRepository: singleton(),
      ),
      child: const DeliveryDialogPage(),
    );
  }
}

class DeliveryDialogPage extends StatefulWidget {
  const DeliveryDialogPage({Key? key}) : super(key: key);

  @override
  State<DeliveryDialogPage> createState() => _DeliveryDialogPageState();
}

class _DeliveryDialogPageState extends State<DeliveryDialogPage> {
  _changeLocationSelectedStatus(LocationData locationData) {
    context
        .read<OrderBloc>()
        .add(OrderLocationEvent(locationData: locationData));
  }

  /// delete
  _showDeleteLocationConfirm() {
    return showConfirmDialog(
      context: context,
      title: translate("location.delete"),
      content: "",
      confirm: _deleteLocation,
    );
  }

  _deleteLocation() {
    context.read<OrderBloc>().add(OrderDeleteLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Container(
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
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    translate("order.address").toCapitalized(),
                    style: getCurrentTheme(context).textTheme.displayLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: ListView.builder(
                  itemCount: state.location.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>
                        _changeLocationSelectedStatus(state.location[index]),
                    onLongPress: _showDeleteLocationConfirm,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: hintColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            state.location[index].selectedStatus
                                ? Icons.check_box
                                : Icons.check_box_outline_blank_outlined,
                            color: state.location[index].selectedStatus
                                ? getCurrentTheme(context).indicatorColor
                                : getCurrentTheme(context).iconTheme.color,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              state.location[index].name ?? "",
                              style:
                                  getCurrentTheme(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => googleMaps(context),
                child: Container(
                  height: 53,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: hintColor),
                      bottom: BorderSide(width: 1, color: hintColor),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              translate("order.addMap").toCapitalized(),
                              style: getCustomStyle(
                                context: context,
                                weight: FontWeight.w600,
                                textSize: 18,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 53,
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  decoration: getContainerDecoration(
                    context,
                    fillColor: buttonColor,
                  ),
                  child: Center(
                    child: Text(
                      translate("order.ready"),
                      style: getCustomStyle(
                        context: context,
                        weight: FontWeight.w500,
                        textSize: 18,
                        color: lightTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void googleMaps(context) async {
    await pushNewScreen(
      context,
      mapScreen,
      navbarStatus: false,
    );
  }
}
