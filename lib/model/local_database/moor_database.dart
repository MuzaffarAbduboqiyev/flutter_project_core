import 'package:delivery_service/model/favorite_model/favorite_%20model.dart';
import 'package:delivery_service/model/search_model/search_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

@UseMoor(tables: [
  Search,
  Favorite,
])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: 'application_database.sqlite', logStatements: true));

  @override
  int get schemaVersion => 2;

  /// Search history operations
  ///
  /// Insert new search name -> Yangi qidiruv nomini kiritish
  /// Agar bu nom avval bo'lsa almashtiradi, yoki yangi nom qo'shadi
  Future insertSearchHistory(SearchData searchData) =>
      into(search).insert(searchData, mode: InsertMode.insertOrReplace);

  /// Get search history -> Saqlangan Search history ni qaytaradi
  /// Bu Future qaytaradi, yani bir so'ralgan vaqtda bir marta data qaytaradi
  Future<List<SearchData>> getSearchHistory() {
    return select(search).get();
  }

  /// Listen(tinlash) search history -> Qidiruvlar saqlangan jadvalda o'zgarish bo'lsa,
  /// shu o'zgarishlarni eshitib(qaytarib) turadi
  Stream<List<SearchData>> listenSearchHistory() {
    return select(search).watch();
  }

  /// Delete search history item => Saqlangan qidiruv itemini saqlanganlardan o'chiradi
  /// Ya'ni Search Tabledan shu nomga mos item o'chiradi
  deleteSearchHistory(String searchName) =>
      (delete(search)..where((dbItem) => dbItem.searchName.equals(searchName)))
          .go();

  /// Clear(tozalash) search history
  /// Saqlangan qidiruvlar Table ini tozalab tashlaydi
  /// Hamma saqlangan qidiruvlarni o'chirib tashlaydi
  clearSearchHistory() => (delete(search)).go();

  /// Favorite
  Future insertFavorite(FavoriteData favoriteData) =>
      into(favorite).insert(favoriteData, mode: InsertMode.insertOrReplace);

  Future<List<FavoriteData>> getFavourite() {
    return select(favorite).get();
  }



  Stream<List<FavoriteData>> listenFavourite() {
    return select(favorite).watch();
  }

  Stream<FavoriteData?> listenSingleFavorite(int restaurantId) {
    return (select(favorite)
          ..where((databaseItem) => databaseItem.id.equals(restaurantId)))
        .watchSingleOrNull();
  }

  Future<FavoriteData?> getSingleFavorite(int restaurantId) {
    return (select(favorite)
          ..where((databaseItem) => databaseItem.id.equals(restaurantId)))
        .getSingleOrNull();
  }


  deleteFavorite(int restaurantId) =>
      (delete(favorite)..where((dbItem) => dbItem.id.equals(restaurantId)))
          .go();
}
