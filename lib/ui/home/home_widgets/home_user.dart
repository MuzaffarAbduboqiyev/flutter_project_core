import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/ui/order/order_products/delivery_dialog.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUserWidget extends StatefulWidget {
  const HomeUserWidget({Key? key}) : super(key: key);

  @override
  State<HomeUserWidget> createState() => _HomeUserWidgetState();
}

class _HomeUserWidgetState extends State<HomeUserWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => (state.token)
          ? ListTile(
              contentPadding: const EdgeInsets.only(left: 16.0),
              title: GestureDetector(
                onTap: _locationDialog,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (state.locationData.selectedStatus)
                        ? (state.locationData.address.isNotEmpty)
                            ? Expanded(
                                child: Text(
                                  state.locationData.address ?? "",
                                  style: getCurrentTheme(context)
                                      .textTheme
                                      .bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                ),
                              )
                            : Expanded(
                                child: Text(
                                  translate("location.locations"),
                                  style: getCurrentTheme(context)
                                      .textTheme
                                      .bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                ),
                              )
                        : Expanded(
                            child: Text(
                              translate("location.locations"),
                              style:
                                  getCurrentTheme(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                          ),
                  ],
                ),
              ),
              trailing: Icon(
                Icons.expand_more,
                color: getCurrentTheme(context).iconTheme.color,
                size: 28,
              ),
            )
          : Container(),
    );
  }

  _locationDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const DeliveryDialogScreen(),
    );
  }
}
