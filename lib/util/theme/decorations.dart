import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/cupertino.dart';
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

InputDecoration getSearchDecoration({
  required BuildContext context,
  required String hint,
  double borderRadius = 12,
  required Function clear,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(12),
    hintText: hint,
    prefixIcon: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 0, bottom: 0),
      child: Icon(
        CupertinoIcons.search_circle,
        color: getCurrentTheme(context).hintColor,
      ),
    ),
    suffixIcon: GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 16),
        child: Icon(
          CupertinoIcons.clear_circled,
          color: getCurrentTheme(context).hintColor,
        ),
      ),
      onTap: () {
        clear();
      },
    ),
    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
  );
}
