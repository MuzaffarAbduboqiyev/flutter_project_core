import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/items/restaurant/home_restaurant_item.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/ui/widgets/shimmer/restaurant/home_restaurant_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRestaurant extends StatefulWidget {
  const HomeRestaurant({Key? key}) : super(key: key);

  @override
  State<HomeRestaurant> createState() => _HomeRestaurantState();
}

class _HomeRestaurantState extends State<HomeRestaurant> {
  void getRestaurantRefresh() {
    context.read<HomeBloc>().add(HomeGetCategoriesEvent());
    context.read<HomeBloc>().add(HomeGetRestaurantsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) =>
          (state.restaurantStatus == RestaurantStatus.loading)
              ? const HomeRestaurantShimmer()
              : (state.restaurantStatus == RestaurantStatus.error)
                  ? ConnectionErrorWidget(refreshFunction: getRestaurantRefresh)
                  : ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: ListView.builder(
                        itemCount: state.restaurantModel.length,
                        itemBuilder: (context, index) => HomeRestaurantItem(
                          restaurantModel: state.restaurantModel[index],
                          productModel: state.productModel,
                          categoryModel: state.categoryModel[index],
                        ),
                      ),
                    ),
    );
  }
}
