import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

/// [CategoryNetworkService] Applicationdagi barcha category lar bilan bog'liq bo'lgan server ishlarini bajaradi
/// [CategoryNetworkService] Serverdan category lar bo'yicha request (so'rov) lar bilan ishlaydi
abstract class CategoryNetworkService {
  Future<NetworkResponseModel> getAllCategories();
}

class CategoryNetworkServiceImpl extends CategoryNetworkService {
  /// [NetworkService] Bizda server bilan ishlash uchun singleton class yaratilagn. U get va post methodlari bilan ishlaydi
  final NetworkService networkService;

  CategoryNetworkServiceImpl({required this.networkService});

  /// Home pagedagi category larni get (olish) uchun ishlatiladi
  @override
  Future<NetworkResponseModel> getAllCategories() async {
    /// [NetworkService.getMethod] ishlatadi va berilgan url ga request (so'rov) jo'natadi va response (javob) kelguncha kutib turadi
    /// va kelgan javobni qaytaradi
    final response = await networkService.getMethod(url: allCategoriesUrl);
    return response;
  }
}
