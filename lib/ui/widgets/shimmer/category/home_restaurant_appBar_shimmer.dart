import 'package:delivery_service/util/theme/decorations.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantAppBarShimmer extends StatelessWidget {
  const RestaurantAppBarShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.white,
            child: Container(
              height: 254.0,
              width: double.infinity,
              decoration: getContainerDecoration(context,
                  fillColor: Colors.white, borderRadius: 0.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16,left: 16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade500,
              highlightColor: Colors.white,
              child: const Icon(Icons.arrow_back),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0,right: 24.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Shimmer.fromColors(
                //   baseColor: Colors.grey.shade500,
                //   highlightColor: Colors.white,
                //   child: const Icon(Icons.search),
                // ),
                // const SizedBox(width: 20),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade500,
                  highlightColor: Colors.white,
                  child: const Icon(Icons.favorite_border),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade500,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 40.0,
                        width: 174.0,
                        decoration: getContainerDecoration(context,
                            fillColor: Colors.white, borderRadius: 14.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade500,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 40.0,
                        width: 102.0,
                        decoration: getContainerDecoration(context,
                            fillColor: Colors.white, borderRadius: 14.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade500,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 40.0,
                    width: 135.0,
                    decoration: getContainerDecoration(context,
                        fillColor: Colors.white, borderRadius: 14.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade500,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 40.0,
                      width: 242.0,
                      decoration: getContainerDecoration(context,
                          fillColor: Colors.white, borderRadius: 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
