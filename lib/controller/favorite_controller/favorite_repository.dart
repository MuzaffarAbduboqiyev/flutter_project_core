import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class FavoriteRepository {
  /// listen favorite
  Stream<List<FavoriteData>> listenFavorite();

  /// delete favorite
  Future<bool> deleteFavorite({
    required FavoriteData favoriteData,
  });

  /// clear favorite
  Future<bool> clearFavorite();
}

class FavoriteRepositoryImpl extends FavoriteRepository {
  final MoorDatabase moorDatabase;

  FavoriteRepositoryImpl({
    required this.moorDatabase,
  });

  @override
  Stream<List<FavoriteData>> listenFavorite() => moorDatabase.listenFavourite();

  @override
  Future<bool> deleteFavorite({required FavoriteData favoriteData}) async {
    await moorDatabase.deleteFavorite(favoriteData.id);
    return true;
  }

  @override
  Future<bool> clearFavorite() async {
    await moorDatabase.clearFavorite();
    return true;
  }
}
