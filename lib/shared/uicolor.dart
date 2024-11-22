import 'package:flutter/material.dart';

class UIColor {
  //main color 
  static Color primary = const Color(0xFF02B4BF);
  static Color secondary = const Color(0xFF032b5f);
  static Color transparent = Colors.transparent;
  static Color black = const Color(0xFF000000);
  static Color white = const Color.fromARGB(255, 255, 255, 255);
  static Color daisyBush = const Color(0xFF4926AF);
  static Color blueBayoux = const Color(0xFF4E6882);
  static Color red = const Color(0xFFFF5038);
  static Color formField = const Color(0xFFE7ECF6);
  static Color disableIndicator = const Color(0xFFC8C8F9);
  static Color mirage = const Color(0xFF192129);
  static Color success = const Color(0xFF08BD5B);
  static Color sunsetOrange = const Color(0xFFFF5038); 
  static Color edward = const Color(0xFFA0B0AA); 
  static Color towerGray = const Color(0xFFA9BDBF); 
}

class UIGradient {
  static LinearGradient primaryGradient = LinearGradient(
      colors: [UIColor.primary, UIColor.secondary],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight);

  static LinearGradient secondaryKurumsalGradient = LinearGradient(
      colors: [UIColor.towerGray, UIColor.black],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight);

}
