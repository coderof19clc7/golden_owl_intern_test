import 'package:flutter/material.dart';

class Dimens {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
  static double getScreenWidthByPercent(BuildContext context, double percent) {
    return MediaQuery.sizeOf(context).width * percent;
  }
  static double getScreenHeightByPercent(BuildContext context, double percent) {
    return MediaQuery.sizeOf(context).height * percent;
  }
}