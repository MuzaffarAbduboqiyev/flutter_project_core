import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

/// [HomeScreen] ni umumiy holatini boshqarish va kerakli data(ma'lumotlarni) saqlab turish uchun
/// [HomeState] class ini yaratib oldik
class HomeState {
  final CategoryStatus categoryStatus;
  final RestaurantStatus restaurantStatus;
  final List<CategoryModel> categoryModel;
  final ProductModel productModel;
  final LocationData locationData;
  final int selectedCategoryId;
  final List<RestaurantModel> restaurantModel;
  final List<FavoriteData> favoriteData;
  final String error;

  HomeState({
    required this.categoryStatus,
    required this.restaurantStatus,
    required this.categoryModel,
    required this.productModel,
    required this.locationData,
    required this.selectedCategoryId,
    required this.restaurantModel,
    required this.favoriteData,
    required this.error,
  });

  /// [HomeState.initial] HomeStateni hech qanday amal bajarmay, birinchi ishga tushgandagi holati
  /// HomeState.initial => [HomeBloc] initial bo'lganda chaqiriladi
  factory HomeState.initial() => HomeState(
        categoryStatus: CategoryStatus.init,
        restaurantStatus: RestaurantStatus.init,
        categoryModel: [],
        productModel: ProductModel.example(),
        locationData: LocationData(
          lat: 0,
          lng: 0,
          name: "",
          selectedStatus: false,
        ),
        selectedCategoryId: -1,
        restaurantModel: [],
        favoriteData: [],
        error: "",
      );

  /// [HomeState] dagai saqlangan data(malumotlarni) larni o'zgartirish uchun ishlatiladi
  /// bu methodda faqat berilgan  qiymatlar o'zgaradi, ya'ni yangi qiymatlarni oladi
  /// null bo'lgan yani mehtodni chaqirganda berilmagan qiymatlar, avvalgi eski qiymatlarini o'zlariga o'zlashtirib oladi
  HomeState copyWith({
    CategoryStatus? categoryStatus,
    RestaurantStatus? restaurantStatus,
    List<CategoryModel>? categoryModel,
    ProductModel? productModel,
    LocationData? locationData,
    int? selectedCategoryId,
    List<RestaurantModel>? restaurantModel,
    List<FavoriteData>? favoriteData,
    String? error,
  }) =>
      HomeState(
        categoryStatus: categoryStatus ?? this.categoryStatus,
        restaurantStatus: restaurantStatus ?? this.restaurantStatus,
        categoryModel: categoryModel ?? this.categoryModel,
        productModel: productModel ?? this.productModel,
        locationData: locationData ?? this.locationData,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        restaurantModel: restaurantModel ?? this.restaurantModel,
        favoriteData: favoriteData ?? this.favoriteData,
        error: error ?? this.error,
      );
}
