import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:flutter/material.dart';

abstract class RestaurantEvent {}

/// Restaurant initial
class RestaurantInitEvent extends RestaurantEvent {
  final BuildContext context;
  final int restaurantId;
  final int? productId;
  final int categoryId;

  RestaurantInitEvent({
    required this.context,
    required this.restaurantId,
    required this.productId,
    required this.categoryId,
  });
}

class RestaurantGetEvent extends RestaurantEvent {}

class RestaurantCategoriesEvent extends RestaurantEvent {}

class RestaurantSelectedCategoryEvent extends RestaurantEvent {
  final int selectedCategoryId;

  RestaurantSelectedCategoryEvent({required this.selectedCategoryId});
}

class RestaurantRefreshProductsEvent extends RestaurantEvent {}

class RestaurantFavoriteEvent extends RestaurantEvent {}

class RestaurantCartUpdateEvent extends RestaurantEvent {}

class RestaurantCartEvent extends RestaurantEvent {
  final List<ProductCartData> productVariations;

  RestaurantCartEvent({
    required this.productVariations,
  });
}
