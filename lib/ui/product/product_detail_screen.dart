import 'package:delivery_service/controller/product_controller/product_bloc.dart';
import 'package:delivery_service/controller/product_controller/product_event.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/model/product_model/product_variation_model.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/ui/widgets/shimmer/product/product_deteil_shimmer.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  final int restaurantId;

  const ProductDetailScreen({
    required this.productId,
    required this.restaurantId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        ProductState.initial(),
        repository: singleton(),
      )..add(
          ProductInitialEvent(
            productId: productId,
            restaurantId: restaurantId,
          ),
        ),
      child: const ProductDetailPage(),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");
  List<ProductVariationModel> variationModels = [];
  num _price = 0;

  addCart() {
    context.read<ProductBloc>().add(
          ProductCartEvent(
            context: context,
            productVariations: variationModels
                .where((element) => element.selectedCount > 0)
                .toList(),
          ),
        );
  }

  // add qilish
  increaseCount(int index) {
    if (variationModels[index].selectedCount < variationModels[index].count) {
      setState(() {
        variationModels[index] = variationModels[index].copyWith(
          selectedCount: variationModels[index].selectedCount + 1,
        );

        _price += variationModels[index].price;
      });
    }
  }

  // remove bitta kamaytrish
  decreaseCount(int index) {
    if (variationModels[index].selectedCount > 0) {
      setState(() {
        variationModels[index] = variationModels[index].copyWith(
          selectedCount: variationModels[index].selectedCount - 1,
        );
        _price -= variationModels[index].price;
      });
    }
  }

  _refresh() {
    context.read<ProductBloc>().add(ProductRefreshEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 48),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: getCurrentTheme(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.productStatus == ProductStatus.cartChanged) {
            Navigator.pop(context);
          }
          if (state.productStatus == ProductStatus.error) {
            if (kDebugMode) {
              print("Error: ${state.error}");
            }
          }

          if (state.productDetailModel.variations.isNotEmpty &&
              variationModels.isEmpty) {
            _price = 0;
            variationModels = state.productDetailModel.variations;
            for (var element in variationModels) {
              _price += (element.selectedCount * element.price);
            }
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) =>
              state.productStatus == ProductStatus.loading
                  ? const ProductDetailShimmer()
                  : state.productStatus == ProductStatus.error
                      ? ConnectionErrorWidget(refreshFunction: _refresh)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back)),
                            Expanded(
                              child: _body(state),
                            ),
                            const SizedBox(height: 10),
                            _cart(),
                          ],
                        ),
        ),
      ),
    );
  }

  _body(ProductState state) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: getClipRReact(
                borderRadius: 32,
                child: ImageLoading(
                  imageUrl: state.productDetailModel.image,
                  imageWidth: double.maxFinite,
                  imageHeight: 304,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              state.productDetailModel.name,
              style: getCurrentTheme(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 12),
            Text(
              state.productDetailModel.description,
              style: getCurrentTheme(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: variationModels
                  .asMap()
                  .map((index, variationModel) {
                    return MapEntry(
                        index,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      variationModel.name.toCapitalized(),
                                      style: getCurrentTheme(context)
                                          .textTheme
                                          .bodyLarge,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${moneyFormatter.format(variationModel.price)} ${translate("sum")}",
                                      style: getCurrentTheme(context)
                                          .textTheme
                                          .labelMedium,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "${translate("in_stock")}: ${variationModel.count}",
                                      style: getCurrentTheme(context)
                                          .textTheme
                                          .labelMedium,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 130,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: getContainerDecoration(
                                      context,
                                      fillColor:
                                          getCurrentTheme(context).cardColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () => decreaseCount(index),
                                          child: const Icon(
                                            Icons.remove,
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            variationModel.selectedCount
                                                .toString(),
                                            style: getCurrentTheme(context)
                                                .textTheme
                                                .bodyLarge,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        InkWell(
                                          onTap: () => increaseCount(index),
                                          child: const Icon(
                                            Icons.add,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  })
                  .values
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  _cart() {
    return InkWell(
      onTap: addCart,
      child: Container(
        decoration: getContainerDecoration(
          context,
          fillColor: getCurrentTheme(context).indicatorColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              translate("add").toUpperCase(),
              style: getCustomStyle(context: context, color: Colors.black),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                "${moneyFormatter.format(_price)} ${translate("sum")}",
                style: getCustomStyle(context: context, color: Colors.black),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
