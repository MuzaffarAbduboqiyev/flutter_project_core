import 'package:delivery_service/controller/dialog_controller/dialog_bloc.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_event.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/location/location_widget/location_null.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
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
      ),
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
  _showDeleteLocationConfirm(LocationData locationData) {
    return showConfirmDialog(
      context: context,
      title: translate("location.delete"),
      content: "",
      confirm: () => _deleteLocation(locationData),
    );
  }

  _deleteLocation(LocationData locationData) {
    context.read<DialogBloc>().add(
          DialogLocationDeleteEvent(locationData: locationData),
        );
  }

  /// clear
  _showClearConfirm() {
    return showConfirmDialog(
      context: context,
      title: translate("error.clear"),
      content: "",
      confirm: _clearHistory,
    );
  }

  _clearHistory() {
    context.read<DialogBloc>().add(DialogClearLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            translate("location.location"),
            style: getCurrentTheme(context).textTheme.displayLarge,
          ),
          actions: [
            (state.location.isNotEmpty)
                ? InkWell(
                    onTap: () => _showClearConfirm(),
                    child: const Icon(Icons.delete_outline))
                : Container(),
            const SizedBox(width: 12),
          ],
        ),
        backgroundColor: getCurrentTheme(context).backgroundColor,
        body: (state.location.isNotEmpty)
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.location.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        onLongPress: () =>
                            _showDeleteLocationConfirm(state.location[index]),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 0.4, color: hintColor),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                state.location[index].name ?? "",
                                style: getCurrentTheme(context)
                                    .textTheme
                                    .bodyLarge,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => googleMaps(context),
                    child: Container(
                      height: 53,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration:
                          getContainerDecoration(context, borderRadius: 25),
                      child: Center(
                        child: Text(
                          translate("location.selected").toCapitalized(),
                          style:
                              getCurrentTheme(context).textTheme.displayMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              )
            : const LocationNull(),
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
}
