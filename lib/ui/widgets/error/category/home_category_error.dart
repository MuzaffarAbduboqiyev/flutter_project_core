import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class HomeCategoryError extends StatelessWidget {
  final Function refreshFunction;

  const HomeCategoryError({required this.refreshFunction, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => refreshFunction.call(),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning,
              size: 40,
              color: Colors.red,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.refresh,
                  color: getCurrentTheme(context).textTheme.bodyLarge?.color,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  translate("error.refresh"),
                  style: getCurrentTheme(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
