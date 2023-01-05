import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeUserWidget extends StatelessWidget {
  const HomeUserWidget({Key? key}) : super(key: key);

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
          Text(
            "883 Spring St, San Francisco",
            style: getCustomStyle(
              context: context,
              weight: FontWeight.w400,
              textSize: 15.0,
              color: getCurrentTheme(context).hintColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.expand_more,
              color: navUnselectedColor,
            ),
          ),
        ],
      ),
    );
  }
}
