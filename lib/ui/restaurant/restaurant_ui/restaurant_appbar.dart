import 'package:delivery_service/controller/restaurant_controller/restaurant_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/ui/widgets/shimmer/category/home_restaurant_appBar_shimmer.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantAppBar extends StatefulWidget {
  final Function goBack;

  const RestaurantAppBar({
    Key? key,
    required this.goBack,
  }) : super(key: key);

  @override
  State<RestaurantAppBar> createState() => _RestaurantAppBarState();
}

class _RestaurantAppBarState extends State<RestaurantAppBar> {
  _getTokenInfo() {
    context.read<RestaurantBloc>().add(RestaurantGetTokenEvent());
  }

  @override
  void didChangeDependencies() {
    _getTokenInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) => state.restaurantStatus ==
              RestaurantStatus.loading
          ? const SliverToBoxAdapter(
              child: RestaurantAppBarShimmer(),
            )
          : SliverAppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: textColor),
              ),
              actions: [
                InkWell(
                  onTap: () => _searchCheckButton(state),
                  child: Icon(
                    Icons.search,
                    size: 30,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 24.0),
                InkWell(
                  onTap: () {
                    if (state.token == true) {
                      context
                          .read<RestaurantBloc>()
                          .add(RestaurantFavoriteEvent());
                    } else {
                      pushNewScreen(context, welcomeScreen,
                          navbarStatus: false);
                    }
                  },
                  child: Icon(
                    state.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: state.isFavorite
                        ? errorTextColor
                        : textColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 24.0),
              ],
              expandedHeight: 254.0,
              pinned: true,
              snap: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(state.restaurantModel.name,
                    style: getCurrentTheme(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1),
                background: Stack(children: [
                  ImageLoading(
                    imageUrl: state.restaurantModel.image,
                    imageWidth: double.maxFinite,
                    imageHeight: double.maxFinite,
                    imageFitType: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0, left: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                alignment: Alignment.center,
                                decoration: getContainerDecoration(
                                  context,
                                  fillColor:
                                      getCurrentTheme(context).dividerColor,
                                  borderColor:
                                      getCurrentTheme(context).dividerColor,
                                ),
                                child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: Icon(
                                            Icons.star,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: state.restaurantModel.rating
                                            .toString(),
                                        style: getCurrentTheme(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.center,
                                decoration: getContainerDecoration(
                                  context,
                                  fillColor:
                                      getCurrentTheme(context).dividerColor,
                                  borderColor:
                                      getCurrentTheme(context).dividerColor,
                                ),
                                child: Text(
                                  "${state.restaurantModel.deliveryTime} ${translate("restaurant.minute")}",
                                  style: getCurrentTheme(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            width: 145.0,
                            padding: const EdgeInsets.all(12),
                            alignment: Alignment.center,
                            decoration: getContainerDecoration(
                              context,
                              fillColor: getCurrentTheme(context).dividerColor,
                              borderColor:
                                  getCurrentTheme(context).dividerColor,
                            ),
                            child: Text(
                              "Delivery - ${0.00}",
                              style:
                                  getCurrentTheme(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ),
                        ]),
                  ),
                ]),
              ),
            ),
    );
  }

  _searchCheckButton(state) async {
    await pushNewScreen(
      context,
      restaurantSearch,
      navbarStatus: false,
      arguments: {
        "restaurant_id": state.restaurantModel.id,
        "category_id": state.categoryId,
        "go_back": widget.goBack,
      },
    );
  }
}
