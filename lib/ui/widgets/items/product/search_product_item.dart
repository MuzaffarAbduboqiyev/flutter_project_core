import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductItem extends StatelessWidget {
  final ProductModel productModel;

  const SearchProductItem({required this.productModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        context.read<SearchBloc>().add(SearchSaveHistoryEvent());
      },
      leading: SizedBox(
        width: 50,
        height: 50,
        child: getClipRReact(
          borderRadius: 10,
          child: ImageLoading(
            imageUrl: productModel.image,
            imageWidth: 50,
            imageHeight: 50,
          ),
        ),
      ),
      title: Text(
        productModel.name,
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
}
