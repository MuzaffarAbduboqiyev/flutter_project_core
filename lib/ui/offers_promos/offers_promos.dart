import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class OffersPromosScreen extends StatelessWidget {
  const OffersPromosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(context, translate("offers.offers")),
      backgroundColor: getCurrentTheme(context).backgroundColor,
    );
  }
}
