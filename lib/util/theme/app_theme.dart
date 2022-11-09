import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/text_theme.dart';
import 'package:flutter/material.dart';

// Application Theme
class MyTheme {
  /// Application Light theme
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      cardColor: lightBackgroundColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: lightTextColor,
        ),
        backgroundColor: lightBackgroundColor,
        centerTitle: true,
        titleTextStyle: lightTextTheme.headline2,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: lightNavBgColor,
        selectedIconTheme:
            IconThemeData(color: lightNavSelectedColor, size: 20),
        selectedLabelStyle: getLightStyle(
          color: lightNavSelectedTextColor,
          textSize: 10,
        ),
        unselectedItemColor: lightNavUnselectedColor,
        unselectedIconTheme: IconThemeData(
          color: lightNavUnselectedColor,
        ),
        unselectedLabelStyle: getLightStyle(
          color: lightNavUnselectedColor,
          textSize: 10,
        ),
        backgroundColor: lightNavBgColor,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightBackgroundColor,
        labelStyle: lightTextTheme.labelLarge,
        hintStyle: lightTextTheme.labelLarge,
        prefixStyle: lightTextTheme.labelLarge,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorStyle: getLightStyle(
          textSize: 14,
          color: Colors.red,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: lightHintColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: lightHintColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: lightTextTheme,
      dividerColor: lightDividerColor,
      backgroundColor: lightBackgroundColor,
      indicatorColor: lightButtonColor,
      disabledColor: lightButtonDisableColor,
      hintColor: lightHintColor,
    );
  }

  /// Application Dark Theme
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      cardColor: cardBackgroundColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: textColor,
        ),
        backgroundColor: backgroundColor,
        centerTitle: true,
        titleTextStyle: darkTextTheme.headline2,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: navBgColor,
        selectedIconTheme: IconThemeData(
          color: navSelectedColor,
          size: 20,
        ),
        selectedLabelStyle: getDarkStyle(
          color: navSelectedTextColor,
          textSize: 10,
        ),
        unselectedItemColor: navBgColor,
        unselectedIconTheme: IconThemeData(color: navUnselectedColor),
        unselectedLabelStyle: getDarkStyle(
          color: navUnselectedColor,
          textSize: 10,
        ),
        backgroundColor: navBgColor,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundColor,
        labelStyle: darkTextTheme.labelLarge,
        hintStyle: darkTextTheme.labelLarge,
        prefixStyle: darkTextTheme.labelLarge,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorStyle: getDarkStyle(
          textSize: 14,
          color: Colors.red,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: hintColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: hintColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: darkTextTheme,
      dividerColor: dividerColor,
      backgroundColor: backgroundColor,
      indicatorColor: buttonColor,
      disabledColor: buttonDisableColor,
      hintColor: hintColor,
    );
  }
}
