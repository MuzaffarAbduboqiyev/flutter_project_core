import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRestaurantItem extends StatefulWidget {
  final RestaurantModel restaurantModel;
  final ProductModel productModel;
  final CategoryModel categoryModel;
  final Function goBack;

  const HomeRestaurantItem({
    required this.restaurantModel,
    required this.productModel,
    required this.categoryModel,
    required this.goBack,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeRestaurantItem> createState() => _HomeRestaurantItemState();
}

class _HomeRestaurantItemState extends State<HomeRestaurantItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 246.0,
      width: double.maxFinite,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _openRestaurantScreen,
            child: getClipRReact(
              borderRadius: 12.0,
              child: ImageLoading(
                imageUrl: widget.restaurantModel.image,
                imageWidth: double.maxFinite,
                imageHeight: 180.0,
                imageFitType: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.restaurantModel.name,
                style: getCurrentTheme(context).textTheme.displayMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              InkWell(
                onTap: () {
                  context.read<HomeBloc>().add(
                        HomeChangeFavoriteEvent(
                          restaurantModel: widget.restaurantModel,
                        ),
                      );
                },
                child: Icon(
                  widget.restaurantModel.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      widget.restaurantModel.isFavorite ? errorTextColor : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            height: 17.0,
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
                        color: getCurrentTheme(context).iconTheme.color,
                        size: 15,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: widget.restaurantModel.rating.toString(),
                    style: getCurrentTheme(context).textTheme.bodyMedium,
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.lens_rounded,
                        color: getCurrentTheme(context).iconTheme.color,
                        size: 4,
                      ),
                    ),
                  ),
                  TextSpan(
                    text:
                        "${widget.restaurantModel.deliveryTime} ${translate("restaurant.minute")}",
                    style: getCurrentTheme(context).textTheme.bodyMedium,
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.lens_rounded,
                        color: getCurrentTheme(context).iconTheme.color,
                        size: 4,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: widget.restaurantModel.affordability,
                    style: getCurrentTheme(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Home dan restaurant = kirish
  void _openRestaurantScreen() async {
    await pushNewScreen(
      context,
      restaurantScreen,
      navbarStatus: false,
      arguments: {
        "restaurant_id": widget.restaurantModel.id,
        "product_id": widget.productModel.id,
        "category_id": widget.categoryModel.id,
        "go_back": widget.goBack,
      },
    );
  }
}
