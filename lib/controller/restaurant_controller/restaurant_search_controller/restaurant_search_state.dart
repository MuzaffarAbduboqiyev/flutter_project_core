import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_model.dart';

enum RestaurantSearchStatus {
  init,
  loading,
  loaded,
  error,
}

class RestaurantSearchState {
  final RestaurantSearchStatus restaurantSearchStatus;
  final List<ProductModel> productModel;
  final List<ProductCartData> productCartData;
  final String searchName;
  final String error;

  RestaurantSearchState({
    required this.restaurantSearchStatus,
    required this.productModel,
    required this.productCartData,
    required this.searchName,
    required this.error,
  });

  factory RestaurantSearchState.initial() => RestaurantSearchState(
        restaurantSearchStatus: RestaurantSearchStatus.init,
        productModel: [],
        productCartData: [],
        searchName: "",
        error: "",
      );

  RestaurantSearchState copyWith({
    RestaurantSearchStatus? restaurantSearchStatus,
    List<ProductModel>? productModel,
    List<ProductCartData>? productCartData,
    String? searchName,
    String? error,
  }) =>
      RestaurantSearchState(
        restaurantSearchStatus:
            restaurantSearchStatus ?? this.restaurantSearchStatus,
        productModel: productModel ?? this.productModel,
        productCartData: productCartData ?? this.productCartData,
        searchName: searchName ?? this.searchName,
        error: error ?? this.error,
      );
}
