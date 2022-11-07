import 'package:delivery_service/controller/category_controller/category_repository.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/model/search_model/search_network_service.dart';
import 'package:delivery_service/model/search_model/search_response_model.dart';

abstract class SearchRepository {
  Future<DataResponseModel<SearchResponseModel>> search({
    required String searchName,
  });

  Future<DataResponseModel<List<CategoryModel>>> searchCategories();

  Stream<List<SearchData>> searchHistory();
}

class SearchRepositoryImpl extends SearchRepository {
  /// Search oynadagi search qilingan product va vendorlarni serverdan fetch(olish) uchun ishlatiladi
  final SearchNetworkService networkService;

  /// Search oynadagi categories larni serverdan olib kelish va uni parse qilish
  /// CategoryRepository ishi bo'lganligi uchun biz buni CategoryRepository ichida qilib,
  /// SearchRepository da o'sha fetch va parse qilingan methodni chaqirilamiz
  final CategoryRepository categoryRepository;

  /// Search oynadagi saqlangan search history ni LocalDatabase dan olib kelish uchun
  /// LocalDatabase(MoorDatabase) objecti kerak bo'ladi
  final MoorDatabase moorDatabase;

  SearchRepositoryImpl({
    required this.networkService,
    required this.categoryRepository,
    required this.moorDatabase,
  });

  @override
  Future<DataResponseModel<SearchResponseModel>> search({
    required String searchName,
  }) async {
    try {
      final networkResponse =
          await networkService.search(searchName: searchName);
      final response = networkResponse.response;
      if (networkResponse.status && response != null) {
        if (response.data.containsKey("vendors") &&
            response.data.containsKey("products")) {
          final searchResponse = SearchResponseModel.fromMap(response.data);
          return DataResponseModel.success(model: searchResponse);
        } else {
          return getDataResponseErrorHandler(networkResponse);
        }
      } else {
        return getDataResponseErrorHandler(networkResponse);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Future<DataResponseModel<List<CategoryModel>>> searchCategories() async {
    final response = await categoryRepository.getSearchCategories();
    return response;
  }

  @override
  Stream<List<SearchData>> searchHistory() =>
      moorDatabase.listenSearchHistory();
}
