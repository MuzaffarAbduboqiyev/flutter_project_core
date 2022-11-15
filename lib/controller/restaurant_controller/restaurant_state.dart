import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

/// Restaurant larni holatini bilish va boshqarish uchun [RestaurantStatus] holatlar ebumini yaratib oldik
enum RestaurantStatus {
  init,
  loading,
  loaded,
  error,
}

class RestaurantState {
  final RestaurantStatus restaurantStatus;
  final RestaurantModel restaurantModel;

  final CategoryStatus categoryStatus;
  final List<CategoryModel> categories;

  final ProductStatus productStatus;
  final List<ProductModel> products;

  final String error;

  RestaurantState({
    required this.restaurantStatus,
    required this.restaurantModel,
    required this.categoryStatus,
    required this.categories,
    required this.productStatus,
    required this.products,
    required this.error,
  });

  factory RestaurantState.initial() => RestaurantState(
        restaurantStatus: RestaurantStatus.init,
        restaurantModel: RestaurantModel.example(),
        categoryStatus: CategoryStatus.init,
        categories: [],
        productStatus: ProductStatus.init,
        products: [],
        error: "",
      );

  RestaurantState copyWith({
    RestaurantStatus? restaurantStatus,
    RestaurantModel? restaurantModel,
    CategoryStatus? categoryStatus,
    List<CategoryModel>? categories,
    ProductStatus? productStatus,
    List<ProductModel>? products,
    String? error,
  }) =>
      RestaurantState(
        restaurantStatus: restaurantStatus ?? this.restaurantStatus,
        restaurantModel: restaurantModel ?? this.restaurantModel,
        categoryStatus: categoryStatus ?? this.categoryStatus,
        categories: categories ?? this.categories,
        productStatus: productStatus ?? this.productStatus,
        products: products ?? this.products,
        error: error ?? this.error,
      );
}
