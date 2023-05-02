import 'package:delivery_service/model/local_database/moor_database.dart';

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
