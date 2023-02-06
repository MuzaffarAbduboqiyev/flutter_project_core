import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCategoryItem extends StatefulWidget {
  final CategoryModel categoryModel;

  const SearchCategoryItem({
    required this.categoryModel,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchCategoryItem> createState() => _SearchCategoryItemState();
}

class _SearchCategoryItemState extends State<SearchCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: _changeSearchName,
        child: Container(
          decoration: getContainerDecoration(context),
          height: 160,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageLoading(
                imageUrl: widget.categoryModel.image,
                imageWidth: 62,
                imageHeight: 70,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                widget.categoryModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getCurrentTheme(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _changeSearchName() async {
    print("Search GridView Product");
    context
        .read<SearchBloc>()
        .add(SearchNameEvent(searchName: widget.categoryModel.name));
  }
}
