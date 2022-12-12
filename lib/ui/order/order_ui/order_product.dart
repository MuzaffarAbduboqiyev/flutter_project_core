import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProduct extends StatefulWidget {
  final ProductCartData product;

  const OrderProduct({required this.product, Key? key}) : super(key: key);

  @override
  State<OrderProduct> createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  final moneyFormatter = NumberFormat("#,##0", "uz_UZ");
  List<ProductCartData> productCart = [];
  num _price = 0;

  increaseCount() {
    if (widget.product.count > widget.product.selectedCount) {
      final ProductCartData product = widget.product
          .copyWith(selectedCount: widget.product.selectedCount + 1);
      context
          .read<OrderBloc>()
          .add(OrderUpdateProductEvent(productsCart: product));
      _price += widget.product.price;
      _price = 0;
      for (var element in productCart) {
        _price += (element.selectedCount * element.price);
      }
    }
  }

  decreaseCount() {
    if (widget.product.selectedCount > 1) {
      final ProductCartData product = widget.product
          .copyWith(selectedCount: widget.product.selectedCount - 1);
      context
          .read<OrderBloc>()
          .add(OrderUpdateProductEvent(productsCart: product));
      _price -= widget.product.price;
    } else {
      removeProduct();
    }
  }

  removeProduct() {
    context
        .read<OrderBloc>()
        .add(OrderDeleteProductEvent(deleteProduct: widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListTile(
          leading: ImageLoading(
            imageUrl: widget.product.image,
            imageHeight: 70,
            imageWidth: 70,
          ),
          title: Text(
            widget.product.name,
            style: getCustomStyle(
                context: context,
                textSize: 15,
                weight: FontWeight.w500,
                color: textColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${translate("in_stock")}: ${widget.product.count.toString()} x",
                  style: getCurrentTheme(context).textTheme.labelMedium,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "${moneyFormatter.format(widget.product.price)} ${translate("sum")}",
                  style: getCurrentTheme(context).textTheme.labelMedium,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ]),
          trailing: Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: getContainerDecoration(
              context,
              fillColor: getCurrentTheme(context).cardColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => decreaseCount(),
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
                    widget.product.selectedCount.toString(),
                    style: getCurrentTheme(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () => increaseCount(),
                  child: const Icon(
                    Icons.add,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
