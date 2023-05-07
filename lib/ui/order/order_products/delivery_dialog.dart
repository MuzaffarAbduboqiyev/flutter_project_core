import 'package:delivery_service/controller/dialog_controller/dialog_bloc.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_event.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_state.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryDialogScreen extends StatelessWidget {
  const DeliveryDialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DialogBloc(
        DialogState.initial(),
        dialogRepository: singleton(),
      ),
      child: const DeliveryDialogPage(),
    );
  }
}

class DeliveryDialogPage extends StatefulWidget {
  const DeliveryDialogPage({Key? key}) : super(key: key);

  @override
  State<DeliveryDialogPage> createState() => _DeliveryDialogPageState();
}

class _DeliveryDialogPageState extends State<DeliveryDialogPage> {
  _changeLocationSelectedStatus(locationData) {
    context
        .read<DialogBloc>()
        .add(DialogLocationSelectedEvent(locationData: locationData));
  }

  /// delete
  _deleteLocation(locationData) {
    context.read<DialogBloc>().add(
          DialogLocationDeleteEvent(locationData: locationData),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogBloc, DialogState>(
      builder: (context, state) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Center(
                  child: Text(
                    translate("order.address").toCapitalized(),
                    style: getCurrentTheme(context).textTheme.displayLarge,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView.builder(
                    itemCount: state.location.length,
                    itemBuilder: (context, index) => (state
                            .location[index].selectedStatus)
                        ? ListTile(
                            onTap: () => _changeLocationSelectedStatus(
                                state.location[index]),
                            leading: Icon(
                              state.location[index].address.isNotEmpty
                                  ? state.location[index].selectedStatus
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank_outlined
                                  : null,
                              color: state.location[index].selectedStatus
                                  ? getCurrentTheme(context).indicatorColor
                                  : getCurrentTheme(context).iconTheme.color,
                            ),
                            title: Text(
                              state.location[index].address ?? "",
                              style:
                                  getCurrentTheme(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          )
                        : Dismissible(
                            onDismissed: (value) =>
                                _deleteLocation(state.location[index]),
                            secondaryBackground: Container(
                              color: errorTextColor,
                              child: const Center(
                                child: Icon(Icons.delete_outline),
                              ),
                            ),
                            background: Container(),
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            child: ListTile(
                              leading: GestureDetector(
                                onTap: () => _changeLocationSelectedStatus(
                                    state.location[index]),
                                child: Icon(
                                  state.location[index].address.isNotEmpty
                                      ? state.location[index].selectedStatus
                                          ? Icons.check_box
                                          : Icons
                                              .check_box_outline_blank_outlined
                                      : null,
                                  color: state.location[index].selectedStatus
                                      ? getCurrentTheme(context).indicatorColor
                                      : getCurrentTheme(context)
                                          .iconTheme
                                          .color,
                                ),
                              ),
                              title: Text(
                                state.location[index].address ?? "",
                                style: getCurrentTheme(context)
                                    .textTheme
                                    .bodyLarge,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: hintColor),
                      bottom: BorderSide(width: 1, color: hintColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: getCurrentTheme(context).iconTheme.color,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          translate("order.addMap").toCapitalized(),
                          style:
                              getCurrentTheme(context).textTheme.displayMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: getCurrentTheme(context).iconTheme.color,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (state.location.isNotEmpty) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 53,
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  decoration: getContainerDecoration(
                    context,
                    fillColor:
                        (state.location.isNotEmpty) ? buttonColor : hintColor,
                  ),
                  child: Center(
                    child: Text(
                      (state.location.isNotEmpty)
                          ? translate("order.ready")
                          : translate("order.location"),
                      style: getCustomStyle(
                        context: context,
                        weight: FontWeight.w500,
                        textSize: 18,
                        color: lightTextColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
