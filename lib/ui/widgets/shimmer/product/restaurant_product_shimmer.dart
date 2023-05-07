import 'package:delivery_service/util/theme/decorations.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantProductShimmer extends StatelessWidget {
  const RestaurantProductShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 260,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _productShimmer(context),
            ),
            Expanded(
              child: _productShimmer(context),
            ),
          ],
        ),
      ),
    );
  }

  _productShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.white,
      child: Container(
        height: 250,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: getContainerDecoration(
          context,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: 145,
              decoration: getContainerDecoration(
                context,
                borderRadius: 4,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 35,
              width: (double.maxFinite / 2),
              decoration: getContainerDecoration(
                context,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 29,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 29,
                      decoration: getContainerDecoration(
                        context,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 29,
                      decoration: getContainerDecoration(
                        context,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
