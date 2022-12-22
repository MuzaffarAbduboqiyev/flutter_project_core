import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Light text style uchun
TextStyle getLightStyle({
  double textSize = 15.0,
  FontStyle style = FontStyle.normal,
  FontWeight weight = FontWeight.w400,
  Color? color,

}) {
  return GoogleFonts.inter(
    fontSize: textSize,
    fontStyle: style,
    fontWeight: weight,
    color: color ?? lightTextColor,
  );
}

/// Dark text style uchun
TextStyle getDarkStyle({
  double textSize = 15.0,

  FontStyle style = FontStyle.normal,
  FontWeight weight = FontWeight.w400,
  Color? color,
}) {
  return GoogleFonts.inter(
    fontSize: textSize,
    fontStyle: style,
    fontWeight: weight,
    color: color ?? textColor,
  );
}

/// Custom Text style uchun, hozirgi Theme ni o'zi aniqlaydi [getCurrentTheme] va shunga mos theme style qaytaradi
/// Agar dark theme bo'lsa dark style qaytaradi [getDarkStyle] aks holsa Light style [getLightStyle]
TextStyle getCustomStyle({
  required BuildContext context,
  double textSize = 15.0,
  FontStyle style = FontStyle.normal,
  FontWeight weight = FontWeight.w400,
  Color? color,

}) {
  return (getDarkThemeState(context))
      ? getDarkStyle(
          style: style,
          textSize: textSize,
          weight: weight,
          color: color,
        )
      : getLightStyle(
          style: style,
          textSize: textSize,
          weight: weight,
          color: color,
        );
}
