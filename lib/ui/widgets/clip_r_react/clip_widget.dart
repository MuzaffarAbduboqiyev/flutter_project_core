import 'package:flutter/material.dart';

Widget getClipRReact({
  required Widget child,
  double borderRadius = 4.0,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: child,
  );
}
