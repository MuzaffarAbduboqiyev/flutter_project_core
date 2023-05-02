import 'package:delivery_service/controller/dialog_controller/dialog_state.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class LocationNull extends StatefulWidget {
  final DialogState state;

  const LocationNull({Key? key, required this.state}) : super(key: key);

  @override
  State<LocationNull> createState() => _LocationNullState();
}

class _LocationNullState extends State<LocationNull> {
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
          onTap: () => (widget.state.token) ? googleMaps(context) : _pushButton(),
          child: Container(
            height: 53,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: getContainerDecoration(context, borderRadius: 25),
            child: Center(
              child: (widget.state.token)
                  ? Text(
                translate("location.selected").toCapitalized(),
                style: getCurrentTheme(context)
                    .textTheme
                    .displayMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
                  : Text(
                translate("location.list").toCapitalized(),
                style: getCurrentTheme(context)
                    .textTheme
                    .displayMedium,
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

  _pushButton() {
    pushNewScreen(context, welcomeScreen, navbarStatus: false);
  }
}
