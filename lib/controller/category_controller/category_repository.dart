import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/category_model/category_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/ui/home/home_screen.dart';
import 'package:delivery_service/ui/search/search_screen.dart';

enum CategoryType {
  all,
  search,
}

/// [CategoryRepository] bu [CategoryNetworkService] dan kelgan ma'lumotlarni parse qiladi (class modelga o'girish)
/// agar qandaydir error (xato) bo'lsa, uni handle (hatolikni topish) qiladi
/// va error yoki Catgory Model qaytaradi
abstract class CategoryRepository {
  Future<DataResponseModel<List<CategoryModel>>> getAllCategories();

  Future<DataResponseModel<List<CategoryModel>>> getSearchCategories();
}

class CategoryRepositoryImpl extends CategoryRepository {
  /// [CategoryNetworkService] category ni network bilan ishlash clasi
  final CategoryNetworkService networkService;

  CategoryRepositoryImpl({required this.networkService});

  /// [HomeScreen] dagi categories
  @override
  Future<DataResponseModel<List<CategoryModel>>> getAllCategories() async {
    final response = await _fetchCategories(categoryType: CategoryType.all);
    return response;
  }

  /// [SearchScreen] dagi categories
  @override
  Future<DataResponseModel<List<CategoryModel>>> getSearchCategories() async {
    final response = await _fetchCategories(categoryType: CategoryType.search);
    return response;
  }

  Future<DataResponseModel<List<CategoryModel>>> _fetchCategories(
      {required CategoryType categoryType}) async {
    try {
      final NetworkResponseModel response = (categoryType == CategoryType.all)
          ? await networkService.getAllCategories()
          : await networkService.getSearchCategories();

      if (response.status &&
          response.response != null &&
          response.response?.data.containsKey("data")) {
        final List<CategoryModel> categories =
            parseCategoryModel(response.response?.data["data"]);

        return DataResponseModel.success(model: categories);
      } else {
        return getDataResponseErrorHandler<List<CategoryModel>>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }
}
