import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/search_model/search_response_model.dart';

enum SearchStatus {
  init,
  loading,
  loaded,
  error,
}

class SearchState {
  final SearchStatus searchStatus;
  final String searchName;
  final SearchResponseModel searchResponseModel;
  final List<CategoryModel> categories;
  final List<SearchData> searchHistory;
  final String error;

  SearchState({
    required this.searchStatus,
    required this.searchName,
    required this.searchResponseModel,
    required this.categories,
    required this.searchHistory,
    required this.error,
  });

  factory SearchState.initial() => SearchState(
        searchStatus: SearchStatus.init,
        searchName: "",
        searchResponseModel: SearchResponseModel.example(),
        categories: [],
        searchHistory: [],
        error: "",
      );

  SearchState copyWith({
    SearchStatus? searchStatus,
    String? searchName,
    SearchResponseModel? searchResponseModel,
    List<CategoryModel>? categories,
    List<SearchData>? searchHistory,
    String? error,
  }) =>
      SearchState(
        searchStatus: searchStatus ?? this.searchStatus,
        searchName: searchName ?? this.searchName,
        searchResponseModel: searchResponseModel ?? this.searchResponseModel,
        categories: categories ?? this.categories,
        searchHistory: searchHistory ?? this.searchHistory,
        error: error ?? this.error,
      );
}
