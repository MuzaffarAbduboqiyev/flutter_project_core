import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository;
  late StreamSubscription listenerCartProducts;

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

    on<RestaurantCartEvent>(
      _listenCartProducts,
      transformer: concurrent(),
    );

    on<RestaurantCartUpdateEvent>(
      _updateCartProducts,
      transformer: concurrent(),
    );

    listenerCartProducts = restaurantRepository
        .listenCartProducts()
        .listen((cartProductVariations) {
      add(
        RestaurantCartEvent(
          productVariations: cartProductVariations,
        ),
      );
    });
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

    add(RestaurantCartUpdateEvent());
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

    add(RestaurantCartUpdateEvent());
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

  FutureOr<void> _listenCartProducts(
      RestaurantCartEvent event, Emitter<RestaurantState> emit) {
    int totalCount = 0;
    int totalAmount = 0;
    List<int> selectedProductsId = [];

    state.products.asMap().forEach((index, productModel) {
      state.products[index] = state.products[index].copyWith(selectedCount: 0);
      for (ProductCartData productVariation in event.productVariations) {
        if (productVariation.productId == productModel.id) {
          state.products[index] = state.products[index].copyWith(
            selectedCount: (state.products[index].selectedCount +
                productVariation.selectedCount),
          );

          totalAmount +=
              (productVariation.selectedCount * productVariation.price);

          if (!selectedProductsId.contains(productModel.id)) {
            totalCount += 1;
            selectedProductsId.add(productModel.id);
          }
        }
      }
    });

    emit(
      state.copyWith(
        totalAmount: totalAmount,
        totalCount: totalCount,
      ),
    );
  }

  FutureOr<void> _updateCartProducts(
      RestaurantCartUpdateEvent event, Emitter<RestaurantState> emit) async {
    final response = await restaurantRepository.getCartProducts();
    add(
      RestaurantCartEvent(
        productVariations: response,
      ),
    );
  }

  @override
  close() async {
    listenerCartProducts.cancel();
    super.close();
  }
}
