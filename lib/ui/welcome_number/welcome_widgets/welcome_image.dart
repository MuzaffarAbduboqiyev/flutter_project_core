import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getCurrentTheme(context).hintColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.topCenter,
      child: Image.asset(
        "assets/img/image_welcome.png",
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
      ),
    );
  }
}
