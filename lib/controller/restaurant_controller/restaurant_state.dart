import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

/// Restaurant larni holatini bilish va boshqarish uchun [RestaurantStatus] holatlar ebumini yaratib oldik
enum RestaurantStatus {
  init, // boshlang'ich
  loading, // yuklash
  loaded, // yuklangan
  error, // xato
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

  final int totalCount;
  final int totalAmount;

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
    required this.totalCount,
    required this.totalAmount,
    required this.error,
  });

  // initial = boshlang'ich
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
        totalCount: 0,
        totalAmount: 0,
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
    int? totalCount,
    int? totalAmount,
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
        totalCount: totalCount ?? this.totalCount,
        totalAmount: totalAmount ?? this.totalAmount,
        error: error ?? this.error,
      );
}
