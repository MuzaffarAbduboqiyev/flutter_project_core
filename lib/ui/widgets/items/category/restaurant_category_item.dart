import 'package:delivery_service/controller/restaurant_controller/restaurant_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_event.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantCategoryItem extends StatefulWidget {
  final int selectedItemId;
  final CategoryModel categoryModel;

  const RestaurantCategoryItem({
    required this.selectedItemId,
    required this.categoryModel,
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantCategoryItem> createState() => _RestaurantCategoryItemState();
}

class _RestaurantCategoryItemState extends State<RestaurantCategoryItem> {
  void _itemSelected() {
    context.read<RestaurantBloc>().add(
          RestaurantSelectedCategoryEvent(
            selectedCategoryId: widget.categoryModel.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _itemSelected,
      child: Container(
        decoration: getContainerDecoration(
          context,
          fillColor: (widget.selectedItemId == widget.categoryModel.id)
              ? getCurrentTheme(context).indicatorColor
              : null,
        ),
        height: double.maxFinite,
        width: 180,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            widget.categoryModel.name,
            style: getCurrentTheme(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
