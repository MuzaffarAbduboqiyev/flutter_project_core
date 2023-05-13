import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/ui/order/order_products/order_location_dialog.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
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
      builder: (context, state) => (state.token == true)
          ? ListTile(
              onTap: _locationDialog,
              contentPadding: EdgeInsets.zero,
              title: Text(
                translate("home.title"),
                style: getCustomStyle(
                  context: context,
                  textSize: 16,
                  color: buttonColor,
                  weight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
              subtitle: (state.locationData.selectedStatus)
                  ? (state.locationData.address.isNotEmpty)
                      ? Text(
                          state.locationData.address ?? "",
                          style: getCurrentTheme(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        )
                      : Text(
                          translate("location.locations"),
                          style: getCurrentTheme(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        )
                  : Text(
                      translate("location.locations"),
                      style: getCurrentTheme(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
              trailing: Icon(
                Icons.expand_more,
                color: hintColor,
                size: 28,
              ),
            )
          : ListTile(
              onTap: _buttonSignup,
              contentPadding: EdgeInsets.zero,
              title: Text(
                translate("home.welcome"),
                style: getCustomStyle(
                  context: context,
                  textSize: 16,
                  color: buttonColor,
                  weight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
              subtitle: Text(
                translate("home.sign"),
                style: getCurrentTheme(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
              trailing: Icon(
                Icons.expand_more,
                color: hintColor,
                size: 28,
              ),
            ),
    );
  }

  _buttonSignup() {
    pushNewScreen(context, welcomeScreen, navbarStatus: false);
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
