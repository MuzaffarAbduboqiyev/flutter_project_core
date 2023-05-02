import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/ui/order/order_widgets/delivery_dialog.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeUserWidget extends StatefulWidget {
  const HomeUserWidget({Key? key}) : super(key: key);

  @override
  State<HomeUserWidget> createState() => _HomeUserWidgetState();
}

class _HomeUserWidgetState extends State<HomeUserWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => ListTile(
        onTap: () => (state.token) ? _locationDialog(state) : _pushButton(),
        leading: SvgPicture.asset(
          "assets/img/avatar.svg",
          width: 48.0,
          height: 48.0,
        ),
        title: Text(
          translate("home.user_info.title"),
          style: getCustomStyle(
            context: context,
            weight: FontWeight.w600,
            textSize: 15.0,
            color: getCurrentTheme(context).indicatorColor,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (state.token)
                ? (state.locationData.selectedStatus)
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            state.locationData.address ?? "",
                            style:
                                getCurrentTheme(context).textTheme.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Text(
                          translate("location.locations"),
                          style: getCurrentTheme(context).textTheme.bodyMedium,
                          maxLines: 1,
                        ),
                      )
                : Expanded(
                    child: Text(
                      translate("location.list"),
                      style: getCurrentTheme(context).textTheme.bodyMedium,
                      maxLines: 1,
                    ),
                  ),
            Icon(
              Icons.expand_more,
              color: navUnselectedColor,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  _locationDialog(HomeState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const DeliveryDialogScreen(),
    );
  }

  _pushButton() {
    pushNewScreen(context, welcomeScreen, navbarStatus: false);
  }
}
