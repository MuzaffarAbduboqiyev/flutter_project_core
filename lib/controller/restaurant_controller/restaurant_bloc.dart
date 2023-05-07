import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/product/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository;
  late StreamSubscription streamSubscription;

  RestaurantBloc({required this.restaurantRepository})
      : super(RestaurantState.initial()) {
    on<RestaurantInitEvent>(
      _initial,
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

    streamSubscription = restaurantRepository
        .listenCartProducts()
        .listen((cartProductVariations) {
      add(
        RestaurantCartEvent(productVariations: cartProductVariations),
      );
    });
  }

  // _initial = boshlang'ich
  FutureOr<void> _initial(
      RestaurantInitEvent event, Emitter<RestaurantState> emit) async {
    emit(
      state.copyWith(
        restaurantId: event.restaurantId,
        productId: event.productId,
        categoryId: event.categoryId,
      ),
    );

    final restaurant = await restaurantRepository.getRestaurantDetails(
        restaurantId: state.restaurantId);
    final product = await restaurantRepository.getRestaurantProducts(
      restaurantId: state.restaurantId,
      categoryId: state.categoryId,
      searchName: state.searchName,
    );
    final category = await restaurantRepository.getRestaurantCategories(
        restaurantId: state.restaurantId);
    emit(
      state.copyWith(
        restaurantStatus: (restaurant.status & product.status)
            ? RestaurantStatus.loaded
            : RestaurantStatus.error,
        restaurantModel: restaurant.data,
        categoryModel: category.data,
      ),
    );

    if (event.productId != 0) {
      /// ignore: use_build_context_synchronously
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: event.context,
        builder: (builderContext) => ProductDetailScreen(
          restaurantId: event.restaurantId,
          productId: event.productId!,
          categoryId: event.categoryId,
        ),
      );
    }
  }

  /// _getRestaurant = restoran oling
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

  /// _getCategories = Kategoriyalarni oling
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
        categoryModel: response.data,
      ),
    );
  }

  /// _changeSelectedCategory = Tanlangan toifani o'zgartirish
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
        productModel: response.data,
      ),
    );

    add(RestaurantCartUpdateEvent());
  }

  /// _refreshProducts = Mahsulotlarni yangilash
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
        productModel: response.data,
      ),
    );

    add(RestaurantCartUpdateEvent());
  }

  /// _changeFavorite = Sevimlini o'zgartirish
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

  /// _listenCartProducts = Savat mahsulotlarini tinglang
  FutureOr<void> _listenCartProducts(
      RestaurantCartEvent event, Emitter<RestaurantState> emit) {
    int totalCount = 0;
    int totalAmount = 0;
    List<int> selectedProductsId = [];

    state.productModel.asMap().forEach((index, productModel) {
      state.productModel[index] =
          state.productModel[index].copyWith(selectedCount: 0);
      for (ProductCartData productVariation in event.productVariations) {
        if (productVariation.productId == productModel.id) {
          state.productModel[index] = state.productModel[index].copyWith(
            selectedCount: (state.productModel[index].selectedCount +
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

  // _updateCartProducts = Savat mahsulotlarini yangilash
  FutureOr<void> _updateCartProducts(
      RestaurantCartUpdateEvent event, Emitter<RestaurantState> emit) async {
    final response = await restaurantRepository.getCartProducts();
    add(
      RestaurantCartEvent(productVariations: response),
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
