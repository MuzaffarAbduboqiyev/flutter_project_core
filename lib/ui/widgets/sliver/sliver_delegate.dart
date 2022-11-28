import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/cupertino.dart';


class ProductSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  ProductSliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.maxFinite,
      color: getCurrentTheme(context).backgroundColor,
      height: 90,
      child: child,
    );
  }

  @override
  bool shouldRebuild(ProductSliverDelegate oldDelegate) {
    return true;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 90;

  @override
  // TODO: implement minExtent
  double get minExtent => 90;
}
