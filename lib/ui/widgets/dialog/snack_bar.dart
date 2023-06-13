import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String message,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
        backgroundColor: getCurrentTheme(context).cardColor,
        showCloseIcon: true,
        content: Text(
          message,
          style: getCurrentTheme(context).textTheme.bodyMedium,
        ),
      ),
    );
