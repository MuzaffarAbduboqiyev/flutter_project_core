import 'package:delivery_service/util/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoaderDialogAnimation extends EasyLoadingAnimation {
  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: SizeTransition(
        sizeFactor: controller,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: child,
      ),
    );
  }
}

void initialLoadingDialog() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 5000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = buttonColor
    ..boxShadow = <BoxShadow>[]
    ..backgroundColor = hintColor
    ..indicatorColor = backgroundColor
    ..textColor = textColor
    ..maskColor = buttonColor
    ..maskType = EasyLoadingMaskType.clear
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = LoaderDialogAnimation();
}
