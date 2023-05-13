import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class AccountNull extends StatefulWidget {
  const AccountNull({Key? key}) : super(key: key);

  @override
  State<AccountNull> createState() => _AccountNullState();
}

class _AccountNullState extends State<AccountNull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            translate("account.error").toCapitalized(),
            style: getCurrentTheme(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 24.0),
          InkWell(
            onTap: _buttonSignoIn,
            child: Container(
              height: 53,
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: getContainerDecoration(
                context,
                fillColor: getCurrentTheme(context).cardColor,
              ),
              child: Text(
                translate("account.login").toUpperCase(),
                style: getCurrentTheme(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buttonSignoIn() {
    pushNewScreen(context, welcomeScreen, navbarStatus: false);
  }
}
