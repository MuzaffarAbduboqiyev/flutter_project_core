import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

AppBar simpleAppBar(BuildContext context, String? title) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    backgroundColor: getCurrentTheme(context).backgroundColor,
    title: Text(
      title ?? "",
      style: getCurrentTheme(context).textTheme.displayLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
