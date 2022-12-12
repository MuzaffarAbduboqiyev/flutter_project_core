import 'package:delivery_service/controller/product_controller/product_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/ui/widgets/items/product/restaurant_product_item.dart';
import 'package:delivery_service/ui/widgets/shimmer/product/restaurant_product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantProducts extends StatelessWidget {

  const RestaurantProducts({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        return state.productStatus == ProductStatus.loading
            ? const RestaurantProductShimmer()
            : GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0,),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      (((MediaQuery.of(context).size.width - 32) / 2) / 260),
                ),
                itemBuilder: (_, index) => RestaurantProductItem(
                  productModel: state.products[index],
                   restaurantModel: RestaurantModel.example(),
                ),
                itemCount: state.products.length,
              );
      }
    );
  }
}
