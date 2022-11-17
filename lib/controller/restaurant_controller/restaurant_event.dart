import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

abstract class RestaurantEvent {}

class RestaurantInitEvent extends RestaurantEvent {
  final int? restaurantId;
  final RestaurantModel? restaurantModel;
  final List<CategoryModel>? categories;
  final List<ProductModel>? products;

  RestaurantInitEvent({
    required this.restaurantId,
    required this.restaurantModel,
    required this.categories,
    required this.products,
  });
}

class RestaurantGetEvent extends RestaurantEvent {}

class RestaurantCategoriesEvent extends RestaurantEvent {}

class RestaurantSelectedCategoryEvent extends RestaurantEvent {
  final int selectedCategoryId;

  RestaurantSelectedCategoryEvent({required this.selectedCategoryId});
}

