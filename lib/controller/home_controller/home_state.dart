import 'package:delivery_service/model/category_model/category_model.dart';

/// [HomeScreen] dagi category larni holatini bilish va boshqarish uchun [CategoryStatus] holatlar ebumini yaratib oldik
enum CategoryStatus {
  init,
  loading,
  loaded,
  error,
}

/// [HomeScreen] dagi restaurant larni holatini bilish va boshqarish uchun [RestaurantStatus] holatlar ebumini yaratib oldik
enum RestaurantStatus {
  init,
  loading,
  loaded,
  error,
}

/// [HomeScreen] ni umumiy holatini boshqarish va kerakli data(ma'lumotlarni) saqlab turish uchun
/// [HomeState] class ini yaratib oldik
class HomeState {
  final CategoryStatus categoryStatus;
  final RestaurantStatus restaurantStatus;
  final List<CategoryModel> categories;
  final int selectedCategoryId;
  final String error;

  HomeState({
    required this.categoryStatus,
    required this.restaurantStatus,
    required this.categories,
    required this.selectedCategoryId,
    required this.error,
  });

  /// [HomeState.initial] HomeStateni hech qanday amal bajarmay, birinchi ishga tushgandagi holati
  /// HomeState.initial => [HomeBloc] initial bo'lganda chaqiriladi
  factory HomeState.initial() => HomeState(
        categoryStatus: CategoryStatus.init,
        restaurantStatus: RestaurantStatus.init,
        categories: [],
        selectedCategoryId: -1,
        error: "",
      );

  /// [HomeState] dagai saqlangan data larni o'zgartirish uchun ishlatiladi
  /// bu methodda faqat berilgan berilgan qiymatlar o'zgaradi, ya'ni yangi qiymatlarni oladi
  /// null bo'lgan yani mehtodni chaqirganda berilmagan qiymatlar, avvalgi eski qiymatlarini o'zlariga o'zlashtirib oladi
  HomeState copyWith({
    CategoryStatus? categoryStatus,
    RestaurantStatus? restaurantStatus,
    List<CategoryModel>? categories,
    int? selectedCategoryId,
    String? error,
  }) =>
      HomeState(
        categoryStatus: categoryStatus ?? this.categoryStatus,
        restaurantStatus: restaurantStatus ?? this.restaurantStatus,
        categories: categories ?? this.categories,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        error: error ?? this.error,
      );
}
