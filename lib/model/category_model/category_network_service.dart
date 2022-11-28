import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

/// [CategoryNetworkService] Applicationdagi barcha category lar bilan bog'liq bo'lgan server ishlarini bajaradi
/// [CategoryNetworkService] Serverdan category lar bo'yicha request (so'rov) lar bilan ishlaydi
///
abstract class CategoryNetworkService {
  Future<NetworkResponseModel> getAllCategories();

  Future<NetworkResponseModel> getSearchCategories();

  Future<NetworkResponseModel> getRestaurantCategories(
      {required int restaurantId});
}

class CategoryNetworkServiceImpl extends CategoryNetworkService {
  /// [NetworkService] Bizda server bilan ishlash uchun singleton
  /// class yaratilagn. U get va post methodlari bilan ishlaydi
  final NetworkService networkService;

  CategoryNetworkServiceImpl({required this.networkService});

  /// Home pagedagi category larni get (olish) uchun ishlatiladi
  @override
  Future<NetworkResponseModel> getAllCategories() async {
    /// [NetworkService.getMethod] ishlatadi va berilgan url ga request (so'rov) jo'natadi
    /// va response (javob) kelguncha kutib turadi
    /// va kelgan javobni qaytaradi
    final response = await networkService.getMethod(url: allCategoriesUrl);
    return response;
  }

  /// Search oynaga kerak bo'ladigan Popular(mashhur, eng ko'p kerak bo'ladigan)
  /// Categories larni serverdan fetch qiladi
  @override
  Future<NetworkResponseModel> getSearchCategories() async {
    final response =
        await networkService.getMethod(url: "$allCategoriesUrl?popular=true");
    return response;
  }

  @override
  Future<NetworkResponseModel> getRestaurantCategories({
    required int restaurantId,
  }) async {
    final response = await networkService.getMethod(
      url: "$allCategoriesUrl?restaurant=$restaurantId",
    );
    return response;
  }
}
