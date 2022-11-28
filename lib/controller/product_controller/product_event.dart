import 'package:delivery_service/model/product_model/product_detail_model.dart';
import 'package:delivery_service/model/product_model/product_variation_model.dart';

abstract class ProductEvent {}

class ProductInitialEvent extends ProductEvent {
  int productId;
  ProductDetailModel? productDetailModel;

  ProductInitialEvent({
    required this.productId,
    this.productDetailModel,
  });
}

class ProductGetEvent extends ProductEvent {}

class ProductRefreshEvent extends ProductEvent {}

class ProductCartEvent extends ProductEvent {
  final List<ProductVariationModel> productVariations;

  ProductCartEvent({required this.productVariations});
}
