import 'package:delivery_service/model/product_model/product_detail_model.dart';

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
  final ProductDetailModel productDetailModel;
  final String error;

  ProductState({
    required this.productStatus,
    required this.productId,
    required this.productDetailModel,
    required this.error,
  });

  factory ProductState.initial() => ProductState(
        productStatus: ProductStatus.init,
        productId: 0,
        productDetailModel: ProductDetailModel.example(),
        error: "",
      );

  ProductState copyWith({
    ProductStatus? productStatus,
    int? productId,
    ProductDetailModel? productDetailModel,
    String? error,
  }) =>
      ProductState(
        productStatus: productStatus ?? this.productStatus,
        productId: productId ?? this.productId,
        productDetailModel: productDetailModel ?? this.productDetailModel,
        error: error ?? this.error,
      );
}
