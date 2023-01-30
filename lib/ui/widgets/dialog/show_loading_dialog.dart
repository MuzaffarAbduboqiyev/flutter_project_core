import 'package:flutter/material.dart';

class ShowLoadingDialog extends StatelessWidget {
  const ShowLoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      ),
    );
  }
}
