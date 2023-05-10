import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
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
  final CategoryStatus categoryStatus;
  final ProductStatus productStatus;
  final RestaurantModel restaurantModel;
  final List<CategoryModel> categoryModel;
  final List<ProductModel> productModel;
  final int restaurantId;
  final int categoryId;
  final int productId;
  final int selectedCategoryId;
  final String searchName;
  final bool isFavorite;
  final int totalCount;
  final int totalAmount;
  final bool token;
  final String error;

  RestaurantState({
    required this.restaurantStatus,
    required this.restaurantModel,
    required this.productModel,
    required this.categoryModel,
    required this.restaurantId,
    required this.productId,
    required this.categoryId,
    required this.categoryStatus,
    required this.selectedCategoryId,
    required this.productStatus,
    required this.searchName,
    required this.isFavorite,
    required this.totalCount,
    required this.totalAmount,
    required this.token,
    required this.error,
  });

  // initial = boshlang'ich
  factory RestaurantState.initial() => RestaurantState(
        restaurantStatus: RestaurantStatus.init,
        restaurantModel: RestaurantModel.example(),
        categoryModel: [],
        productModel: [],
        restaurantId: 0,
        productId: 0,
        categoryId: 0,
        selectedCategoryId: -1,
        categoryStatus: CategoryStatus.init,
        productStatus: ProductStatus.init,
        searchName: "",
        isFavorite: false,
        totalCount: 0,
        totalAmount: 0,
        token: false,
        error: "",
      );

  RestaurantState copyWith({
    RestaurantStatus? restaurantStatus,
    RestaurantModel? restaurantModel,
    List<CategoryModel>? categoryModel,
    List<ProductModel>? productModel,
    int? restaurantId,
    int? productId,
    int? categoryId,
    CategoryStatus? categoryStatus,
    int? selectedCategoryId,
    ProductStatus? productStatus,
    String? searchName,
    bool? isFavorite,
    int? totalCount,
    int? totalAmount,
    bool? token,
    String? error,
  }) =>
      RestaurantState(
        restaurantStatus: restaurantStatus ?? this.restaurantStatus,
        restaurantModel: restaurantModel ?? this.restaurantModel,
        categoryModel: categoryModel ?? this.categoryModel,
        productModel: productModel ?? this.productModel,
        restaurantId: restaurantId ?? this.restaurantId,
        productId: productId ?? this.productId,
        categoryId: categoryId ?? this.categoryId,
        categoryStatus: categoryStatus ?? this.categoryStatus,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        productStatus: productStatus ?? this.productStatus,
        searchName: searchName ?? this.searchName,
        isFavorite: isFavorite ?? this.isFavorite,
        totalCount: totalCount ?? this.totalCount,
        totalAmount: totalAmount ?? this.totalAmount,
        token: token ?? this.token,
        error: error ?? this.error,
      );
}
