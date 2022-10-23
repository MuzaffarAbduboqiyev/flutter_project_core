import 'package:flutter/material.dart';


// Application uchun kerakli ranglar
final backgroundColor = HexColor.fromHex("#000000");
final lightBackgroundColor = HexColor.fromHex("#FFFFFF");

final textColor = HexColor.fromHex("#FFFFFF");
final lightTextColor = HexColor.fromHex("#2B2B2B");

final hintColor = HexColor.fromHex("#8D8D91");
final lightHintColor = HexColor.fromHex("#5E5E5E");

final buttonColor = HexColor.fromHex("#FFCC66");
final lightButtonColor = HexColor.fromHex("#FFCC66");

final dividerColor = HexColor.fromHex("#333336");
final lightDividerColor = HexColor.fromHex("#E0E0E0");

final buttonDisableColor = HexColor.fromHex("#FFCC66").withOpacity(0.7);
final lightButtonDisableColor = HexColor.fromHex("#FFCC66");

final navBgColor = HexColor.fromHex("#000000");
final lightNavBgColor = HexColor.fromHex("#FFFFFF");

final navSelectedColor = HexColor.fromHex("#FFCC66");
final lightNavSelectedColor = HexColor.fromHex("#FFCC66");

final navUnselectedColor = HexColor.fromHex("#8D8D91");
final lightNavUnselectedColor = HexColor.fromHex("#5E5E5E");

final deliveredStatusColor = HexColor.fromHex("#88F79A");
final lightDeliveredStatusColor = HexColor.fromHex("#88F79A");

final canceledStatusColor = HexColor.fromHex("#FC8B74");
final lightCanceledStatusColor = HexColor.fromHex("#FC8B74");

final forgetPasswordColor = HexColor.fromHex("#2F80ED");
final lightForgetPasswordColor = HexColor.fromHex("#2F80ED");

final cardBackgroundColor = HexColor.fromHex("#1C1C1F");
final lightCardBackgroundColor = HexColor.fromHex("#F5F5F5");

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
