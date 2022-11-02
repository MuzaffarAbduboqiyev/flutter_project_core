import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

BoxDecoration getContainerDecoration(
  BuildContext context, {
  double borderRadius = 12,
  Color? fillColor,
  Color? borderColor,
}) {
  return BoxDecoration(
    color: (fillColor != null)
        ? fillColor
        : null,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(
      width: 1,
      color: borderColor ?? getCurrentTheme(context).hintColor,
    ),
  );
}
