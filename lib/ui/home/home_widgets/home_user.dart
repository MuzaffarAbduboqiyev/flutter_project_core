import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/ui/order/order_widgets/delivery_dialog.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

class HomeUserWidget extends StatefulWidget {


  const HomeUserWidget({ Key? key}) : super(key: key);

  @override
  State<HomeUserWidget> createState() => _HomeUserWidgetState();
}

class _HomeUserWidgetState extends State<HomeUserWidget> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) =>
                Text(
                  state.location.name??"",
                  style: getCustomStyle(
                    context: context,
                    weight: FontWeight.w400,
                    textSize: 15.0,
                    color: getCurrentTheme(context).hintColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
          InkWell(
            onTap: _locationDialog,
            child: Icon(
              Icons.expand_more,
              color: navUnselectedColor,
            ),
          ),
        ],
      ),
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
