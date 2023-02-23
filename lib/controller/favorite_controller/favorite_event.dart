import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

abstract class FavoriteEvent {}

class FavoriteListenEvent extends FavoriteEvent {
  final List<FavoriteData> favoriteData;

  FavoriteListenEvent({required this.favoriteData});
}

class FavoriteDeleteEvent extends FavoriteEvent {
  final FavoriteData favoriteData;

  FavoriteDeleteEvent({
    required this.favoriteData,
  });
}

class FavoriteClearEvent extends FavoriteEvent {}

/*
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_event.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_repository.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;
  final RestaurantRepository restaurantRepository;
  late StreamSubscription streamSubscription;

  FavoriteBloc(
    super.initialState, {
    required this.favoriteRepository,
    required this.restaurantRepository,
  }) {
    on<FavoriteListenEvent>(
      _listenFavorite,
      transformer: concurrent(),
    );

    on<FavoriteDeleteEvent>(
      _deleteFavorite,
      transformer: concurrent(),
    );

    on<FavoriteClearEvent>(
      _clearFavorite,
      transformer: concurrent(),
    );

    on<FavoriteChangeEvent>(
      _changeFavorite,
      transformer: concurrent(),
    );

    streamSubscription = favoriteRepository.listenFavorite().listen((favorite) {
      add(
        FavoriteListenEvent(favoriteData: favorite),
      );
    });
  }

  /// listen favorite
  FutureOr<void> _listenFavorite(
      FavoriteListenEvent event, Emitter<FavoriteState> emit) async {
    emit(
      state.copyWith(favoriteData: event.favoriteData),
    );
    state.restaurantModel.asMap().forEach((index, element) {
      state.restaurantModel[index] =
          state.restaurantModel[index].copyWith(isFavorite: false);
      for (var favoriteData in event.favoriteData) {
        if (element.id == favoriteData.id) {
          state.restaurantModel[index] =
              state.restaurantModel[index].copyWith(isFavorite: true);
        }
      }
    });
    emit(
      state.copyWith(
        restaurantModel: state.restaurantModel,
      ),
    );
  }

  FutureOr<void> _deleteFavorite(
      FavoriteDeleteEvent event, Emitter<FavoriteState> emit) async {
    await favoriteRepository.deleteFavorite(
      favoriteData: event.favoriteData,
    );
  }

  FutureOr<void> _clearFavorite(
      FavoriteClearEvent event, Emitter<FavoriteState> emit) async {
    await favoriteRepository.clearFavorite();
  }

  /// change favorite
  FutureOr<void> _changeFavorite(
      FavoriteChangeEvent event, Emitter<FavoriteState> emit) async {
    await restaurantRepository.changeRestaurantFavoriteState(
        restaurantModel: event.restaurantModel);
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

 */
