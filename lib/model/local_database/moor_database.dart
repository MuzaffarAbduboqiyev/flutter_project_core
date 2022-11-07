import 'package:delivery_service/model/search_model/search_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

@UseMoor(tables: [
  Search,
])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'application_database.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

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
}
