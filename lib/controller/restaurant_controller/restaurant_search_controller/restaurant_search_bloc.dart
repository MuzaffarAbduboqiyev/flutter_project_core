import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantSearchBloc
    extends Bloc<RestaurantSearchEvent, RestaurantSearchState> {
  final RestaurantSearchRepository restaurantSearchRepository;
  late StreamSubscription streamSubscription;

  RestaurantSearchBloc(super.initialState,
      {required this.restaurantSearchRepository}) {
    on<RestaurantSearchGetProductEvent>(
      _searchProducts,
      transformer: concurrent(),
    );
    on<RestaurantSearchListenProductEvent>(
      _listenProducts,
      transformer: concurrent(),
    );
    streamSubscription =
        restaurantSearchRepository.listenProducts().listen((listen) {
      add(
        RestaurantSearchListenProductEvent(productCartData: listen),
      );
    });
  }

  FutureOr<void> _searchProducts(RestaurantSearchGetProductEvent event,
      Emitter<RestaurantSearchState> emit) async {
    emit(
      state.copyWith(
        restaurantSearchStatus: (event.searchName.isNotEmpty)
            ? RestaurantSearchStatus.loading
            : RestaurantSearchStatus.loaded,
        searchName: event.searchName,
      ),
    );
    if (event.searchName.isNotEmpty) {
      final response = await restaurantSearchRepository.restaurantSearchProduct(
        restaurantId: event.restaurantId,
        searchName: event.searchName,
      );
      emit(
        state.copyWith(
          restaurantSearchStatus: (response.status)
              ? RestaurantSearchStatus.loaded
              : RestaurantSearchStatus.error,
          productModel: response.data,
          error: response.message,
        ),
      );
    }
  }

  FutureOr<void> _listenProducts(RestaurantSearchListenProductEvent event,
      Emitter<RestaurantSearchState> emit) async {
    emit(
      state.copyWith(
        productCartData: event.productCartData,
      ),
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
