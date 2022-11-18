import 'package:delivery_service/controller/restaurant_controller/restaurant_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantScreen extends StatelessWidget {
  final int restaurantId;
  final RestaurantModel? restaurantModel;
  final List<CategoryModel>? categories;
  final List<ProductModel>? products;

  const RestaurantScreen({
    required this.restaurantId,
    required this.restaurantModel,
    required this.categories,
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantBloc(
        restaurantRepository: singleton(),
      )..add(
          RestaurantInitEvent(
            restaurantId: restaurantId,
            restaurantModel: restaurantModel,
            categories: categories,
            products: products,
          ),
        ),
      child: const RestaurantPage(),
    );
  }
}

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  _refresh() {
    context.read<RestaurantBloc>().add(RestaurantGetEvent());
    context.read<RestaurantBloc>().add(RestaurantCategoriesEvent());
    context.read<RestaurantBloc>().add(RestaurantRefreshProductsEvent());
  }

  @override
  initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
