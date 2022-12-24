import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class HomeLocationDialog extends StatelessWidget {
  const HomeLocationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getCurrentTheme(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(14),
        ),
      ),
    );
  }
}
