import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function confirm,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(
        title,
        style: getCurrentTheme(context).textTheme.displayMedium,
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        style: getCurrentTheme(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(
            translate("no"),
            style: getCurrentTheme(context).textTheme.bodyLarge,
          ),
        ),
        TextButton(
          onPressed: () {
            confirm.call();
            Navigator.pop(dialogContext, true);
          },
          child: Text(
            translate("yes"),
            style: getCurrentTheme(context).textTheme.bodyLarge,
          ),
        ),
      ],
    ),
  );
}
