import 'package:delivery_service/model/product_model/search_product_model.dart';
import 'package:delivery_service/model/search_model/vendor_model.dart';

class SearchResponseModel {
  final List<VendorModel> vendors;
  final List<SearchProductModel> products;

  SearchResponseModel({
    required this.vendors,
    required this.products,
  });

  factory SearchResponseModel.example() => SearchResponseModel(
        vendors: [],
        products: [],
      );

  factory SearchResponseModel.fromMap(Map<String, dynamic> response) =>
      SearchResponseModel(
        vendors: parseVendorModel(response["vendors"]),
        products: parseSearchProductModel(response["products"]),
      );
}
