import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/ui/restaurant/restaurant_ui/restaurant_appbar.dart';
import 'package:delivery_service/ui/restaurant/restaurant_ui/restaurant_category.dart';
import 'package:delivery_service/ui/restaurant/restaurant_ui/restaurant_prodcuts.dart';
import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/refresh/refresh_header.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/ui/widgets/sliver/sliver_delegate.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class RestaurantScreen extends StatelessWidget {
  final int restaurantId;
  final RestaurantModel? restaurantModel;
  final List<CategoryModel>? categories;
  final List<ProductModel>? products;

  const RestaurantScreen({
    required this.restaurantId,
    required this.restaurantModel,
    required this.categories,
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantBloc(
        restaurantRepository: singleton(),
      )..add(
        RestaurantInitEvent(
          restaurantId: restaurantId,
          restaurantModel: restaurantModel,
          categories: categories,
          products: products,
        ),
      ),
      child: const RestaurantPage(),
    );
  }
}

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  late RefreshController refreshController;
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");

  void _refresh() {
    context.read<RestaurantBloc>().add(RestaurantGetEvent());
    context.read<RestaurantBloc>().add(RestaurantCategoriesEvent());
    context.read<RestaurantBloc>().add(RestaurantRefreshProductsEvent());
  }

  void viewCart() {}

  @override
  initState() {
    refreshController = RefreshController(
      initialRefresh: false,
    );
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantBloc, RestaurantState>(
      listener: (context, state) {
        if (state.productStatus == ProductStatus.loaded &&
            refreshController.isRefresh) {
          refreshController.refreshCompleted();
        }
      },
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) => Scaffold(
          backgroundColor: getCurrentTheme(context).backgroundColor,
          appBar: (state.restaurantStatus == RestaurantStatus.error ||
                  state.categoryStatus == CategoryStatus.error ||
                  state.productStatus == ProductStatus.error)
              ? simpleAppBar(context, "")
              : null,
          body: (state.restaurantStatus == RestaurantStatus.error ||
                  state.categoryStatus == CategoryStatus.error ||
                  state.productStatus == ProductStatus.error)
              ? ConnectionErrorWidget(refreshFunction: _refresh)
              : Column(
            mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: NestedScrollView(
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              getRestaurantAppbar(
                                context,
                                state.restaurantModel,
                                state.isFavorite,
                              ),
                              SliverPersistentHeader(
                                pinned: true,
                                delegate: ProductSliverDelegate(
                                  child: const RestaurantCategory(),
                                ),
                              ),
                            ];
                          },
                          body: SmartRefresher(
                            controller: refreshController,
                            enablePullUp: false,
                            enablePullDown: true,
                            onRefresh: _refresh,
                            header: getRefreshHeader(),
                            physics: const BouncingScrollPhysics(),
                            child: const CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: RestaurantProducts(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ),
                  if(state.totalCount > 0)
                      _cart(
                    state.totalCount,
                    state.totalAmount,
                  ),
                ],
              ),
        ),
      ),
    );
  }

  _cart(int count, int price) {
    return InkWell(
      onTap: viewCart,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: getContainerDecoration(
          context,
          fillColor: getCurrentTheme(context).indicatorColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: getContainerDecoration(
                context,
                borderRadius: 8,
                fillColor: Colors.black,
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8,),
              child: Text(
                "$count",
                style: getCurrentTheme(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                translate("view_cart").toUpperCase(),
                style: getCustomStyle(context: context, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "${moneyFormatter.format(price)} ${translate("sum")}",
              style: getCustomStyle(context: context, color: Colors.black),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
