import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/ui/widgets/error/category/home_category_error.dart';
import 'package:delivery_service/ui/widgets/items/category/home_category_item.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/ui/widgets/shimmer/category/home_category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  void refreshHomeCategory() {
    context.read<HomeBloc>().add(HomeGetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 98,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) =>
            (state.categoryStatus == CategoryStatus.loading)
                ? const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: HomeCategoryShimmer(),
                  )
                : (state.categoryStatus == CategoryStatus.error)
                    ? HomeCategoryError(refreshFunction: refreshHomeCategory)
                    : ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,

                          itemBuilder: (context, index) => HomeCategoryItem(
                            categoryModel: state.categories[index],
                            selectedCategoryItemId: state.selectedCategoryId,
                          ),
                        ),
                      ),
      ),
    );
  }
}
