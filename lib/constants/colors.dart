import 'package:flutter/material.dart';

class AppColor {
  static const Color appBarColor = Colors.white;
  static const Color canvasColor = Color(0xfff8f9fa);

  static const Color cardBackgroundColor = Colors.white;
  static const Color cardShadowColor = Colors.black;
  static const Color primaryBlue = Color(0xff0078d4);
  static const Color primaryGrey = Colors.grey;
  static const Color primaryGreen = Color(0xff229954);
  static const Color primaryCyan = Color(0xff00a293);
  static const Color primaryRed = Color(0xffff6961);
  static const Color primaryOrange = Color(0xffD68910);
  static const Color lightGreen = Color(0xff52BE80);
  static const Color darkGreen = Color(0xff196F3D);
  static const Color primaryText = Colors.black;
  static const Color secondaryText = Colors.white;
  static const Color scaffoldBackgroundColor = Color(0xFF464667);
  static const Color accentCanvasColor = Color(0xFF3E3E61);
  static const Color actionColor = Color(0xFF5F5FA7);
  static const Color mapPolylineColor = Color(0xffD68910);

  static const Color primaryAppColor = primaryCyan;

  static const List<Color> gradientDefault = [
    Colors.transparent,
    Colors.transparent,
  ];

  static const List<Color> colorEsepPurple = const [
    Color(0xffda2b1b),
    Color(0xff4a12a3),
  ];

  static const List<Color> colorGreenDarkGreen = const [
    Color(0xffc3ff53),
    Color(0xff12a323),
  ];

  static const List<Color> colorOrangeDarkOrange = const [
    Color(0xffdacb1b),
    Color(0xff8e3802),
  ];

  static const List<Color> gradientOrange = const [
    Color(0xffff5673),
    Color(0xffff8c48),
  ];

  static const List<Color> gradientBlue = const [
    Color(0xff2dcef8),
    Color(0xff3b40fe),
  ];

  static const List<Color> gradientGreen = const [
    Color(0xff009dc5),
    Color(0xff21e590),
  ];

  static const List<Color> gradientPurple = const [
    Color(0xff832bf6),
    Color(0xffff4665),
  ];

  static const List<Color> gradientGrey = const [
    Color(0xff828a95),
    Color(0xff3b424c),
  ];

  static const List<Color> gradientWhite = const [
    Colors.white,
    canvasColor,
  ];

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
