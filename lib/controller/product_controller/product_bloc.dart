import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/product_controller/product_event.dart';
import 'package:delivery_service/controller/product_controller/product_repository.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(super.initialState, {required this.productRepository}) {
    on<ProductInitialEvent>(
      _init,
      transformer: sequential(),
    );

    on<ProductGetEvent>(
      _getProduct,
      transformer: sequential(),
    );

    on<ProductRefreshEvent>(
      _refreshProduct,
      transformer: sequential(),
    );

    on<ProductCartEvent>(
      _changeCart,
      transformer: sequential(),
    );

    on<ProductVariationEvent>(
      _changeSelectedVariation,
      transformer: sequential(),
    );
  }

  FutureOr<void> _init(ProductInitialEvent event, Emitter<ProductState> emit) {
    emit(
      state.copyWith(
        productDetailModel: event.productDetailModel,
        productId: event.productId,
        restaurantId: event.restaurantId,
      ),
    );

    add(ProductGetEvent());
  }

  FutureOr<void> _getProduct(
      ProductGetEvent event, Emitter<ProductState> emit) async {
    emit(
      state.copyWith(
        productStatus: ProductStatus.loading,
      ),
    );

    final response = await productRepository.getProductDetail(
      productId: state.productId,
      restaurantId: state.selectedVariationModel.id,

    );

    emit(
      state.copyWith(
        productStatus:
            (response.status) ? ProductStatus.loaded : ProductStatus.error,
        productDetailModel: response.data,
        error: response.message,
      ),
    );
  }

  FutureOr<void> _refreshProduct(
      ProductRefreshEvent event, Emitter<ProductState> emit) async {
    add(ProductGetEvent());
  }

  FutureOr<void> _changeCart(
      ProductCartEvent event, Emitter<ProductState> emit) async {
    emit(
      state.copyWith(
        productStatus: ProductStatus.loading,
      ),
    );

    final SimpleResponseModel response =
        await productRepository.changeProductSelectedDatabase(
      context: event.context,
      productId: state.productId,
      restaurantId: state.restaurantId,
      productImage: state.productDetailModel.image,
      selectedVariations: event.productVariations,
    );

    emit(
      state.copyWith(
        productStatus:
            (response.status) ? ProductStatus.cartChanged : ProductStatus.error,
        error: response.message,
      ),
    );
  }

  FutureOr<void> _changeSelectedVariation(
      ProductVariationEvent event, Emitter<ProductState> emit) {
    emit(
      state.copyWith(
        selectedVariationModel: event.selectedVariationModel,
      ),
    );
  }
}
