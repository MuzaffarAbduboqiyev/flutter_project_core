import 'package:delivery_service/model/product_model/product_detail_model.dart';
import 'package:delivery_service/model/product_model/product_variation_model.dart';
import 'package:flutter/material.dart';

abstract class ProductEvent {}

class ProductInitialEvent extends ProductEvent {
  int productId;
  int restaurantId;
  ProductDetailModel? productDetailModel;

  ProductInitialEvent({
    required this.productId,
    required this.restaurantId,
    this.productDetailModel,
  });
}

class ProductGetEvent extends ProductEvent {}

class ProductRefreshEvent extends ProductEvent {}

class ProductCartEvent extends ProductEvent {
  final BuildContext context;

  final List<ProductVariationModel> productVariations;

  ProductCartEvent(
      {required this.context, required this.productVariations});
}

class ProductVariationEvent extends ProductEvent {
  final ProductVariationModel selectedVariationModel;

  ProductVariationEvent({required this.selectedVariationModel});
}
