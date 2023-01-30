import 'package:delivery_service/controller/location_controller/location_bloc.dart';
import 'package:delivery_service/controller/location_controller/location_event.dart';
import 'package:delivery_service/controller/location_controller/location_state.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationIndicator extends StatefulWidget {
  const LocationIndicator({Key? key}) : super(key: key);

  @override
  State<LocationIndicator> createState() => _LocationIndicatorState();
}

class _LocationIndicatorState extends State<LocationIndicator> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) => (state.locationStatus ==
              LocationStatus.loading)
          ? const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            )
          : GestureDetector(
              onTap: () => _buttonCart(state),
              child: Container(
                height: 53,
                decoration: getContainerDecoration(context,
                    fillColor: getCurrentTheme(context).indicatorColor),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Center(
                  child: Text(
                    translate("confirmation").toCapitalized(),
                    style: TextStyle(
                      color: lightTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  _buttonCart(state) {
    if (state.locationData.selectedStatus) {
      context.read<LocationBloc>().add(LocationSaveEvent());
    }
  }
}
