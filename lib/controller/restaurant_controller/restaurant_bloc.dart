import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository;

  RestaurantBloc({required this.restaurantRepository})
      : super(RestaurantState.initial()) {
    on<RestaurantInitEvent>(
      _init,
      transformer: concurrent(),
    );

    on<RestaurantGetEvent>(
      _getRestaurant,
      transformer: concurrent(),
    );

    on<RestaurantCategoriesEvent>(
      _getCategories,
      transformer: concurrent(),
    );

    on<RestaurantSelectedCategoryEvent>(
      _changeSelectedCategory,
      transformer: concurrent(),
    );

    on<RestaurantRefreshProductsEvent>(
      _refreshProducts,
      transformer: concurrent(),
    );

    on<RestaurantFavoriteEvent>(
      _changeFavorite,
      transformer: concurrent(),
    );
  }

  FutureOr<void> _init(
      RestaurantInitEvent event, Emitter<RestaurantState> emit) {
    emit(
      state.copyWith(
        restaurantId: event.restaurantId,
        restaurantModel: event.restaurantModel,
        categories: event.categories,
        products: event.products,
      ),
    );
  }

  FutureOr<void> _getRestaurant(
      RestaurantGetEvent event, Emitter<RestaurantState> emit) async {
    emit(
      state.copyWith(
        restaurantStatus: RestaurantStatus.loading,
      ),
    );

    final response = await restaurantRepository.getRestaurantDetails(
      restaurantId: state.restaurantId,
    );

    final favoriteResponse = await restaurantRepository.getFavoriteState(
        restaurantId: state.restaurantId);

    emit(
      state.copyWith(
        restaurantStatus: (response.status)
            ? RestaurantStatus.loaded
            : RestaurantStatus.error,
        restaurantModel: response.data,
        isFavorite: favoriteResponse,
      ),
    );
  }

  FutureOr<void> _getCategories(
      RestaurantCategoriesEvent event, Emitter<RestaurantState> emit) async {
    emit(
      state.copyWith(
        categoryStatus: CategoryStatus.loading,
      ),
    );

    final response = await restaurantRepository.getRestaurantCategories(
      restaurantId: state.restaurantId,
    );

    emit(
      state.copyWith(
        categoryStatus:
            (response.status) ? CategoryStatus.loaded : CategoryStatus.error,
        categories: response.data,
      ),
    );
  }

  FutureOr<void> _changeSelectedCategory(
    RestaurantSelectedCategoryEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(
      state.copyWith(
        productStatus: ProductStatus.loading,
        selectedCategoryId:
            (state.selectedCategoryId == event.selectedCategoryId)
                ? -1
                : event.selectedCategoryId,
      ),
    );
    final response = await restaurantRepository.getRestaurantProducts(
      restaurantId: state.restaurantId,
      categoryId: state.selectedCategoryId,
      searchName: state.searchName,
    );

    emit(
      state.copyWith(
        productStatus:
            (response.status) ? ProductStatus.loaded : ProductStatus.error,
        products: response.data,
      ),
    );
  }

  FutureOr<void> _refreshProducts(RestaurantRefreshProductsEvent event,
      Emitter<RestaurantState> emit) async {
    emit(
      state.copyWith(
        productStatus: ProductStatus.loading,
      ),
    );
    final response = await restaurantRepository.getRestaurantProducts(
      restaurantId: state.restaurantId,
      categoryId: state.selectedCategoryId,
      searchName: state.searchName,
    );

    emit(
      state.copyWith(
        productStatus:
            (response.status) ? ProductStatus.loaded : ProductStatus.error,
        products: response.data,
      ),
    );
  }

  FutureOr<void> _changeFavorite(
      RestaurantFavoriteEvent event, Emitter<RestaurantState> emit) async {
    emit(
      state.copyWith(
        isFavorite: !state.isFavorite,
      ),
    );

    await restaurantRepository.changeRestaurantFavoriteState(
      restaurantModel: state.restaurantModel,
    );
  }
}
