import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class LocationNull extends StatelessWidget {
  const LocationNull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          translate("location.locations").toCapitalized(),
          style: getCurrentTheme(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () => googleMaps(context),
          child: Container(
            height: 53,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: getContainerDecoration(context, borderRadius: 25),
            child: Center(
              child: Text(
                translate("location.selected").toCapitalized(),
                style: getCurrentTheme(context).textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ],
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
