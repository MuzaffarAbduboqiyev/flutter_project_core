import 'package:delivery_service/controller/restaurant_controller/restaurant_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/ui/widgets/shimmer/category/home_restaurant_appBar_shimmer.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

getRestaurantAppbar(
  BuildContext context,
  RestaurantModel restaurantModel,
  bool restaurantFavoriteState,
  RestaurantState restaurantState,
) {
  return restaurantState.restaurantStatus == RestaurantStatus.loading
      ? const SliverToBoxAdapter(
          child: RestaurantAppBarShimmer(),
        )
      : SliverAppBar(
          actions: [
            InkWell(
              onTap: () {
                context.read<RestaurantBloc>().add(RestaurantFavoriteEvent());
              },
              child: Icon(
                 restaurantFavoriteState ? Icons.favorite : Icons.favorite_border,
                color: restaurantFavoriteState ? Colors.red : null,
              ),
            ),
            const SizedBox(width: 24.0),
          ],
          expandedHeight: 254.0,
          pinned: true,
          snap: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(restaurantModel.name, textScaleFactor: 1),
            background: Stack(children: [
              ImageLoading(
                imageUrl: restaurantModel.image,
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
                            padding: const EdgeInsets.all(12),
                            alignment: Alignment.center,
                            decoration: getContainerDecoration(
                              context,
                              fillColor: backgroundColor,
                            ),
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.star,
                                        color: getCurrentTheme(context)
                                            .iconTheme
                                            .color,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: restaurantModel.rating.toString(),
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
                            decoration: getContainerDecoration(context,
                                fillColor: backgroundColor),
                            child: Text(
                              "${restaurantModel.deliveryTime} ${translate("restaurant.minute")}",
                              style:
                                  getCurrentTheme(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: 135.0,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: getContainerDecoration(
                          context,
                          fillColor: backgroundColor,
                        ),
                        child: const Text(
                          "Delivery - \$8.99",
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ),
                    ]),
              )
            ]),
          ),
        );
}
