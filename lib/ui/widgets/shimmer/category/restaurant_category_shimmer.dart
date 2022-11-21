import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantCategoryShimmer extends StatelessWidget {
  const RestaurantCategoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: ListView.builder(
        itemCount: 15,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.white,
          child: Container(
            height: 20,
            width: 180,
            decoration: getContainerDecoration(
              context,
              borderRadius: 14,
              fillColor: Colors.white,
            ),
            margin: const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }
}
