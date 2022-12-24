import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class LocationDeliveryDialog extends StatefulWidget {
  final List<LocationData> locations;

  const LocationDeliveryDialog({required this.locations, Key? key}) : super(key: key);

  @override
  State<LocationDeliveryDialog> createState() => _LocationDeliveryDialogState();
}

class _LocationDeliveryDialogState extends State<LocationDeliveryDialog> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getCurrentTheme(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Text(
                translate("order.address").toCapitalized(),
                style: getCurrentTheme(context).textTheme.displayLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.builder(
              itemCount: widget.locations.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                onLongPress: _showLocationConfirm,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: hintColor),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.adjust, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          widget.locations[index].name ?? "",
                          style: getCurrentTheme(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => googleMaps(context),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: hintColor),
                  bottom: BorderSide(width: 1, color: hintColor),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.add),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          translate("order.addMap").toCapitalized(),
                          style: getCustomStyle(
                            context: context,
                            weight: FontWeight.w600,
                            textSize: 18,
                            color: textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 53,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: getContainerDecoration(
                context,
                fillColor: buttonColor,
              ),
              child: Center(
                child: Text(
                  translate("order.ready"),
                  style: getCustomStyle(
                    context: context,
                    weight: FontWeight.w500,
                    textSize: 18,
                    color: lightTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void googleMaps(context) async {
    await pushNewScreen(
      context,
      mapScreen,
      navbarStatus: false,
    );
  }

  _showLocationConfirm() {
    return showConfirmDialog(
      context: context,
      title: translate("error.clear"),
      content: "",
      confirm: () {},
    );
  }
}
