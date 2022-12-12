import 'package:delivery_service/model/product_model/product_detail_model.dart';
import 'package:delivery_service/model/product_model/product_variation_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

enum ProductStatus {
  init,
  loading,
  loaded,
  cartChanged,
  error,
}

class ProductState {
  final ProductStatus productStatus;
  final int productId;
  final RestaurantModel restaurantModel;
  final ProductDetailModel productDetailModel;
  final String error;
  final ProductVariationModel selectedVariationModel;

  ProductState({
    required this.productStatus,
    required this.productId,
    required this.restaurantModel,
    required this.productDetailModel,
    required this.selectedVariationModel,
    required this.error,
  });

  factory ProductState.initial() => ProductState(
        productStatus: ProductStatus.init,
        productId: 0,
        restaurantModel: RestaurantModel.example(),
        productDetailModel: ProductDetailModel.example(),
        selectedVariationModel: ProductVariationModel.example(),
        error: "",
      );

  ProductState copyWith({
    ProductStatus? productStatus,
    int? productId,
    RestaurantModel? restaurantModel,
    ProductDetailModel? productDetailModel,
    ProductVariationModel? selectedVariationModel,
    String? error,
  }) =>
      ProductState(
        productStatus: productStatus ?? this.productStatus,
        productId: productId ?? this.productId,
        restaurantModel: restaurantModel ?? this.restaurantModel,
        productDetailModel: productDetailModel ?? this.productDetailModel,
        selectedVariationModel:
            selectedVariationModel ?? this.selectedVariationModel,
        error: error ?? this.error,
      );
}
