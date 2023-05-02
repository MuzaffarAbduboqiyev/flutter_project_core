import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

abstract class HomeEvent {}

/// listen restaurant
class HomeListenFavoriteEvent extends HomeEvent {
  final List<FavoriteData> favoriteData;

  HomeListenFavoriteEvent({
    required this.favoriteData,
  });
}

/// Change favorite
class HomeChangeFavoriteEvent extends HomeEvent {
  final RestaurantModel restaurantModel;

  HomeChangeFavoriteEvent({
    required this.restaurantModel,
  });
}

class HomeGetCategoriesEvent extends HomeEvent {}

class HomeGetRestaurantsEvent extends HomeEvent {}

class HomeChangeSelectedCategoryEvent extends HomeEvent {
  final CategoryModel categoryModel;

  HomeChangeSelectedCategoryEvent({required this.categoryModel});
}

/// listen location
class HomeListenLocationEvent extends HomeEvent {
  final LocationData locationData;

  HomeListenLocationEvent({required this.locationData});
}

/// listen Token
class HomeListenTokenEvent extends HomeEvent {
  final bool token;

  HomeListenTokenEvent({required this.token});
}

/// get token
class HomeGetTokenEvent extends HomeEvent {}
