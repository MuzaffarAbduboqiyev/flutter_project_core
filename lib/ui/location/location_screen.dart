import 'package:delivery_service/controller/dialog_controller/dialog_bloc.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_event.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_state.dart';
import 'package:delivery_service/ui/location/location_widget/location_null.dart';
import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DialogBloc(
        DialogState.initial(),
        dialogRepository: singleton(),
      )..add(DialogGetTokenEvent()),
      child: const LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  /// delete
  _deleteLocation(locationData) {
    context.read<DialogBloc>().add(
          DialogLocationDeleteEvent(locationData: locationData),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) => Scaffold(
        appBar: simpleAppBar(context, translate("location.location")),
        backgroundColor: getCurrentTheme(context).backgroundColor,
        body: (state.location.isNotEmpty)
            ? Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: ListView.builder(
                        itemCount: state.location.length,
                        itemBuilder: (context, index) => Dismissible(
                          onDismissed: (value) =>
                              _deleteLocation(state.location[index]),
                          key: ValueKey(state.location[index]),
                          background: Container(
                            color: errorTextColor,
                            child: const Icon(Icons.delete_outline),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 0.4, color: hintColor),
                              ),
                            ),
                            child: Text(
                              state.location[index].address ?? "",
                              style:
                                  getCurrentTheme(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        (state.token) ? googleMaps(context) : _pushButton(),
                    child: Container(
                      height: 53,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration:
                          getContainerDecoration(context, borderRadius: 25),
                      child: Center(
                        child: (state.token)
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
                  const SizedBox(height: 16),
                ],
              )
            : LocationNull(state: state),
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

  _pushButton() {
    pushNewScreen(context, welcomeScreen, navbarStatus: false);
  }
}
