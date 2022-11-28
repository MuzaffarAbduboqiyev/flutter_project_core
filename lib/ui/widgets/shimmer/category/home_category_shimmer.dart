import 'package:delivery_service/util/theme/decorations.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeCategoryShimmer extends StatelessWidget {
  const HomeCategoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 70,
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: getContainerDecoration(
              context,
            ),
            child: Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: getContainerDecoration(
                  context,
                  borderRadius: 4,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 15,
            width: 70,
            decoration: getContainerDecoration(
              context,
              fillColor: Colors.white,
            ),
          ),
        ]),
      ),
    );
  }
}
