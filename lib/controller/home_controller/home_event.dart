import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class HomeEvent {}

class HomeGetCategoriesEvent extends HomeEvent {}

class HomeGetRestaurantsEvent extends HomeEvent {}

class HomeChangeSelectedCategoryEvent extends HomeEvent {
  final CategoryModel categoryModel;

  HomeChangeSelectedCategoryEvent({required this.categoryModel});
}

/// location
class HomeListenLocationEvent extends HomeEvent {
  final LocationData locationData;

  HomeListenLocationEvent({required this.locationData});
}
