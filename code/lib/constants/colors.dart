import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF303841);
  static const gray = Color(0xFF777777);
  static const lightGray = Color(0xFFeeeeee);
  static const yellow = Color(0xFFF6C90E);
}