import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AccountPage();
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: SvgPicture.asset(
                "assets/img/avatar.svg",
                width: 130.0,
                height: 130.0,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "ArtTemplate",
              style: getCustomStyle(
                context: context,
                textSize: 28,
                weight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {},
              child: Container(
                height: 53,
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: getContainerDecoration(
                  context,
                  fillColor: getCurrentTheme(context).cardColor,
                ),
                child: Text(translate("account.signout"),
                    style: getCurrentTheme(context).textTheme.bodyMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
