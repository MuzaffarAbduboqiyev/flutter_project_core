import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeRestaurantShimmer extends StatelessWidget {
  const HomeRestaurantShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.white,
          child: Container(
            height: 246,
            width: double.maxFinite,
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 180,
                  decoration: getContainerDecoration(
                    context,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  height: 22,
                  width: (MediaQuery.of(context).size.width / 2),
                  decoration: getContainerDecoration(
                    context,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: 17,
                  width: (MediaQuery.of(context).size.width / 3 * 2),
                  decoration: getContainerDecoration(
                    context,
                    fillColor: Colors.white,
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
