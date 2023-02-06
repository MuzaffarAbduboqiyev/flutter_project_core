import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/ui/product/product_detail_screen.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RestaurantProductItem extends StatefulWidget {
  final ProductModel productModel;
  final int restaurantId;
  final int productId;
  final int categoryId;

  const RestaurantProductItem({
    required this.productModel,
    required this.restaurantId,
    required this.productId,
    required this.categoryId,
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantProductItem> createState() => _RestaurantProductItemState();
}

class _RestaurantProductItemState extends State<RestaurantProductItem> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openProduct,
      child: Card(
        color: getCurrentTheme(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 260,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "${moneyFormatter.format(widget.productModel.price)} ${translate("sum")}",
                        style: getCurrentTheme(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (widget.productModel.selectedCount > 0)
                      Container(
                        decoration: getContainerDecoration(
                          context,
                          borderRadius: 8,
                          fillColor: getCurrentTheme(context).indicatorColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          "${widget.productModel.selectedCount}",
                          style: getCustomStyle(
                              context: context,
                              color: Colors.black,
                              textSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openProduct() async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builderContext) => ProductDetailScreen(
        restaurantId: widget.restaurantId,
        productId: widget.productModel.id,
        categoryId: widget.categoryId,
      ),
    );
  }
}
