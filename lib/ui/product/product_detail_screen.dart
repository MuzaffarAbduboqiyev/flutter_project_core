import 'package:delivery_service/controller/product_controller/product_bloc.dart';
import 'package:delivery_service/controller/product_controller/product_event.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({
    required this.productId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        ProductState.initial(),
        repository: singleton(),
      )..add(ProductInitialEvent(
          productId: productId,
        )),
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
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) =>
            state.productStatus == ProductStatus.loading
                ? imageLoader()
                : state.productStatus == ProductStatus.error
                    ? ConnectionErrorWidget(refreshFunction: _refresh)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _body(state),
                          ),
                          _cart(),
                        ],
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
            const SizedBox(
              height: 28,
            ),
            Text(
              state.productDetailModel.name,
              style: getCurrentTheme(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              state.productDetailModel.description,
              style: getCurrentTheme(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }

  _cart() {
    return Container(
      height: 70,
      color: getCurrentTheme(context).indicatorColor,
    );
  }
}
