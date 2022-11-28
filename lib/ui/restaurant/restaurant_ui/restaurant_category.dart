import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/ui/widgets/items/category/restaurant_category_item.dart';
import 'package:delivery_service/ui/widgets/shimmer/category/restaurant_category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantCategory extends StatelessWidget {
  const RestaurantCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
      return state.categoryStatus == CategoryStatus.loading
          ? const RestaurantCategoryShimmer()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: SizedBox(
                height: 32.0,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) => RestaurantCategoryItem(
                    selectedItemId: state.selectedCategoryId,
                    categoryModel: state.categories[index],
                  ),
                ),
              ),
            );
    });
  }
}
