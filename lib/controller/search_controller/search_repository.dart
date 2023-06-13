import 'dart:isolate';

import 'package:delivery_service/controller/category_controller/category_repository.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/model/search_model/search_network_service.dart';
import 'package:delivery_service/model/search_model/search_response_model.dart';

abstract class SearchRepository {
  Future<DataResponseModel<SearchResponseModel>> searchCategory({
    required String searchName,
    required int categoryId,
  });

  Future<DataResponseModel<List<CategoryModel>>> searchCategories();

  Future<bool> removeSearchHistory({required SearchData searchData});

  Future<bool> clearSearchHistory();

  Future<bool> saveSearchHistory({required String searchName});

  Stream<List<SearchData>> listenSearchHistory();
}

class SearchRepositoryImpl extends SearchRepository {
  /// Search oynadagi search qilingan product va vendorlarni serverdan fetch(olish) uchun ishlatiladi
  final SearchNetworkService searchNetworkService;

  /// Search oynadagi categories larni serverdan olib kelish va uni parse qilish
  /// CategoryRepository ishi bo'lganligi uchun biz buni CategoryRepository ichida qilib,
  /// SearchRepository da o'sha fetch va parse qilingan methodni chaqirilamiz
  final CategoryRepository categoryRepository;
  final MoorDatabase moorDatabase;

  SearchRepositoryImpl({
    required this.searchNetworkService,
    required this.categoryRepository,
    required this.moorDatabase,
  });

  /// search search
  @override
  Future<DataResponseModel<SearchResponseModel>> searchCategory({
    required String searchName,
    required int categoryId,
  }) async {
    try {
      final networkResponse = await searchNetworkService.searchCategoryUrl(
          searchName: searchName, categoryId: categoryId);
      // final jsonData  = await Isolate.run(() async {
      //   final fileData = await File(filename).readAsString();
      // });
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
  Stream<List<SearchData>> listenSearchHistory() =>
      moorDatabase.listenSearchHistory();

  @override
  Future<bool> removeSearchHistory({required SearchData searchData}) async {
    await moorDatabase.deleteSearchHistory(searchData.searchName);
    return true;
  }

  /// clear Search History
  @override
  Future<bool> clearSearchHistory() async {
    await moorDatabase.clearSearchHistory();
    return true;
  }

  @override
  Future<bool> saveSearchHistory({required String searchName}) async {
    await moorDatabase.insertSearchHistory(SearchData(searchName: searchName));
    return true;
  }
}
