import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class RestaurantSearchEvent {}

/// search get product
class RestaurantSearchGetProductEvent extends RestaurantSearchEvent {
  final int restaurantId;
  final String searchName;

  RestaurantSearchGetProductEvent({
    required this.restaurantId,
    required this.searchName,
  });
}

/// moor listen product
class RestaurantSearchListenProductEvent extends RestaurantSearchEvent {
  final List<ProductCartData> productCartData;

  RestaurantSearchListenProductEvent({required this.productCartData});
}
