import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/model/search_model/vendor_model.dart';
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
  final RestaurantModel restaurantModel;
  final List<CategoryModel> categoryModel;
  final List<SearchData> searchData;
  final ProductModel productModel;
  final VendorModel vendorModel;
  final int categoryId;
  final bool token;
  final String error;

  SearchState({
    required this.searchStatus,
    required this.searchName,
    required this.searchResponseModel,
    required this.restaurantModel,
    required this.categoryModel,
    required this.searchData,
    required this.productModel,
    required this.vendorModel,
    required this.categoryId,
    required this.token,
    required this.error,
  });

  factory SearchState.initial() => SearchState(
        searchStatus: SearchStatus.init,
        searchName: "",
        searchResponseModel: SearchResponseModel.example(),
        restaurantModel: RestaurantModel.example(),
        categoryModel: [],
        searchData: [],
        productModel: ProductModel.example(),
        vendorModel: VendorModel.example(),
        categoryId: 0,
        token: false,
        error: "",
      );

  SearchState copyWith({
    SearchStatus? searchStatus,
    String? searchName,
    SearchResponseModel? searchResponseModel,
    RestaurantModel? restaurantModel,
    List<CategoryModel>? categoryModel,
    List<SearchData>? searchData,
    ProductModel? productModel,
    VendorModel? vendorModel,
    int? categoryId,
    bool? token,
    String? error,
  }) =>
      SearchState(
        searchStatus: searchStatus ?? this.searchStatus,
        searchName: searchName ?? this.searchName,
        searchResponseModel: searchResponseModel ?? this.searchResponseModel,
        restaurantModel: restaurantModel ?? this.restaurantModel,
        categoryModel: categoryModel ?? this.categoryModel,
        searchData: searchData ?? this.searchData,
        productModel: productModel ?? this.productModel,
        vendorModel: vendorModel ?? this.vendorModel,
        categoryId: categoryId ?? this.categoryId,
        token: token ?? this.token,
        error: error ?? this.error,
      );
}
