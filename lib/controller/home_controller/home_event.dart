import 'package:delivery_service/model/category_model/category_model.dart';

abstract class HomeEvent {}

class HomeGetCategoriesEvent extends HomeEvent {}

class HomeGetRestaurantsEvent extends HomeEvent {}

class HomeChangeSelectedCategoryEvent extends HomeEvent {
  final CategoryModel categoryModel;

  HomeChangeSelectedCategoryEvent({required this.categoryModel});
}
