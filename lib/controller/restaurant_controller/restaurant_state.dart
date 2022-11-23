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
  final int restaurantId;

  final CategoryStatus categoryStatus;
  final List<CategoryModel> categories;
  final int selectedCategoryId;

  final ProductStatus productStatus;
  final List<ProductModel> products;

  final String searchName;
  final bool isFavorite;
  final String error;

  RestaurantState({
    required this.restaurantStatus,
    required this.restaurantModel,
    required this.restaurantId,
    required this.categoryStatus,
    required this.categories,
    required this.selectedCategoryId,
    required this.productStatus,
    required this.products,
    required this.searchName,
    required this.isFavorite,
    required this.error,
  });

  factory RestaurantState.initial() => RestaurantState(
    restaurantStatus: RestaurantStatus.init,
        restaurantModel: RestaurantModel.example(),
        restaurantId: 0,
        categoryStatus: CategoryStatus.init,
        categories: [],
        selectedCategoryId: -1,
        productStatus: ProductStatus.init,
        products: [],
        searchName: "",
        isFavorite: false,
        error: "",
      );

  RestaurantState copyWith({
    RestaurantStatus? restaurantStatus,
    RestaurantModel? restaurantModel,
    int? restaurantId,
    CategoryStatus? categoryStatus,
    List<CategoryModel>? categories,
    int? selectedCategoryId,
    ProductStatus? productStatus,
    List<ProductModel>? products,
    String? searchName,
    bool? isFavorite,
    String? error,
  }) =>
      RestaurantState(
        restaurantStatus: restaurantStatus ?? this.restaurantStatus,
        restaurantModel: restaurantModel ?? this.restaurantModel,
        restaurantId: restaurantId ?? this.restaurantId,
        categoryStatus: categoryStatus ?? this.categoryStatus,
        categories: categories ?? this.categories,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        productStatus: productStatus ?? this.productStatus,
        products: products ?? this.products,
        searchName: searchName ?? this.searchName,
        isFavorite: isFavorite ?? this.isFavorite,
        error: error ?? this.error,
      );
}
