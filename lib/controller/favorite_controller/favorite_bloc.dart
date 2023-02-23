import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_event.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_repository.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  late StreamSubscription streamSubscription;

  FavoriteBloc(
    super.initialState, {
    required this.favoriteRepository,
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

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
