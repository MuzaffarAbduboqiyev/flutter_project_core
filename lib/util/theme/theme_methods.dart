import 'package:delivery_service/util/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Hozirgi Theme datani qaytaradi
/// * Dark bo'lsa [MyTheme.dark] qaytaradi aks holda [MyTheme.light]

ThemeData getCurrentTheme(BuildContext context) {
  return Theme.of(context);
}

/// Hozirgi theme dark bo'lsa [True] aks holda [False] qaytaradi.
bool getDarkThemeState(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
  return isDarkMode;
}
