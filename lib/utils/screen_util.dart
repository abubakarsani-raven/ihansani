import 'package:flutter/material.dart';

class ScreenUtil {
  final BuildContext context;

  ScreenUtil(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  /// Scale a value based on the screen width.
  double scaleWidth(double value) => value * (screenWidth / 375); // 375 is a reference width.

  /// Scale a value based on the screen height.
  double scaleHeight(double value) => value * (screenHeight / 812); // 812 is a reference height.

  /// Get a percentage of the screen's width.
  double widthPercentage(double percentage) => screenWidth * (percentage / 100);

  /// Get a percentage of the screen's height.
  double heightPercentage(double percentage) => screenHeight * (percentage / 100);

  double scaleFontSize(double fontSize) {
    // Use screenWidth for scaling font size to ensure consistency across devices.
    return fontSize * (screenWidth / 375); // 375 is a reference width.
  }
}
