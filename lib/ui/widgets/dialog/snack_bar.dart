import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String message,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // backgroundColor: currentTheme().appBarTheme.backgroundColor,
        backgroundColor: getCurrentTheme(context).cardColor,
        showCloseIcon: true,
        content: Text(
          message,
          style: getCurrentTheme(context).textTheme.bodyMedium,
        ),
      ),
    );
