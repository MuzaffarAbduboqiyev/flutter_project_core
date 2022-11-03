import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/category_controller/category_repository.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryRepository categoryRepository;
  final RestaurantRepository restaurantRepository;

  HomeBloc({
    required this.categoryRepository,
    required this.restaurantRepository,
  }) : super(HomeState.initial()) {
    /// Har qanday on<Event> eventTransformer ga murojat qilish uchun, Bloc ga Event ni add qilish kerak
    /// Ya'ni Bloc(context.read<Bloc>()).add(Event); qilinadi
    /// Misol: context.read<HomeBloc>.add(HomeGetCategoriesEvent());
    /// bu misolda on<HomeGetCategoriesEvent> eventTransformer ga murojat qilinadi
    on<HomeGetCategoriesEvent>(
      _getAllCategories,
      transformer: concurrent(),
    );

    on<HomeChangeSelectedCategoryEvent>(
      _changeSelectedCategory,
      transformer: sequential(),
    );

    on<HomeGetRestaurantsEvent>(
      _getRestaurants,
      transformer: restartable(),
    );
  }

  FutureOr<void> _getAllCategories(
      HomeGetCategoriesEvent event, Emitter<HomeState> emit) async {
    if (state.categoryStatus != CategoryStatus.loading) {
      emit(
        state.copyWith(
          categoryStatus: CategoryStatus.loading,
        ),
      );

      final DataResponseModel<List<CategoryModel>> response =
          await categoryRepository.getAllCategories();

      emit(
        state.copyWith(
          selectedCategoryId: -1,
          categories: response.data,
          categoryStatus:
              (response.status) ? CategoryStatus.loaded : CategoryStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _changeSelectedCategory(
      HomeChangeSelectedCategoryEvent event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        selectedCategoryId: (state.selectedCategoryId == event.categoryModel.id)
            ? -1
            : event.categoryModel.id,
      ),
    );

    /// Selected Category item o'zgarganda Category ga mos Restaurantlarni olib kelish kerak
    /// Shuning uchun HomeGetRestaurantsEvent Blocga add qildik
    add(HomeGetRestaurantsEvent());
  }

  FutureOr<void> _getRestaurants(
      HomeGetRestaurantsEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        restaurantStatus: RestaurantStatus.loading,
      ),
    );

    final response = (state.selectedCategoryId != -1)
        ? await restaurantRepository.getCategoryRestaurants(
            categoryId: state.selectedCategoryId,
          )
        : await restaurantRepository.getAllRestaurants();

    emit(
      state.copyWith(
        restaurantStatus: (response.status)
            ? RestaurantStatus.loaded
            : RestaurantStatus.error,
        restaurants: response.data,
      ),
    );
  }
}
