import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

mainButtonWidget(BuildContext context, bool? condition, Function? clickFunction,
    String? buttonTitle) {
  _callFunction() {
    clickFunction?.call();
  }

  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed:
          (condition != null && condition == true) ? _callFunction : null,
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          backgroundColor: (condition != null && condition == true)
              ? getCurrentTheme(context).indicatorColor
              : getCurrentTheme(context).disabledColor),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          buttonTitle ?? "",
          style: getCustomStyle(
            context: context,
            weight: FontWeight.w500,
            color: backgroundColor,
          ),
        ),
      ),
    ),
  );
}
