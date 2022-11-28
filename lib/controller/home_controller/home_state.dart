import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

/// [HomeScreen] ni umumiy holatini boshqarish va kerakli data(ma'lumotlarni) saqlab turish uchun
/// [HomeState] class ini yaratib oldik
class HomeState {
  final CategoryStatus categoryStatus;
  final RestaurantStatus restaurantStatus;
  final List<CategoryModel> categories;
  final int selectedCategoryId;
  final List<RestaurantModel> restaurants;
  final String error;

  HomeState({
    required this.categoryStatus,
    required this.restaurantStatus,
    required this.categories,
    required this.selectedCategoryId,
    required this.restaurants,
    required this.error,
  });

  /// [HomeState.initial] HomeStateni hech qanday amal bajarmay, birinchi ishga tushgandagi holati
  /// HomeState.initial => [HomeBloc] initial bo'lganda chaqiriladi
  factory HomeState.initial() => HomeState(
        categoryStatus: CategoryStatus.init,
        restaurantStatus: RestaurantStatus.init,
        categories: [],
        selectedCategoryId: -1,
        restaurants: [],
        error: "",
      );

  /// [HomeState] dagai saqlangan data(malumotlarni) larni o'zgartirish uchun ishlatiladi
  /// bu methodda faqat berilgan  qiymatlar o'zgaradi, ya'ni yangi qiymatlarni oladi
  /// null bo'lgan yani mehtodni chaqirganda berilmagan qiymatlar, avvalgi eski qiymatlarini o'zlariga o'zlashtirib oladi
  HomeState copyWith({
    CategoryStatus? categoryStatus,
    RestaurantStatus? restaurantStatus,
    List<CategoryModel>? categories,
    int? selectedCategoryId,
    List<RestaurantModel>? restaurants,
    String? error,
  }) =>
      HomeState(
        categoryStatus: categoryStatus ?? this.categoryStatus,
        restaurantStatus: restaurantStatus ?? this.restaurantStatus,
        categories: categories ?? this.categories,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        restaurants: restaurants ?? this.restaurants,
        error: error ?? this.error,
      );
}
