import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class HomeRestaurantItem extends StatefulWidget {
  final RestaurantModel restaurantModel;

  const HomeRestaurantItem({
    required this.restaurantModel,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeRestaurantItem> createState() => _HomeRestaurantItemState();
}

class _HomeRestaurantItemState extends State<HomeRestaurantItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 236,
      width: double.maxFinite,
      margin: const EdgeInsets.all(
        16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getClipRReact(
            borderRadius: 12,
            child: ImageLoading(
              imageUrl: widget.restaurantModel.image,
              imageWidth: double.maxFinite,
              imageHeight: 180,
              imageFitType: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            widget.restaurantModel.name,
            style: getCurrentTheme(context).textTheme.displayMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 17,
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
}
