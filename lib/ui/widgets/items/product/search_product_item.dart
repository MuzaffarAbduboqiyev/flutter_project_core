import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/model/product_model/search_product_model.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductItem extends StatefulWidget {
  final SearchProductModel searchProductModel;
  final int restaurantId;
  final int? productId;
  final int categoryId;
  final Function goBack;

  const SearchProductItem({
    required this.searchProductModel,
    required this.restaurantId,
    required this.productId,
    required this.categoryId,
    required this.goBack,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchProductItem> createState() => _SearchProductItemState();
}

class _SearchProductItemState extends State<SearchProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _searchProduct,
      leading: SizedBox(
        width: 60,
        height: 60,
        child: getClipRReact(
          borderRadius: 8,
          child: ImageLoading(
            imageUrl: widget.searchProductModel.image,
            imageWidth: 60,
            imageHeight: 60,
          ),
        ),
      ),
      title: Text(
        widget.searchProductModel.name,
        style: getCurrentTheme(context).textTheme.bodyLarge,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "0 ${translate("sum")}",
        style: getCurrentTheme(context).textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void _searchProduct() async {
    print("Search Restaurant Product"); // tayyor
    context.read<SearchBloc>().add(SearchSaveHistoryEvent());
    await pushNewScreen(
      context,
      restaurantScreen,
      arguments: {
        "restaurant_id": widget.searchProductModel.vendor.id,
        "product_id": widget.productId!,
        "category_id": widget.categoryId,
        "go_back": widget.goBack,
      },
    );
  }
}
