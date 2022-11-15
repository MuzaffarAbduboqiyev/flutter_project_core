import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_state.dart';
import 'package:delivery_service/model/product_model/search_product_model.dart';
import 'package:delivery_service/model/restaurant_model/vendor_model.dart';
import 'package:delivery_service/ui/widgets/items/product/search_product_item.dart';
import 'package:delivery_service/ui/widgets/items/restaurant/search_vendor_item.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({Key? key}) : super(key: key);

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: CustomScrollView(
            slivers: [
              if (state.searchResponseModel.vendors.isNotEmpty)
                SliverToBoxAdapter(
                  child: Text(
                    translate("restaurant.restaurants"),
                    style: getCurrentTheme(context).textTheme.displayMedium,
                  ),
                ),
              if (state.searchResponseModel.vendors.isNotEmpty)
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
              if (state.searchResponseModel.vendors.isNotEmpty)
                SliverToBoxAdapter(
                  child: _vendors(state.searchResponseModel.vendors),
                ),
              if (state.searchResponseModel.vendors.isNotEmpty)
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
              if (state.searchResponseModel.products.isNotEmpty)
                SliverToBoxAdapter(
                  child: Text(
                    translate("search.products"),
                    style: getCurrentTheme(context).textTheme.displayMedium,
                  ),
                ),
              if (state.searchResponseModel.products.isNotEmpty)
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
              SliverToBoxAdapter(
                child: _products(state.searchResponseModel.products),
              )
            ],
          ),
        ),
      ),
    );
  }

  _vendors(List<VendorModel> vendors) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => SearchVendorItem(
        vendorModel: vendors[index],
      ),
      itemCount: vendors.length,
    );
  }

  _products(List<SearchProductModel> products) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => SearchProductItem(
        productModel: products[index],
      ),
      itemCount: products.length,
    );
  }
}
