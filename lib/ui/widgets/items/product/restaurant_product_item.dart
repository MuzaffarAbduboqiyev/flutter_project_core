import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class RestaurantProductItem extends StatefulWidget {
  final ProductModel productModel;

  const RestaurantProductItem({
    required this.productModel,
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantProductItem> createState() => _RestaurantProductItemState();
}

class _RestaurantProductItemState extends State<RestaurantProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: getCurrentTheme(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 242,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageLoading(
              imageUrl: widget.productModel.image,
              imageWidth: double.maxFinite,
              imageHeight: 145,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 36,
              child: Text(
                widget.productModel.name,
                style: getCurrentTheme(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              "\$${widget.productModel.price}",
              style: getCurrentTheme(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}