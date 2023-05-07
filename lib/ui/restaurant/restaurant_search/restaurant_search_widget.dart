import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_state.dart';
import 'package:delivery_service/ui/product/product_detail_screen.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantSearchWidget extends StatefulWidget {
  final int categoryId;
  final Function goBack;

  const RestaurantSearchWidget({
    Key? key,
    required this.categoryId,
    required this.goBack,
  }) : super(key: key);

  @override
  State<RestaurantSearchWidget> createState() => _RestaurantSearchWidgetState();
}

class _RestaurantSearchWidgetState extends State<RestaurantSearchWidget> {
  int productCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme(context).backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<RestaurantSearchBloc, RestaurantSearchState>(
          buildWhen: (prevState, currentState) {
            return currentState.searchName.isEmpty;
          },
          builder: (context, state) => ScrollConfiguration(
            behavior: const CupertinoScrollBehavior(),
            child: GridView.builder(
              itemCount: state.productModel.length,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 240.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                crossAxisCount: 2,
                childAspectRatio:
                    (((MediaQuery.of(context).size.width - 48) / 2) / 160),
              ),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => _checkButton(state.productModel[index]),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: getContainerDecoration(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageLoading(
                        imageUrl: state.productModel[index].image,
                        imageWidth: 100,
                        imageHeight: 80,
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        state.productModel[index].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getCurrentTheme(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _checkButton(productModel) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builderContext) => ProductDetailScreen(
        restaurantId: productModel.restaurantId,
        productId: productModel.id,
        categoryId: widget.categoryId,
      ),
    );
  }
}
/*
  Container(
                        decoration: getContainerDecoration(
                          context,
                          borderRadius: 8,
                          fillColor: getCurrentTheme(context).indicatorColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Text(
                          "${state.productCartData[index].selectedCount}",
                          style: getCustomStyle(
                              context: context,
                              color: Colors.black,
                              textSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      )
 */
