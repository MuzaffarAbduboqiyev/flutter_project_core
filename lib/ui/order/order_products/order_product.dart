import 'package:delivery_service/controller/order_controller/order_bloc.dart';
import 'package:delivery_service/controller/order_controller/order_event.dart';
import 'package:delivery_service/controller/order_controller/order_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
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
  num price = 0;

  /// order product count bitta qushish
  increaseCount() {
    if (widget.product.count > widget.product.selectedCount) {
      final ProductCartData product = widget.product
          .copyWith(selectedCount: widget.product.selectedCount + 1);
      context
          .read<OrderBloc>()
          .add(OrderUpdateProductEvent(productsCart: product));
      price += widget.product.price;
    }
  }

  /// order product count bitta kamayishi
  decreaseCount() {
    if (widget.product.selectedCount > 1) {
      final ProductCartData product = widget.product
          .copyWith(selectedCount: widget.product.selectedCount - 1);
      context
          .read<OrderBloc>()
          .add(OrderUpdateProductEvent(productsCart: product));
      price -= widget.product.price;
    } else {
      removeProduct();
    }
  }

  /// product count 0 ga kelganda delet bulishi
  removeProduct() {
    context.read<OrderBloc>().add(
          OrderDeleteProductEvent(
            deleteProduct: widget.product,
            productId: widget.product.productId,
            variationId: widget.product.variationId,
          ),
        );
  }

  _deleteProduct() {
    context.read<OrderBloc>().add(
          OrderDeleteProductEvent(
            deleteProduct: widget.product,
            productId: widget.product.productId,
            variationId: widget.product.variationId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Dismissible(
          onDismissed: (value) => _deleteProduct(),
          key: ValueKey(state.orderProducts),
          background: Container(
            color: errorTextColor,
            child: const Icon(Icons.delete_outline),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getClipRReact(
                  borderRadius: 10,
                  child: ImageLoading(
                    imageUrl: widget.product.image,
                    imageHeight: 70,
                    imageWidth: 70,
                    imageFitType: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        maxLines: 2,
                      ),
                      Text(
                        "${translate("in_stock")}: ${widget.product.count.toString()} x",
                        style: getCurrentTheme(context).textTheme.labelSmall,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "${moneyFormatter.format(widget.product.price)} ${translate("sum")}",
                        style: getCurrentTheme(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 130,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: getContainerDecoration(
                    context,
                    fillColor: getCurrentTheme(context).cardColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: decreaseCount,
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.product.selectedCount.toString(),
                          style: getCurrentTheme(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: increaseCount,
                        child: const Icon(Icons.add),
                      ),
                    ],
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
