import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/model/product_model/search_product_model.dart';
import 'package:delivery_service/ui/product/product_detail_screen.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductItem extends StatefulWidget {
  final SearchProductModel searchProductModel;

  const SearchProductItem({required this.searchProductModel, Key? key})
      : super(key: key);

  @override
  State<SearchProductItem> createState() => _SearchProductItemState();
}

class _SearchProductItemState extends State<SearchProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _searchProduct,
      leading: SizedBox(
        width: 50,
        height: 50,
        child: getClipRReact(
          borderRadius: 10,
          child: ImageLoading(
            imageUrl: widget.searchProductModel.image,
            imageWidth: 50,
            imageHeight: 50,
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

  /// search product button check = tayyor
  void _searchProduct() async {
    context.read<SearchBloc>().add(SearchSaveHistoryEvent());
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builderContext) => ProductDetailScreen(
        productId: widget.searchProductModel.id,
        restaurantId: widget.searchProductModel.vendor.id,
      ),
    );
  }
}
