/*
    displayLarge,
    displayMedium,
    displaySmall,
    headlineMedium,
    headlineSmall,
    titleLarge,
    titleMedium,
    titleSmall,
    bodyLarge,
    bodyMedium,
    bodySmall,
    labelLarge,
    labelSmall,
   */
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:flutter/material.dart';


/// Light mode uchun Text Styles
/// Light mode uchun Text Style [getLightStyle] chaqiriladi
TextTheme lightTextTheme = TextTheme(
  //Registration title
  displayLarge: getLightStyle(
    weight: FontWeight.w600,
    textSize: 24,
  ),

  //Products title
  displayMedium: getLightStyle(
    weight: FontWeight.w600,
    textSize: 18,
  ),

  bodyLarge: getLightStyle(),

  bodyMedium: getLightStyle(
    textSize: 14,
  ),
  bodySmall: getLightStyle(textSize: 12),

  labelLarge: getLightStyle(
    color: lightHintColor,
  ),

  labelMedium: getLightStyle(
    color: lightHintColor,
    textSize: 14,
  ),

  //Body  text
  labelSmall: getLightStyle(
    color: lightHintColor,
    textSize: 12,
  ),
);

/// Dark Text Styles
/// Dark mode uchun Text Style [getDarkStyle] chaqiriladi
TextTheme darkTextTheme = TextTheme(
  //Registration title
  displayLarge: getDarkStyle(
    weight: FontWeight.w600,
    textSize: 24,
  ),

  //Products title
  displayMedium: getDarkStyle(
    weight: FontWeight.w600,
    textSize: 18,
  ),

  bodyLarge: getDarkStyle(),
  bodyMedium: getDarkStyle(
    textSize: 14,
  ),
  bodySmall: getDarkStyle(textSize: 12),

  labelLarge: getDarkStyle(
    color: hintColor,
  ),

  labelMedium: getDarkStyle(
    color: hintColor,
    textSize: 14,
  ),

  //Body  text
  labelSmall: getDarkStyle(
    color: hintColor,
    textSize: 12,
  ),
);
